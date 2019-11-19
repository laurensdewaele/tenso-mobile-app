import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/workout_overview_card.dart';
import 'package:app/widgets/workout_overview_delete.dart';
import 'package:app/widgets/workout_overview_edit.dart';

enum _SlideDirection { left, right }

class WorkoutOverviewStack extends StatefulWidget {
  WorkoutOverviewStack({Key key, this.workout}) : super(key: key);

  final Workout workout;

  @override
  _WorkoutOverviewStackState createState() => _WorkoutOverviewStackState();
}

class _WorkoutOverviewStackState extends State<WorkoutOverviewStack>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  AnimationController _controller;
  Animation<Offset> _animation;

  bool _isSliderOpen = false;
  double dx = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    // Neutral position as our controller ranges from [0,1].
    _controller.value = 0.5;
    _animation = Tween<Offset>(begin: Offset(-.25, 0), end: Offset(.25, 0.0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _closeSlider() {
    _controller.reverse();
  }

  void _handleEditTap() {
    print('triggered');
    // TODO: Implement modal
    _close();
  }

  void _handleDeleteTap() {
    print('triggered');
    // TODO: Implement modal
    _close();
  }

  void _handleDragStart(DragStartDetails details) {
    if (_controller.isAnimating) {
      _controller.stop();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    dx += details.delta.dx;
    // An action is a fourth the size of the card
    final double actionContainerSize = context.size.width / 4;
    final double traversedPercentage = dx / actionContainerSize;
    // Our controller range spans from [0,1] and the neutral position is 0.5.
    _controller.value = .5 + traversedPercentage / 2;
  }

  void _handleDragEnd(DragEndDetails details) {
    final double velocity = details.primaryVelocity;
    final double editActionThreshold = .75;
    final double deleteActionThreshold = .25;

    if (velocity > 0) {
      if (_controller.value >= editActionThreshold) {
        _open(_SlideDirection.right);
      } else {
        _close();
      }
    }

    if (velocity < 0) {
      if (_controller.value <= deleteActionThreshold) {
        _open(_SlideDirection.left);
      } else {
        _close();
      }
    }

    if (velocity == 0) {
      if (_controller.value >= editActionThreshold) {
        _open(_SlideDirection.right);
      }

      if (_controller.value > deleteActionThreshold &&
          _controller.value < editActionThreshold) {
        _close();
      }

      if (_controller.value <= deleteActionThreshold) {
        _open(_SlideDirection.left);
      }
    }
  }

  void _animateTo(double value) {
    _controller.animateTo(value,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void _close() {
    _animateTo(.5);
    dx = 0;
  }

  void _open(_SlideDirection direction) {
    if (direction == _SlideDirection.left) {
      _animateTo(0);
    }

    if (direction == _SlideDirection.right) {
      _animateTo(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _Actions(
            handleDeleteTap: _handleDeleteTap, handleEditTap: _handleEditTap),
        GestureDetector(
            onHorizontalDragStart: _handleDragStart,
            onHorizontalDragUpdate: _handleDragUpdate,
            onHorizontalDragEnd: _handleDragEnd,
            behavior: HitTestBehavior.translucent,
            child: SlideTransition(
                position: _animation,
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
