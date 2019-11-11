import 'package:app/widgets/workout_overview_card_collapsed.dart';
import 'package:app/widgets/workout_overview_card_expanded.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';

class WorkoutOverviewCard extends StatefulWidget {
  WorkoutOverviewCard({Key key, this.workout}) : super(key: key);

  final Workout workout;

  @override
  _CardOverviewState createState() => _CardOverviewState();
}

class _CardOverviewState extends State<WorkoutOverviewCard> {
  bool collapsed = true;

  void toggle() {
    setState(() {
      collapsed = !collapsed;
    });
  }

  void _handleExpand() {
    toggle();
  }

  void _handleCollapse() {
    toggle();
  }

  void _handleStart() {
    print('start!');
  }

  @override
  Widget build(BuildContext context) {
    return collapsed
        ? WorkoutOverviewCardCollapsed(
            workout: widget.workout,
            handleExpand: _handleExpand,
          )
        : WorkoutOverviewCardExpanded(
            workout: widget.workout,
            handleCollapse: _handleCollapse,
            handleStart: _handleStart);
  }
}
