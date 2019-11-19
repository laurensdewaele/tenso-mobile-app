import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/workout_overview_card.dart';
import 'package:app/widgets/workout_overview_delete.dart';
import 'package:app/widgets/workout_overview_edit.dart';

class WorkoutOverviewStack extends StatefulWidget {
  WorkoutOverviewStack({Key key, this.workout}) : super(key: key);

  final Workout workout;

  @override
  _WorkoutOverviewStackState createState() => _WorkoutOverviewStackState();
}

class _WorkoutOverviewStackState extends State<WorkoutOverviewStack>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInOutTween =
      CurveTween(curve: Curves.easeInOut);
  static final Animatable<Offset> _horizontalOffsetTween =
      Tween(begin: Offset(0.0, 0.0), end: Offset(0.25, 0.0));
  AnimationController _controller;
  Animation<Offset> _horizontalOffset;

  bool _isSliderOpen = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this)
          ..addStatusListener(_animationStatusListener);
    _horizontalOffset =
        _controller.drive(_horizontalOffsetTween.chain(_easeInOutTween));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      _controller.forward();
    });
  }

  void _closeSlider() {
    _controller.reverse();
  }

  AnimationStatusListener _animationStatusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        setState(() {
          _isSliderOpen = false;
        });
        break;
      case AnimationStatus.completed:
        setState(() {
          _isSliderOpen = true;
        });
        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.reverse:
        break;
    }
  }

  void _handleEditTap() {}

  void _handleDeleteTap() {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _Actions(
            handleDeleteTap: _handleDeleteTap, handleEditTap: _handleEditTap),
        GestureDetector(
            onTap: () {},
            child: SlideTransition(
                position: _horizontalOffset,
                child: WorkoutOverviewCard(
                    closeSlider: _closeSlider,
                    workout: widget.workout,
                    isSliderOpen: _isSliderOpen)))
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  _Actions({Key key, this.handleEditTap, this.handleDeleteTap})
      : super(key: key);

  final VoidCallback handleEditTap;
  final VoidCallback handleDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: styles.Measurements.workoutOverviewActionContainer,
      child: Card(
        child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Expanded(
              child: WorkoutOverviewEditAction(handleTap: handleEditTap),
              flex: 1),
          Expanded(child: SizedBox(), flex: 2),
          Expanded(
              child: WorkoutOverviewDeleteAction(handleTap: handleDeleteTap),
              flex: 1)
        ]),
      ),
    );
  }
}
