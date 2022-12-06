import 'package:flutter/cupertino.dart';

class AppNav {
  //Push
  static cupertinoPush({required BuildContext context, required Widget route}) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
  }

  //Push Replacement
  static cupertinoPushReplacement(
      {required BuildContext context, required Widget route}) {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (BuildContext context) => route));
  }

  //Push and Remove Until
  static cupertinoPushAndRemoveUntil(
      {required BuildContext context, required Widget route}) {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => route), (route) => false);
  }

  //Pop
  static cupertinoPop({required BuildContext context}) {
    Navigator.pop(context);
  }
}
