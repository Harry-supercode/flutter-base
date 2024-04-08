import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constants/global_constant.dart';
import 'package:flutter_app/extensions/style_ext.dart';

class AlertPopup {
  final String title, msg;
  final String? confirmText, declinedText;
  final Function()? confirmAction;
  final DeclinedAction? declinedAction;

  AlertPopup(
      {this.confirmText,
      this.declinedText,
      this.confirmAction,
      required this.title,
      required this.msg,
      this.declinedAction});

  // Show popup
  showAlertPopup(BuildContext context) async {
    await showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              if (confirmText != null)
                CupertinoDialogAction(
                  onPressed: confirmAction,
                  child: Text(
                    confirmText!,
                    style: context.size14Red600,
                  ),
                ),
              CupertinoDialogAction(
                child: Text(
                  declinedText ?? "Cancel",
                  style: context.size14c037AA5w600,
                ),
                onPressed: () {
                  if (declinedAction == null) {
                    kPop(context);
                  } else {
                    declinedAction!();
                  }
                },
              )
            ],
          );
        });
  }
}

typedef DeclinedAction = Function();
