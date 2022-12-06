import 'package:etiqa_app/helper/navigation.dart';
import 'package:flutter/cupertino.dart';

class Modal {
  static Future<void> actionModal({
    required BuildContext context,
    required String title,
    required Widget content,
    required void Function() onConfirm,
    void Function()? onCancel,
    Widget? confirm,
    Widget? cancel,
  }) async {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: content,
          actions: [
            CupertinoDialogAction(
              child: cancel ??
                  const Text(
                    'No',
                  ),
              onPressed: onCancel ?? () => AppNav.cupertinoPop(context: context),
            ),
            CupertinoDialogAction(
              child: confirm ??
                 const Text(
                    'Yes',
                  ),
              onPressed: onConfirm,
              isDefaultAction: true,
            )
          ],
        );
      },
    );
  }
}
