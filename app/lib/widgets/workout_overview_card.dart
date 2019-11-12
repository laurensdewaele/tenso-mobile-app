import 'package:app/widgets/workout_overview_card_collapsed.dart';
import 'package:app/widgets/workout_overview_card_expanded.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';

class WorkoutOverviewCard extends StatefulWidget {
  WorkoutOverviewCard({Key key, this.workout}) : super(key: key);

  final Workout workout;

  @override
  _WorkoutOverviewCardState createState() => _WorkoutOverviewCardState();
}

class _WorkoutOverviewCardState extends State<WorkoutOverviewCard>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Animation<double> animation;
  AnimationController controller;

  bool expanded;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    expanded = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void _handleCollapse() {
    controller.reverse();
    setState(() {
      expanded = false;
    });
  }

  void _handleExpand() {
    controller.forward();
    setState(() {
      expanded = true;
    });
  }

  void _handleStart() {
    // TODO: Navigate to other screen
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return expanded
        ? WorkoutOverviewCardExpanded(
            workout: widget.workout,
            handleCollapse: _handleCollapse,
            handleStart: _handleStart)
        : WorkoutOverviewCardCollapsed(
            workout: widget.workout,
            handleExpand: _handleExpand,
            animation: animation);
  }
}
