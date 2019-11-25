import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/models/workout_ui_configuration.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/dividers.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/screen.dart';

class NewWorkoutScreen extends StatelessWidget {
  NewWorkoutScreen({this.workoutSections});

  final List<WorkoutSection> workoutSections;

  @override
  Widget build(BuildContext context) {
    return Screen(
        gradientStartColor: styles.Colors.primary,
        gradientStopColor: styles.Colors.bgRedStop,
        child: Column(
          children: <Widget>[
            _TopNavigation(title: 'New workout'),
            Card(
              padding: EdgeInsets.symmetric(
                  horizontal: styles.Measurements.m,
                  vertical: styles.Measurements.l),
              child: Column(
                children: <Widget>[
                  ...workoutSections.map((WorkoutSection workoutSection) {
                    return Column(
                      children: <Widget>[
                        Text(workoutSection.title,
                            style: styles.Typography.title),
                        ...workoutSection.workoutElements
                            .map((WorkoutElement workoutElement) {
                          return Container();
                        }),
                        Divider(height: styles.Measurements.l)
                      ],
                    );
                  })
                ],
              ),
            )
          ],
        ));
  }
}

class _TopNavigation extends StatelessWidget {
  _TopNavigation({this.title});

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
          child: Icon(
            iconData: CupertinoIcons.back,
            color: styles.Colors.white,
          ),
        ),
      ]),
      Divider(height: styles.Measurements.xxl)
    ]);
  }
}
