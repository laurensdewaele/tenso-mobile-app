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
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleExpand,
        child: Card(
            padding: EdgeInsets.all(styles.Measurements.s),
            child: Stack(overflow: Overflow.clip, children: <Widget>[
              Row(children: [
                Expanded(child: AnimatedTitle(animation: animation)),
                SizedBox(
                  width: 0,
                  height: styles.Measurements.xxl,
                )
              ]),
              Align(
                  alignment: Alignment(1, 0),
                  child: Difficulty(
                    difficulty: workout.difficulty.toString(),
                    difficultyColor: workout.difficultyColor,
                    width: styles.Measurements.xxl,
                    height: styles.Measurements.xxl,
                  )),
            ])));
  }
}

class AnimatedTitle extends AnimatedWidget {
  AnimatedTitle({Key key, this.animation})
      : super(key: key, listenable: animation);

  final Animation<double> animation;
  static final Tween<double> _titleAlignmentTween = Tween(begin: -1, end: 0);
  static final Tween<double> _sizedBoxTween =
      Tween(begin: styles.Measurements.xxl + styles.Measurements.m);

  // Two moves the difficultyWidget off screen to the right.
  // It is being clipped, therefore invisible.
  static final Tween<double> _difficultyAlignmentTween =
      Tween(begin: 1, end: 2);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Align(
        alignment: Alignment(_titleAlignmentTween.evaluate(animation), 0),
        child: Text('small',
            style: styles.Typography.title, overflow: TextOverflow.ellipsis));
  }
}
