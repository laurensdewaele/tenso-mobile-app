import 'package:app/widgets/workout_overview_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Divider, Card;
import 'package:flutter/widgets.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/dividers.dart';
import 'package:app/widgets/screen.dart';

class WorkoutOverviewScreen extends StatefulWidget {
  WorkoutOverviewScreen({@required this.workouts});
  final List<Workout> workouts;

  @override
  _WorkoutOverviewScreenState createState() => _WorkoutOverviewScreenState();
}

class _WorkoutOverviewScreenState extends State<WorkoutOverviewScreen> {
  void _handleAddWorkout() {
    // TODO: Add workout.
  }

  void _handleDeleteTap(Workout workout) {
    // TODO: Delete from source.
    if (widget.workouts.contains(workout)) {
      setState(() {
        widget.workouts.remove(workout);
      });
    }
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
              return WorkoutOverviewStack(
                key: ObjectKey(widget.workouts[index]),
                workout: widget.workouts[index],
                handleDeleteTap: _handleDeleteTap,
              );
            } else if (index == widget.workouts.length) {
              return Button(
                  text: 'Add workout', handleClick: _handleAddWorkout);
            } else {
              return SizedBox(height: viewHeight / 2 - styles.Measurements.m);
            }
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
