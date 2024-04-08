import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
// import 'package:techedge_sport/components/custom_dropdown/custom_dropdown.dart';
import 'package:flutter_app/components/dialogs/alert_dialog.dart';
// import 'package:techedge_sport/components/gradient_button.dart';
import 'package:flutter_app/constants/global_constant.dart';
import 'package:flutter_app/extensions/context_ext.dart';
import 'package:flutter_app/extensions/style_ext.dart';
import 'package:flutter_app/models/file/file_model.dart';
import 'package:flutter_app/models/file/image_entity_model.dart';
import 'package:flutter_app/services/dio_token.dart';
import 'package:flutter_app/shared_pref_services.dart';
import 'package:uuid/uuid.dart';

enum FileSelected { single, multi }

class GridGallery extends StatefulWidget {
  // Upload types
  static const String event = 'event';
  static const String sport = 'sport';
  static const String avatar = 'avatar';
  static const String userAvatar = 'user_avatar';
  static const String teamAvatarImage = 'team_avatar_image';
  static const String teamBackground = 'team_background';
  static const String userBackgroundImage = 'user_background_image';

  // Scroll controller
  final ScrollController? scrollCtr;

  // OnSelected
  final Function(File)? onSelected;

  // Selected type
  final FileSelected? type;

  // Upload type (event, sport, avatar, user_avatar, team_avatar_image, team_background, user_background_image)
  final String? uploadType;

  // Constructor
  const GridGallery(
      {super.key,
      this.scrollCtr,
      this.onSelected,
      this.uploadType = event,
      this.type = FileSelected.multi});

  @override
  _GridGalleryState createState() => _GridGalleryState();
}

class _GridGalleryState extends State<GridGallery> {
  /// List widgets to render images
  final List<Widget> _mediaList = [];

  /// List [ImageEntity] to handle images selection state
  final List<ImageEntity> _imgEntities = [];

  /// List [FileModel] to store image files
  final List<FileModel> _selectedImages = [];

  /// Album list
  List<AssetPathEntity> _albums = [];

  /// Value notifier for radio only
  ValueNotifier<int> currentSelected = ValueNotifier(-1);

  /// Page position to handle pagination for gallery
  int currentPage = 0;

  /// Last page of gallery
  int? lastPage;

  /// Album selected index
  final int _albumIndex = 0;

  /// [Loading] flag
  bool _isLoading = false;

  /// Permission state [PermissionState]
  PermissionState? _ps;

  // Get permission images
  _getPermissionImages() async {
    final prefs = await SharedPreferencesService.instance;
    if (!prefs.isAccessLimited) {
      _ps = await PhotoManager.requestPermissionExtend();
      if (_ps == PermissionState.denied) {
        AlertPopup(
                title: 'You are disable access image',
                msg:
                    'To add more images, please go to your setting and allow App to access images',
                confirmText: 'Cancel',
                confirmAction: () {
                  kPop(context);
                  kPop(context);
                },
                declinedAction: () => PhotoManager.openSetting(),
                declinedText: 'Open setting')
            .showAlertPopup(context);
      }
    } else {
      _ps = PermissionState.limited;
    }
    // Fetch album from device
    _fetchNewMedia(_albumIndex);
  }

  @override
  void initState() {
    super.initState();
    // Get permission
    _getPermissionImages();
  }

