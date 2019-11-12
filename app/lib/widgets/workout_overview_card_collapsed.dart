import 'package:app/widgets/difficulty.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';

class WorkoutOverviewCardCollapsed extends StatelessWidget {
  const WorkoutOverviewCardCollapsed(
      {@required this.workout,
      @required this.handleExpand,
      @required this.animation});

  final Workout workout;
  final VoidCallback handleExpand;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {}
}
