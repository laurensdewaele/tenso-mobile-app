import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:app/data/interfaces.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/dividers.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/workout_overview_card.dart';

class WorkoutOverviewScreen extends StatefulWidget {
  WorkoutOverviewScreen({@required this.workouts});
  final List<Workout> workouts;

  void _handleAddWorkout() {
    print('Add workout!');
  }

  @override
  _WorkoutOverviewScreenState createState() => _WorkoutOverviewScreenState();
}

class _WorkoutOverviewScreenState extends State<WorkoutOverviewScreen> {
  List<int> expandedHashCodes = [];

  void _handleCollapse(int hashCode) {
    setState(() {
      expandedHashCodes.remove(hashCode);
    });
  }

  void _handleExpand(int hashCode) {
    setState(() {
      expandedHashCodes.add(hashCode);
    });
  }

  void _handleStart(int hashCode) {
    print('starting workout on $hashCode');
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double viewHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;

    return Screen(
        gradientStartColor: styles.Colors.bgGrayStart,
        gradientStopColor: styles.Colors.bgGrayStop,
        child: ListView.separated(
          itemCount: widget.workouts.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index < widget.workouts.length) {
              return WorkoutOverviewCard(
                  workout: widget.workouts[index],
                  handleCollapse: _handleCollapse,
                  handleExpand: _handleExpand,
                  handleStart: _handleStart,
                  expanded: expandedHashCodes
                          .contains(widget.workouts[index].hashCode)
                      ? true
                      : false);
            } else if (index == widget.workouts.length) {
              return Button(
                  text: 'Add workout', handleClick: widget._handleAddWorkout);
            } else {
              return SizedBox(height: viewHeight / 2 - styles.Measurements.m);
            }
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
