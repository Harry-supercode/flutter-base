import 'package:flutter/material.dart';
import 'package:flutter_app/constants/color_res.dart';

class DividerCommon extends StatelessWidget {
  final double? indent;
  // Constructor
  const DividerCommon({super.key, this.indent});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: ColorRes.divider,
      thickness: 1,
      indent: indent,
      endIndent: indent,
    );
  }
}
