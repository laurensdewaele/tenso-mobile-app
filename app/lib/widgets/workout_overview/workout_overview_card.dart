import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/execution.screen.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/color_square.dart';
import 'package:app/widgets/workout_overview/workout_overview_card_expanded.dart';
import 'package:flutter/cupertino.dart';

class WorkoutOverviewCard extends StatefulWidget {
  WorkoutOverviewCard({
    Key key,
    this.workout,
    this.completedWorkout,
    @required this.isSliderOpen,
    @required this.closeSlider,
  }) : super(key: key);

  final Workout workout;
  final CompletedWorkout completedWorkout;
  final bool isSliderOpen;
  final VoidCallback closeSlider;

  @override
  _WorkoutOverviewCardState createState() => _WorkoutOverviewCardState();
}

class _WorkoutOverviewCardState extends State<WorkoutOverviewCard>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static final Animatable<double> _easeInOutTween =
      CurveTween(curve: Curves.easeInOut);
  static final Animatable<double> _horizontalTitleAlignmentTween =
      Tween(begin: -1, end: 0);
  // Moves the label off screen to the right.
  // It is being clipped, therefore invisible.
  static final Animatable<double> _horizontalLabelAlignmentTween =
      Tween(begin: 0, end: -styles.Measurements.xxl);
  static final Animatable<double> _sizedBoxWidthTween =
      Tween(begin: styles.Measurements.xxl + styles.Measurements.m, end: 0);

  AnimationController _controller;
  Animation<double> _heightFactor;
  Animation<double> _horizontalTitleAlignment;
  Animation<double> _horizontalLabelAlignment;
  Animation<double> _sizedBoxWidth;

  Workout _workout;

  bool _isExpanded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _workout = widget.workout ?? widget.completedWorkout.workout;
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInOutTween);
    _horizontalTitleAlignment = _controller
        .drive(_horizontalTitleAlignmentTween.chain(_easeInOutTween));
    _horizontalLabelAlignment = _controller
        .drive(_horizontalLabelAlignmentTween.chain(_easeInOutTween));
    _sizedBoxWidth =
        _controller.drive(_sizedBoxWidthTween.chain(_easeInOutTween));

    _isExpanded = PageStorage.of(context)?.readState(context) ?? false;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() async {
    if (widget.isSliderOpen == true) {
      widget.closeSlider();
      return;
    }

    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      try {
        await _controller.forward().orCancel;
      } catch (_) {}
    } else {
      try {
        await _controller.reverse().orCancel;
      } catch (_) {}
      if (!mounted) return;
      setState(() {
        // Rebuild without widget.children.
      });
    }
    PageStorage.of(context)?.writeState(context, _isExpanded);
  }

  void _handleStart() {
    Navigator.of(context).pushNamed(Routes.executionScreen,
        arguments: ExecutionScreenArguments(workout: _workout));
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
                          child: Text(_workout.name,
                              style: styles.Staatliches.xlBlack,
                              overflow: TextOverflow.ellipsis))),
                  SizedBox(
                    width: _sizedBoxWidth.value,
                    height: styles.Measurements.xxl,
                  )
                ]),
                Positioned(
                    right: _horizontalLabelAlignment.value,
                    child: ColorSquare(
                      color: _workout.labelColor,
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

    return AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: WorkoutOverviewCardExpanded(
            workout: widget.workout,
            handleStart: _handleStart,
            completedWorkout: widget.completedWorkout));
  }
}
