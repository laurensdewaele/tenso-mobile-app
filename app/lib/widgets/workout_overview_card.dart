import 'package:app/widgets/workout_overview_card_collapsed.dart';
import 'package:app/widgets/workout_overview_card_expanded.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';

class WorkoutOverviewCard extends StatelessWidget {
  WorkoutOverviewCard({
    Key key,
    @required this.expanded,
    @required this.handleCollapse,
    @required this.handleExpand,
    @required this.handleStart,
    @required this.workout,
  }) : super(key: key);

  final bool expanded;
  final void Function(int) handleCollapse;
  final void Function(int) handleExpand;
  final void Function(int) handleStart;
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return expanded
        ? WorkoutOverviewCardExpanded(
            workout: workout,
            handleCollapse: handleCollapse,
            handleStart: handleStart)
        : WorkoutOverviewCardCollapsed(
            workout: workout, handleExpand: handleExpand);
  }
}
