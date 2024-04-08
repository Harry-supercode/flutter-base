import 'package:flutter/material.dart';

class PreferredDivider extends Divider implements PreferredSizeWidget {

  PreferredDivider({
    super.key,
    indent = 0.0,
    height = 1.0,
    color,
  })  : super(
          indent: indent,
          height: height,
          color: color,
        ) {
    // Do nothing
    // preferredSize = const Size(double.infinity, 1);
  }

  @override
  final Size preferredSize = const Size(double.infinity, 1);
}
