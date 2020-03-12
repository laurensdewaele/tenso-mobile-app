import 'package:flutter/cupertino.dart';

Future<void> showAppModalPopup({
  @required BuildContext context,
  @required Widget content,
}) {
  return showCupertinoModalPopup(
      context: context, builder: (BuildContext context) => content);
}
