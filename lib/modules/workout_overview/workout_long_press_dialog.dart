import 'dart:ui';

import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/modules/common/button.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/icons.dart' as icons;
import 'package:tenso_app/styles/styles.dart' as styles;

class WorkoutLongPressDialog extends StatelessWidget {
  WorkoutLongPressDialog({
    Key key,
    @required this.handleCopyTap,
    @required this.handleDeleteTap,
    @required this.name,
    this.handleEditTap,
  }) : super(key: key);

  final String name;
  final VoidCallback handleEditTap;
  final VoidCallback handleDeleteTap;
  final VoidCallback handleCopyTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          name,
          style: styles.Staatliches.lBlack,
        ),
        Divider(height: styles.Measurements.l),
        Button(
            text: 'Edit',
            backgroundColor: styles.Colors.blue,
            displayBackground: true,
            leadingIcon: icons.editIconWhiteXl,
            handleTap: () {
              Navigator.of(context).pop();
              handleEditTap();
            },
            leadingIconTextCentered: true),
        Divider(height: styles.Measurements.m),
        Button(
            text: 'Copy',
            backgroundColor: styles.Colors.turquoise,
            displayBackground: true,
            leadingIcon: icons.copyIconWhiteXl,
            handleTap: () {
              Navigator.of(context).pop();
              handleCopyTap();
            },
            leadingIconTextCentered: true),
        Divider(height: styles.Measurements.m),
        Button(
            text: 'Delete',
            backgroundColor: styles.Colors.primary,
            displayBackground: true,
            leadingIcon: icons.deleteIconWhiteXl,
            handleTap: () {
              Navigator.of(context).pop();
              handleDeleteTap();
            },
            leadingIconTextCentered: true),
        Divider(height: styles.Measurements.l),
        Button(
            displayBackground: false,
            text: 'Back',
            handleTap: Navigator.of(context).pop,
            small: true)
      ],
    );
  }
}
