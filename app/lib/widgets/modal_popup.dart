import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

Future<void> showAppModalPopup({
  @required BuildContext context,
  @required Widget content,
}) {
  return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => AppModal(
            content: content,
          ));
}

// Padding can not be generic. We can have buttons inside our modal.
// Buttons ideally need to be as big as possible.
class AppModal extends StatelessWidget {
  AppModal({Key key, @required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: styles.Colors.bgWhite,
            borderRadius: BorderRadius.only(
                topLeft: styles.kBorderRadius, topRight: styles.kBorderRadius)),
        child: content);
  }
}
