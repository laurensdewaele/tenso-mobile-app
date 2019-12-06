import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/icon.dart';

class Tabs extends StatelessWidget {
  Tabs(
      {Key key,
      this.handleBackNavigation,
      this.handleForwardNavigation,
      this.amount,
      this.active})
      : super(key: key);

  final Function(int currentTab) handleBackNavigation;
  final Function(int currentTab) handleForwardNavigation;
  final int amount;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
            iconData: IconData(0xf3cf,
                fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
            size: styles.Measurements.l,
            color: styles.Colors.primary),
        Icon(
            iconData: IconData(0xf3d1,
                fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
            size: styles.Measurements.l,
            color: styles.Colors.primary)
      ],
    );
  }
}
