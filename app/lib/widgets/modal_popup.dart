import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

Future<void> showAppModalPopup({
  @required BuildContext context,
  @required Widget content,
}) {
  return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => _AppModal(
            content: content,
          ));
}

class _AppModal extends StatelessWidget {
  _AppModal({Key key, @required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: styles.Colors.bgWhite,
            borderRadius: BorderRadius.only(
                topLeft: styles.kBorderRadius, topRight: styles.kBorderRadius)),
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: styles.Measurements.xs,
                vertical: styles.Measurements.xs),
            child: content));
  }
}
