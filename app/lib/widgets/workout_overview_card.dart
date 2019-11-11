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
    @required this.workout,
  }) : super(key: key);

  final bool expanded;
  final void Function(int) handleCollapse;
  final void Function(int) handleExpand;
  final Workout workout;

  void _handleStart() {
    print('start!');
  }

  @override
  Widget build(BuildContext context) {
    return expanded
        ? WorkoutOverviewCardExpanded(
            workout: workout,
            handleCollapse: handleCollapse,
            handleStart: _handleStart)
        : WorkoutOverviewCardCollapsed(
            workout: workout, handleExpand: handleExpand);
  }
}
