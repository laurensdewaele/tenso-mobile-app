import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/difficulty.dart';

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

  static final Tween<double> _titleAlignmentTween = Tween(begin: -1, end: 0);
  static final Tween<double> _sizedBoxTween =
      Tween(begin: styles.Measurements.xxl + styles.Measurements.m);

  // Two moves the difficultyWidget off screen to the right.
  // It is being clipped, therefore invisible.
  static final Tween<double> _difficultyAlignmentTween =
      Tween(begin: 1, end: 2);

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

  void _handleTap() {
    if (expanded == true) {
      controller.reverse();
    }

    if (expanded == false) {
      controller.forward();
    }

    setState(() {
      expanded = !expanded;
    });
  }

  void _handleStart() {
    // TODO: Navigate to other screen
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
        onTap: _handleTap,
        child: Card(
            padding: EdgeInsets.all(styles.Measurements.s),
            child: Column(children: <Widget>[
              Container(
                  child: Stack(overflow: Overflow.clip, children: <Widget>[
                Row(children: [
                  Expanded(
                      child: AnimatedTitle(
                          animation: animation, tween: _titleAlignmentTween)),
                  SizedBox(
                    width: 0,
                    height: styles.Measurements.xxl,
                  )
                ]),
                AnimatedDifficulty(
                    animation: animation,
                    tween: _difficultyAlignmentTween,
                    difficulty: widget.workout.difficulty.toString(),
                    difficultyColor: widget.workout.difficultyColor),
              ]))
            ])));
  }
}

class AnimatedTitle extends AnimatedWidget {
  AnimatedTitle({Key key, this.animation, this.tween})
      : super(key: key, listenable: animation);

  final Animation<double> animation;
  final Tween tween;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Align(
        alignment: Alignment(tween.evaluate(animation), 0),
        child: Text('small',
            style: styles.Typography.title, overflow: TextOverflow.ellipsis));
  }
}

class AnimatedDifficulty extends AnimatedWidget {
  AnimatedDifficulty(
      {Key key,
      this.animation,
      this.tween,
      this.difficulty,
      this.difficultyColor})
      : super(key: key, listenable: animation);

  final Animation<double> animation;
  final Tween tween;

  final String difficulty;
  final Color difficultyColor;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Align(
        alignment: Alignment(tween.evaluate(animation), 0),
        child: Difficulty(
          difficulty: difficulty,
          difficultyColor: difficultyColor,
          width: styles.Measurements.xxl,
          height: styles.Measurements.xxl,
        ));
  }
}
