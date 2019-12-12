import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/icon_button.dart';

class TopNavigation extends StatelessWidget {
  TopNavigation({this.title});

  final String title;

  void _handleTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Stack(children: [
        Row(
          children: [
            GestureDetector(
                onTap: () => _handleTap(context),
                child: IconButton(
                  padding: EdgeInsets.fromLTRB(
                      styles.Measurements.xs,
                      styles.Measurements.m,
                      styles.Measurements.m,
                      styles.Measurements.m),
                  handleTap: () => _handleTap(context),
                  icon: Icon(
                    iconData: CupertinoIcons.back,
                    color: styles.Colors.white,
                  ),
                ))
          ],
        ),
        Positioned.fill(
          child: Center(
            child: Text(title,
                style: styles.Typography.topNavigationTitle,
                textAlign: TextAlign.center),
          ),
        ),
      ]),
    ]);
  }
}
