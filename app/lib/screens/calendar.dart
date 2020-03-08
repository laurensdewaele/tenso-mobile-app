import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/data/completed_workout.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/calendar/calendar.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';

// TODO: Screen and KeyboardScreen should be refactored
class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
        gradientStartColor: styles.Colors.bgGrayStart,
        gradientStopColor: styles.Colors.bgGrayStop,
        child: ListView(physics: ClampingScrollPhysics(), children: [
          Column(
            children: <Widget>[
              TopNavigation(
                title: 'calendar',
                dark: true,
              ),
              Divider(height: styles.Measurements.xxl),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: styles.Measurements.m,
                        vertical: styles.Measurements.l),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // TODO: Implement real completedWorkouts
                      children: [
                        Calendar(
                          completedWorkouts: completedWorkouts,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ]));
  }
}
