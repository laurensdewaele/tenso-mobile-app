import 'dart:ui';

import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/icons.dart' as icons;

class WorkoutLongPressDialog extends StatelessWidget {
  WorkoutLongPressDialog(
      {Key key,
      @required this.handleCopyTap,
      @required this.handleDeleteTap,
      @required this.name,
      this.onWorkoutOverviewScreen = false,
      this.onCompletedWorkoutsOverviewScreen = false,
      this.onCompletedWorkoutScreen = false,
      this.handleEditTap,
      this.handleViewTap})
      : super(key: key);

  final bool onCompletedWorkoutsOverviewScreen;
  final bool onWorkoutOverviewScreen;
  final bool onCompletedWorkoutScreen;
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
        if (onCompletedWorkoutsOverviewScreen == true)
          Button(
              text: 'View',
              backgroundColor: styles.Colors.gray,
              displayBackground: true,
              leadingIcon: icons.searchIconWhiteXl,
              handleTap: () {
                Navigator.of(context).pop();
                handleViewTap();
              },
              leadingIconTextCentered: true),
        if (onCompletedWorkoutScreen == true)
          Button(
              text: 'View params',
              backgroundColor: styles.Colors.gray,
              displayBackground: true,
              leadingIcon: icons.searchIconWhiteXl,
              handleTap: () {
                Navigator.of(context).pop();
                handleViewTap();
              },
              leadingIconTextCentered: true),
        if (onWorkoutOverviewScreen == true)
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
