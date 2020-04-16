import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icon_button.dart';
import 'package:app/widgets/icons.dart' as icons;

class SectionWithInfoIcon extends StatelessWidget {
  SectionWithInfoIcon(
      {Key key,
      @required this.title,
      @required this.appDialogContent,
      @required this.children})
      : super(key: key);

  final String title;
  final Widget appDialogContent;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: styles.Staatliches.xlBlack,
            ),
            IconButton(
                handleTap: () {
                  showAppDialog(context: context, content: appDialogContent);
                },
                icon: icons.infoIconBlackL)
          ],
        ),
        Divider(
          height: 14,
        ),
        ...children,
        Divider(
          height: styles.Measurements.xxl,
        ),
      ],
    );
  }
}
