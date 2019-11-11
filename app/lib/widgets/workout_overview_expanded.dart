import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';
import 'package:app/widgets/card.dart';

class WorkoutOverviewExpanded extends StatelessWidget {
  const WorkoutOverviewExpanded(
      {@required this.workout, @required this.handleCollapse});

  final Workout workout;
  final VoidCallback handleCollapse;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleCollapse,
        child: Card(child: Text('$workout.title, expanded')));
  }
}
