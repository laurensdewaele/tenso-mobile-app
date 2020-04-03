import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/models/models.dart';
import 'package:app/widgets/workout_overview/completed_expanded_content.dart';
import 'package:app/widgets/workout_overview/expanded_content.dart';

class WorkoutOverviewCardExpanded extends StatelessWidget {
  WorkoutOverviewCardExpanded({
    Key key,
    this.workout,
    this.completedWorkout,
    this.handleStart,
  }) : super(key: key);

  final Workout workout;
  final CompletedWorkout completedWorkout;
  final VoidCallback handleStart;

  @override
  Widget build(BuildContext context) {
    final bool _isCompletedWorkout = completedWorkout != null;
    return _isCompletedWorkout == true
        ? CompletedExpandedWorkoutContent(
            completedWorkout: completedWorkout)
        : WorkoutExpandedContent(
            handleStart: handleStart,
            workout: workout,
          );
  }
}
