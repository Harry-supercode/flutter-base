import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/common_bottom_sheet/bottom_sheet_widget.dart';
// import 'package:flutter_app/components/common_input.dart';
// import 'package:flutter_app/components/custom_radio_bool.dart';
import 'package:flutter_app/components/divider_widget.dart';
// import 'package:flutter_app/components/gradient_button.dart';
import 'package:flutter_app/constants/global_constant.dart';
import 'package:flutter_app/extensions/context_ext.dart';
import 'package:flutter_app/extensions/style_ext.dart';
import 'package:flutter_app/utils/color_utils.dart';

class CommonBottomSheetBool extends StatefulWidget {
  final String title;
  final List<ItemCommonBottomSheet> listItem;
  final EdgeInsetsGeometry? padding;
  final Function(ItemCommonBottomSheet) selectItem;
  final bool isVisibleSearch;
  final String? initValue;

  const CommonBottomSheetBool(
      {super.key,
      required this.title,
      required this.listItem,
      this.padding,
      this.initValue,
      required this.selectItem,
      this.isVisibleSearch = false});

  @override
  State<CommonBottomSheetBool> createState() => _CommonBottomSheetState();
}

class _CommonBottomSheetState extends State<CommonBottomSheetBool> {
  // search controller
  final _searchController = TextEditingController();

  // item name select
  ItemCommonBottomSheet? _itemSelect;

  // search list
  List<ItemCommonBottomSheet> _filterList = [];
  final List<ItemCommonBottomSheet> _masterDataList = [];

  @override
  void initState() {
    _filterList = widget.listItem
        .map((e) => ItemCommonBottomSheet.fromJson(e.toJson()))
        .toList();
    _masterDataList.addAll(_filterList);
    if (widget.initValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _itemSelect = _filterList.firstWhereOrNull((element) =>
            element.id.toString().toLowerCase() ==
            (widget.initValue ?? '').toLowerCase());
        if (_itemSelect != null) {
          _itemSelect!.isSelected = true;
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
                        bottom: context.height * 0.15,
                        top: 40),
                    shrinkWrap: true,
                    itemCount: _filterList.length,
                    itemBuilder: (context, index) {
                      final item = _filterList[index];
                      return _buildSingleChoiceItem(context, item);
                    }),
              ),
              const SizedBox(height: 40),
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
          //     kPop(context, arg: _itemSelect);
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
          //             _filterList = _masterDataList;
          //           } else {
          //             _filterList = _filterList
          //                 .where((element) => (element.value ?? '')
          //                     .toLowerCase()
          //                     .contains(value.toLowerCase()))
          //                 .toList();
          //           }
          //         });
          //       },
          //       prefixWidget: Image.asset('assets/icons/ic_search.png'),
          //       hintText: context.translate('search'),
          //       prefixIconConstraints: const BoxConstraints(
          //           maxWidth: 37, maxHeight: 17, minWidth: 37),
          //       controller: _searchController),
          // ),
        ],
      ),
    );
  }

  _buildSingleChoiceItem(BuildContext context, ItemCommonBottomSheet item) {
    return InkWell(
      onTap: () {
        onSelect(item);
      },
      child: const Padding(
        padding: EdgeInsets.only(bottom: 11),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // children: [
          //   Expanded(
          //     child: Text(
          //       item.value ?? '',
          //       style: context.size14Black600,
          //     ),
          //   ),
          //   CustomRadioBool(
          //     isChecked: item.isSelected ?? false,
          //     onChanged: (value) {
          //       onSelect(item);
          //     },
          //   ),
          // ],
        ),
      ),
    );
  }

  void onSelect(ItemCommonBottomSheet item) {
    setState(() {
      for (var element in _filterList) {
        element.isSelected = false;
      }
      _itemSelect = item;
      _itemSelect!.isSelected = true;
    });
  }
}
