import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/divider.dart';

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
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Text(title,
                  style: styles.Typography.topNavigationTitle,
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => _handleTap(context),
          child: Container(
            width: styles.Measurements.xxl,
            child: Icon(
              iconData: CupertinoIcons.back,
              color: styles.Colors.white,
            ),
          ),
        ),
      ]),
      Divider(height: styles.Measurements.xxl)
    ]);
  }
}
