import 'package:app/widgets/workout_overview_collapsed.dart';
import 'package:app/widgets/workout_overview_expanded.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';

class WorkoutOverview extends StatefulWidget {
  WorkoutOverview({Key key, this.workout}) : super(key: key);

  final Workout workout;

  @override
  _CardOverviewState createState() => _CardOverviewState();
}

class _CardOverviewState extends State<WorkoutOverview> {
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

  @override
  Widget build(BuildContext context) {
    return collapsed
        ? WorkoutOverviewCollapsed(
            workout: widget.workout,
            handleExpand: _handleExpand,
          )
        : WorkoutOverviewExpanded(
            workout: widget.workout, handleCollapse: _handleCollapse);
  }
}
