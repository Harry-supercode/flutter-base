import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:flutter_app/components/common_input.dart';
// import 'package:flutter_app/components/custom_radio.dart';
import 'package:flutter_app/components/divider_widget.dart';
// import 'package:flutter_app/components/gradient_button.dart';
import 'package:flutter_app/constants/global_constant.dart';
import 'package:flutter_app/extensions/context_ext.dart';
import 'package:flutter_app/extensions/style_ext.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:collection/collection.dart';

class ItemCommonBottomSheet {
  String? value;
  bool? isSelected;
  dynamic id;
  int? startAge;
  int? endAge;

  ItemCommonBottomSheet(
      {this.value,
      this.id,
      this.isSelected = false,
      this.startAge,
      this.endAge});

  ItemCommonBottomSheet.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    isSelected = json['isSelected'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['value'] = value;
    map['isSelected'] = isSelected;
    map['id'] = id;
    return map;
  }
}

class CommonBottomSheet extends StatefulWidget {
  final String title;
  final List<ItemCommonBottomSheet> listItem;
  final EdgeInsetsGeometry? padding;
  final Function(ItemCommonBottomSheet) selectItem;
  final bool isVisibleSearch;
  final String? initValue;

  const CommonBottomSheet(
      {super.key,
      required this.title,
      required this.listItem,
      this.padding,
      this.initValue,
      required this.selectItem,
      this.isVisibleSearch = false});

  @override
  State<CommonBottomSheet> createState() => _CommonBottomSheetState();
}

class _CommonBottomSheetState extends State<CommonBottomSheet> {
  // search controller
  final _searchController = TextEditingController();

  // group value
  int _groupRadio = -1;

  // item name select
  ItemCommonBottomSheet? _itemSelect;

  // search list
  List<ItemCommonBottomSheet> _filterList = [];

  @override
  void initState() {
    _filterList = widget.listItem;
    if (widget.initValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _itemSelect = _filterList.firstWhereOrNull((element) =>
            element.id.toString().toLowerCase() ==
            (widget.initValue ?? '').toLowerCase());
        if (_itemSelect != null) {
          _groupRadio = _filterList.indexOf(_itemSelect!);
        }
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    // Release controllers
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // MARK: Header
              _sheetHeader(context),
              // MARK: List single choice
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                    padding: EdgeInsets.only(
                        left: 38,
                        right: 38,
                        bottom: context.height * 0.2,
                        top: 30),
                    shrinkWrap: true,
                    itemCount: _filterList.length,
                    itemBuilder: (context, index) {
                      return _buildSingleChoiceItem(
                          context, index, _filterList);
                    }),
              ),
            ],
          ),
          Positioned(
              bottom: 0, left: 0, right: 0, child: _buildBottomButton(context))
        ],
      ),
    );
  }

  // Create footer button
  _buildBottomButton(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          color: Colors.white.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          // child: GradientButton(
          //   margin: const EdgeInsets.only(bottom: 20),
          //   content: context.translate('select'),
          //   onPressed: () {
          //     if (_itemSelect != null) {
          //       widget.selectItem(_itemSelect!);
          //     }
          //     kPop(context);
          //   },
          // ),
        ),
      ),
    );
  }

  _sheetHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: widget.padding ??
                const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: HexColor('#D9D9D9')),
                height: 6,
                width: 60,
              ),
            ),
          ),
          Text(
            context.translate(widget.title),
            style: context.size14Black400,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: DividerCommon(),
          ),
          // Visibility(
          //   visible: widget.isVisibleSearch,
          //   child: CommonInput(
          //       onChanged: (value) {
          //         setState(() {
          //           if (value.isEmpty) {
          //             _filterList = widget.listItem;
          //           } else {
          //             _filterList = widget.listItem
          //                 .where((element) => (element.value ?? '')
          //                     .toLowerCase()
          //                     .contains(value.toLowerCase()))
          //                 .toList();
          //           }
          //         });
          //       },
          //       suffixWidget: Image.asset('assets/icons/ic_search.png'),
          //       hintText: context.translate('search'),
          //       prefixIconConstraints: const BoxConstraints(
          //           maxWidth: 37, maxHeight: 17, minWidth: 37),
          //       title: context.translate('search'),
          //       controller: _searchController),
          // ),
        ],
      ),
    );
  }

  _buildSingleChoiceItem(
      BuildContext context, int index, List<ItemCommonBottomSheet> list) {
    return InkWell(
      onTap: () {
        setState(() {
          _groupRadio = index;
          _itemSelect = list[index];
        });
      },
      child: const Padding(
        padding: EdgeInsets.only(bottom: 11),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // children: [
          //   Expanded(
          //     child: Text(
          //       list[index].value ?? '',
          //       style: context.size14Black600,
          //     ),
          //   ),
          //   CustomRadio(
          //     value: index,
          //     groupValue: _groupRadio,
          //     onChanged: (value) {
          //       setState(() {
          //         _groupRadio = value;
          //         _itemSelect = list[index];
          //       });
          //     },
          //   ),
          // ],
        ),
      ),
    );
  }
}
