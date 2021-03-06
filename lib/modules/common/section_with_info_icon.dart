import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/modules/common/dialog.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/icon_button.dart';
import 'package:tenso_app/modules/common/icons.dart' as icons;
import 'package:tenso_app/styles/styles.dart' as styles;

class SectionWithInfoIcon extends StatelessWidget {
  SectionWithInfoIcon({
    Key key,
    @required this.title,
    @required this.appDialogContent,
    @required this.children,
    this.nextSectionHasInfoIcon = false,
  }) : super(key: key);

  final bool nextSectionHasInfoIcon;
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
                  showAppDialog(
                      barrierDismissible: true,
                      context: context,
                      content: appDialogContent,
                      smallWidth: false);
                },
                icon: icons.infoIconBlackL)
          ],
        ),
        Divider(
          height: styles.Measurements.l - styles.Measurements.kInfoIconSurplus,
        ),
        ...children,
        Divider(
            height: nextSectionHasInfoIcon == true
                ? styles.Measurements.xxl - styles.Measurements.kInfoIconSurplus
                : styles.Measurements.xxl),
      ],
    );
  }
}
