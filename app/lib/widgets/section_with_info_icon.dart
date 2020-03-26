import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/icon_button.dart';

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
                icon: Icon(
                  size: 28,
                  iconData: IconData(0xf44c,
                      fontFamily: 'CupertinoIcons',
                      fontPackage: 'cupertino_icons'),
                  color: styles.Colors.black,
                ))
          ],
        ),
        Divider(
          height: 12,
        ),
        ...children,
        Divider(
          height: styles.Measurements.xxl,
        ),
      ],
    );
  }
}
