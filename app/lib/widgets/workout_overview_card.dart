import 'package:flutter/material.dart' hide Card, Divider;

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/difficulty.dart';
import 'package:app/widgets/workout_overview_card_expanded.dart';
import 'package:flutter/material.dart' as prefix0;

class WorkoutOverviewCard extends StatefulWidget {
  WorkoutOverviewCard({Key key, this.workout}) : super(key: key);

  final Workout workout;

  @override
  _WorkoutOverviewCardState createState() => _WorkoutOverviewCardState();
}

class _WorkoutOverviewCardState extends State<WorkoutOverviewCard>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _horizontalTitleAlignmentTween =
      Tween(begin: -1, end: 0);
  // Two moves the difficultyWidget off screen to the right.
  // It is being clipped, therefore invisible.
  static final Animatable<double> _horizontalDifficultyAlignmentTween =
      Tween(begin: 0, end: -styles.Measurements.xxl);
  static final Animatable<double> _sizedBoxWidthTween =
      Tween(begin: styles.Measurements.xxl + styles.Measurements.m, end: 0);

  AnimationController _controller;
  Animation<double> _heightFactor;
  Animation<double> _horizontalTitleAlignment;
  Animation<double> _horizontalDifficultyAlignment;
  Animation<double> _sizedBoxWidth;

  bool _isExpanded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _horizontalTitleAlignment =
        _controller.drive(_horizontalTitleAlignmentTween.chain(_easeInTween));
    _horizontalDifficultyAlignment = _controller
        .drive(_horizontalDifficultyAlignmentTween.chain(_easeInTween));
    _sizedBoxWidth = _controller.drive(_sizedBoxWidthTween.chain(_easeInTween));

    _isExpanded = PageStorage.of(context)?.readState(context) ?? false;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
  }

  void _handleStart() {
    // TODO: Implement route transition.
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return GestureDetector(
        onTap: _handleTap,
        child: Card(
            padding: EdgeInsets.all(styles.Measurements.s),
            child: Column(children: <Widget>[
              Stack(overflow: Overflow.clip, children: <Widget>[
                Row(children: [
                  Expanded(
                      child: Align(
                          alignment:
                              Alignment(_horizontalTitleAlignment.value, 0),
                          child: Text(widget.workout.name,
                              style: styles.Typography.title,
                              overflow: TextOverflow.ellipsis))),
                  SizedBox(
                    width: _sizedBoxWidth.value,
                    height: styles.Measurements.xxl,
                  )
                ]),
                Positioned(
                    right: _horizontalDifficultyAlignment.value,
                    child: Difficulty(
                      difficulty: widget.workout.difficulty.toString(),
                      difficultyColor: widget.workout.difficultyColor,
                      width: styles.Measurements.xxl,
                      height: styles.Measurements.xxl,
                    )),
              ]),
              ClipRect(
                  child: Align(heightFactor: _heightFactor.value, child: child))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final bool closed = !_isExpanded && _controller.isDismissed;

    return AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: closed
            ? null
            : WorkoutOverviewCardExpanded(
                workout: widget.workout, handleStart: _handleStart));
  }
}