  // Handle scrolling events
  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia(_albumIndex);
      }
    }
  }

  /// Add more photos with iOS 14+
  Widget _addMorePhotos(BuildContext context) {
    // Not display this view at Android platform
    if (Platform.isAndroid) {
      return const SizedBox();
    }
    // Check version of iOS (display this view with iOS version greater than 14)
    final version =
        double.tryParse(Platform.operatingSystemVersion.split(' ')[1]) ?? 0.0;
    debugPrint(
        'Version: $version - ${Platform.operatingSystemVersion.split(' ')[1]}');
    // Display with version iOS 14+
    if (version < 14) {
      return const SizedBox();
    }

    // Display when permission is limited only
    if (_ps != PermissionState.limited) {
      return const SizedBox();
    }

    // Display header view to warning user when they select limited media
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
            context.translate('limited_access_image'),
            style: context.size12Black400,
          )),
          const SizedBox(
            height: 4,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
                onTap: () async {
                  currentPage = 0;
                  _mediaList.clear();
                  await PhotoManager.presentLimited();
                  await _fetchNewMedia(0);
                },
                child: Text(
                  context.translate('add_more_photo_limited'),
                  style:
                      context.size16Black400.copyWith(color: Colors.blueAccent),
                )),
          ),
        ],
      ),
    );
  }

  /// Fetch media
  /// This is [Future] function
  ///
  /// Render [Image] items based on media list
  Future<void> _fetchNewMedia(int albumIdx) async {
    lastPage = currentPage;
    if (_ps != null && (_ps!.isAuth || _ps == PermissionState.limited)) {
      // Success
      // Load the album list
      setState(() {
        _isLoading = true;
      });
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(type: RequestType.image);
      // If albums is empty (return blank)
      if (albums.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      // Set albums to display filter dropdown
      _albums = albums;
      // Load media based on pageSize and current album
      List<AssetEntity> media = await _albums[_albumIndex].getAssetListPaged(
        size: 15,
        page: currentPage,
      ); //preloading files
      if (media.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      if (kDebugMode) {
        print(media);
      }
      // Widgets (Image item)
      List<Widget> temp = [];
      if (widget.type == FileSelected.multi) {
        await _multiSelectUI(context, temp, media);
      } else {
        await _singleSelectUI(context, temp, media);
      }
      setState(() {
        _mediaList.addAll(temp);
        currentPage++;
        _isLoading = false;
      });
    } else {
      // fail
      /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
      setState(() {
        _isLoading = false;
      });
    }
  }

  ///
  /// Get [FileModel] after selected/unselect images
  ///
  _getFile(FileModel fileModel) async {
    if (fileModel.isSelected) {
      setState(() {
        _selectedImages.add(fileModel);
      });
    } else {
      setState(() {
        _selectedImages.remove(fileModel);
      });
    }
  }

  ///
  /// Get [FileModel] after single select images
  ///
  _getFileSingle(FileModel fileModel) async {
    _selectedImages.clear();
    _selectedImages.add(fileModel);
  }

  // Render UI base on SelectedType.multi
  _multiSelectUI(
      BuildContext context, List<Widget> temp, List<AssetEntity> media) async {
    // Prepare image to the list
    for (var asset in media) {
      // Image Entity
      final file = await asset.file;
      final fileModel = FileModel(
          id: const Uuid().v4(),
          file: file,
          isSelected: false,
          uploadType: widget.uploadType ?? GridGallery.event,
          cancelToken: Token().cancelToken,
          status: UploadStatus.init);
      final entity = ImageEntity(entity: asset, isSelected: false);
      _imgEntities.add(entity);
      // Add widget to grid
      temp.add(
        FutureBuilder(
          future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
          //resolution of thumbnail
          builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return StatefulBuilder(builder: (context, setStateCb) {
                return GestureDetector(
                  onTap: () {
                    // Update state checkbox
                    setStateCb(() {
                      entity.isSelected = !entity.isSelected;
                      fileModel.isSelected = !fileModel.isSelected;
                    });
                    // Add selected file to list
                    _getFile(fileModel);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (asset.type == AssetType.image)
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 6, right: 6),
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xffA3A3A3),
                                        width: 1)),
                                child: Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor: Colors.white),
                                  child: Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: const CircleBorder(),
                                      // fillColor: MaterialStateProperty.all(Colors.white),
                                      // visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                      value: entity.isSelected,
                                      onChanged: (value) {
                                        // Update state checkbox
                                        setStateCb(() {
                                          entity.isSelected = value as bool;
                                          fileModel.isSelected = value;
                                        });
                                        // Add selected file to list
                                        _getFile(fileModel);
                                      }),
                                ),
                              )),
                        )
                    ],
                  ),
                );
              });
            }
            return const SizedBox();
          },
        ),
      );
    }
  }

  // Render UI base on SelectedType.multi
  _singleSelectUI(
      BuildContext context, List<Widget> temp, List<AssetEntity> media) async {
    // Prepare image to the list
    for (int i = 0; i < media.length; i++) {
      var asset = media[i];
      // Image Entity
      final file = await asset.file;
      final fileModel = FileModel(
          id: const Uuid().v4(),
          file: file,
          uploadType: widget.uploadType ?? GridGallery.event,
          isSelected: false,
          cancelToken: Token().cancelToken,
          status: UploadStatus.init);
      final entity = ImageEntity(entity: asset, isSelected: false);
      _imgEntities.add(entity);
      // Add widget to grid
      temp.add(
        FutureBuilder(
          future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
          //resolution of thumbnail
          builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ValueListenableBuilder(
                valueListenable: currentSelected,
                builder: (BuildContext context, int value, Widget? child) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentSelected.value = i;
                        // Add selected file to list
                        _getFileSingle(fileModel);
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (asset.type == AssetType.image)
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 6, right: 6),
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: const Color(0xffA3A3A3),
                                          width: 1)),
                                  child: Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: Colors.white),
                                    child: Radio(
                                        value: i,
                                        groupValue: value,
                                        onChanged: (ind) {
                                          setState(() {
                                            currentSelected.value = ind as int;
                                            // Get file
                                            _getFileSingle(fileModel);
                                          });
                                        }),
                                  ),
                                )),
                          )
                      ],
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scroll notify to render more items
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll) {
        _handleScrollEvent(scroll);
        return false;
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: Colors.white,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Colors.white,
                      child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () => Navigator.pop(context),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          )),
                    ),
                    // Expanded(child: _dropDownFilter(context)),
                    Material(
                      color: Colors.white,
                      child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () async {
                            ImagePicker picker = ImagePicker();
                            // Capture a photo
                            final result = await picker.pickImage(
                                source: ImageSource.camera);
                            if (result != null) {
                              _selectedImages.clear();
                              _selectedImages.add(FileModel(
                                  id: const Uuid().v4(),
                                  file: File(result.path),
                                  isSelected: false,
                                  uploadType:
                                      widget.uploadType ?? GridGallery.event,
                                  cancelToken: Token().cancelToken,
                                  status: UploadStatus.init));
                              Navigator.pop(context, _selectedImages);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              'assets/icons/ic_camera.svg',
                              width: 23,
                              height: 23,
                            ),
                          )),
                    ),
                  ],
                ),
              ),

              /// MARK: Add more photo (iOS 14+ only)
              _addMorePhotos(context),

              /// MARK: [GridView] UI
              Expanded(
                child: GridView.builder(
                    controller: widget.scrollCtr,
                    padding: EdgeInsets.only(bottom: context.height * 0.2),
                    itemCount: _mediaList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6),
                    itemBuilder: (BuildContext context, int index) {
                      return _mediaList[index];
                    }),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Visibility(
                visible: _isLoading,
                child: Container(
                  margin: EdgeInsets.only(top: context.height * 0.3),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  color: Colors.transparent,
                  child: const CupertinoActivityIndicator(
                    color: Colors.pinkAccent,
                  ),
                )),
          ),
          // Positioned(
          //     bottom: 0,
          //     left: 0,
          //     right: 0,
          //     child: Visibility(
          //         visible: _selectedImages.isNotEmpty,
          //         child: _buildBottomButton(context)))
        ],
      ),
    );
  }

  // Dropdown to select album
  // Widget _dropDownFilter(BuildContext context) {
  //   return SizedBox(
  //     height: 40,
  //     child: CustomDropdown<String>(
  //       dropdownStyle: const DropdownStyle(side: BorderSide.none),
  //       isWrapDropDown: true,
  //       icon: const Icon(
  //         Icons.keyboard_arrow_down_rounded,
  //         color: ColorRes.black,
  //         size: 30,
  //       ),
  //       items: [
  //         ...List.generate(
  //             _albums.length,
  //             (index) => DropdownItem<String>(
  //                   isHover: (isHover) {},
  //                   value: _albums[index].name,
  //                   child: Container(
  //                     color: Colors.transparent,
  //                     padding: const EdgeInsets.all(8),
  //                     child: Text(_albums[index].name,
  //                         style: context.size14Black400
  //                         //context.size14Black400,
  //                         ),
  //                   ),
  //                 ))
  //       ],
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Text(
  //           _albums.isNotEmpty ? _albums[_albumIndex].name : 'Albums',
  //           style: context.size14Black400,
  //         ),
  //       ),
  //       onChange: (data, index) async {
  //         setState(() {
  //           currentPage = 0;
  //           _albumIndex = index;
  //           _mediaList.clear();
  //         });
  //         // Refresh media by album selected
  //         _fetchNewMedia(index);
  //       },
  //     ),
  //   );
  // }

  // Create footer button
  // _buildBottomButton(BuildContext context) {
  //   return ClipRRect(
  //     child: BackdropFilter(
  //       filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
  //       child: Container(
  //         color: Colors.white.withOpacity(0.6),
  //         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
  //         child: GradientButton(
  //             margin: const EdgeInsets.only(bottom: 20),
  //             content: context.translate('done'),
  //             onPressed: () => Navigator.pop(context, _selectedImages)),
  //       ),
  //     ),
  //   );
  // }
}
