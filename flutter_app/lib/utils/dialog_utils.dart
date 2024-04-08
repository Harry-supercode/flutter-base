import 'package:flutter/material.dart';
import 'package:flutter_app/extensions/context_ext.dart';
import 'package:flutter_app/extensions/style_ext.dart';
import 'package:flutter_app/utils/color_utils.dart';

class DialogUtils {
  static Future showCustomBottomSheet({
    required BuildContext context,
    required Widget child,
    Function? onClosed,
    EdgeInsets? padding,
  }) {
    /// IMPORTANT
    /// If you want height auto wrap by content, you need add mainAxisSize: MainAxisSize.min to Column in child

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), topLeft: Radius.circular(40)),
      ),
      constraints: BoxConstraints(maxHeight: context.height * 0.95),
      builder: (builderContext) {
        return Container(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: HexColor('#D9D9D9')),
                  height: 6,
                  width: 60,
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              Flexible(
                child: SingleChildScrollView(child: child),
              )
            ],
          ),
        );
      },
    ).whenComplete(() {
      if (onClosed != null) {
        onClosed();
      }
    });
  }

  static Future showBottomSheetRadio(
      {required BuildContext context, required Widget child}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40), topLeft: Radius.circular(40)),
        ),
        constraints: BoxConstraints(maxHeight: context.height * 0.95),
        builder: (context) => child);
  }

  static showCusTomDiaLog(BuildContext context, String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Submit Fail'),
          content: Text(content, style: context.size14Black400),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
