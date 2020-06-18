import 'dart:ui';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:flutter/cupertino.dart' hide Icon;

class WorkoutLongPressDialog extends StatelessWidget {
  WorkoutLongPressDialog(
      {Key key,
      @required this.handleCopyTap,
      @required this.handleDeleteTap,
      @required this.name,
      @required this.isCompletedWorkout,
      this.handleEditTap,
      this.handleViewTap})
      : super(key: key);

  final bool isCompletedWorkout;
  final String name;
  final VoidCallback handleEditTap;
  final VoidCallback handleDeleteTap;
  final VoidCallback handleCopyTap;
  final VoidCallback handleViewTap;

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
        if (isCompletedWorkout == true)
          Button(
              text: 'View',
              backgroundColor: styles.Colors.gray,
              displayBackground: true,
              leadingIcon: icons.searchIconWhiteXl,
              handleTap: handleViewTap,
              leadingIconTextCentered: true),
        if (isCompletedWorkout == false)
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
