import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/models/completed_workout.dart';
import 'package:app/models/workout.dart';
import 'package:app/routes/routes.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/new_or_edit_workout_vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/workout_overview/workout_dialog_delete.dart';
import 'package:app/widgets/workout_overview/workout_overview_card.dart';
import 'package:app/widgets/workout_overview/workout_overview_delete_action.dart';
import 'package:app/widgets/workout_overview/workout_overview_edit_action.dart';
import 'package:app/widgets/workout_overview/workout_overview_view_action.dart';

enum _SlideDirection { left, right }

class WorkoutOverviewStack extends StatefulWidget {
  WorkoutOverviewStack(
      {Key key,
      this.workout,
      this.handleWorkoutDeleteTap,
      this.handleCompletedWorkoutDeleteTap,
      this.completedWorkout})
      : super(key: key);

  final Workout workout;
  final CompletedWorkout completedWorkout;
  final void Function(Workout workout) handleWorkoutDeleteTap;
  final void Function(CompletedWorkout completedWorkout)
      handleCompletedWorkoutDeleteTap;

  @override
  _WorkoutOverviewStackState createState() => _WorkoutOverviewStackState();
}

class _WorkoutOverviewStackState extends State<WorkoutOverviewStack>
    with TickerProviderStateMixin {
  Animation<double> _sizeAnimation;
  Animation<Offset> _slideAnimation;
  AnimationController _sizeController;
  AnimationController _slideController;

  bool _isSliderOpen = false;
  double dx = 0.0;

  @override
  void initState() {
    super.initState();

    _sizeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _sizeAnimation = Tween<double>(begin: 1, end: 0)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(_sizeController);
    // Value 0.5 is the neutral position as our controller ranges from [0,1].
    _slideController = AnimationController(
      vsync: this,
      value: 0.5,
    );
    _slideAnimation =
        Tween<Offset>(begin: Offset(-.25, 0), end: Offset(.25, 0.0))
            .animate(_slideController);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  void _handleEditTap() {
    _close();
    final _newOrEditWorkoutViewModel =
        Provider.of<NewOrEditWorkoutViewModel>(context, listen: false);
    _newOrEditWorkoutViewModel.setWorkoutType(isEditWorkout: true);
    _newOrEditWorkoutViewModel.setActiveEditWorkout(widget.workout);
    Navigator.of(context).pushNamed(Routes.newOrEditWorkoutScreen);
  }

  void _handleViewTap() {
    _close();
    // TODO:
  }

  void _handleWorkoutDeleteTap() async {
    await showWorkoutDeleteDialog(
        context: context,
        workoutName: widget.workout.name,
        handleCancelTap: () {
          Navigator.of(context).pop();
          _close();
        },
        handleDeleteTap: () {
          Navigator.of(context).pop();
          _sizeController
              .forward()
              .orCancel
              .then((_) => widget.handleWorkoutDeleteTap(widget.workout));
        });
  }

  void _handleCompletedWorkoutDeleteTap() async {
    await showCompletedWorkoutDeleteDialog(
        context: context,
        workoutName: widget.completedWorkout.workout.name,
        completedDate: widget.completedWorkout.completedLocalDate,
        handleCancelTap: () {
          Navigator.of(context).pop();
          _close();
        },
        handleDeleteTap: () {
          Navigator.of(context).pop();
          _sizeController.forward().orCancel.then((_) =>
              widget.handleCompletedWorkoutDeleteTap(widget.completedWorkout));
        });
  }

  void _handleDragStart(DragStartDetails details) {
    if (_slideController.isAnimating) {
      _slideController.stop();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    dx += details.delta.dx;
    // An action is a fourth the size of the card
    final double actionContainerSize = context.size.width / 4;
    final double traversedPercentage = dx / actionContainerSize;
    // Our controller range spans from [0,1] and the neutral position is 0.5.
    _slideController.value = .5 + traversedPercentage / 2;
  }

  void _handleDragEnd(DragEndDetails details) {
    final double velocity = details.primaryVelocity;
    final double editActionThreshold = .75;
    final double deleteActionThreshold = .25;

    if (velocity > 0) {
      if (_slideController.value >= editActionThreshold) {
        _open(_SlideDirection.right);
      } else {
        _close();
      }
    }

    if (velocity < 0) {
      if (_slideController.value <= deleteActionThreshold) {
        _open(_SlideDirection.left);
      } else {
        _close();
      }
    }

    if (velocity == 0) {
      if (_slideController.value >= editActionThreshold) {
        _open(_SlideDirection.right);
      }

      if (_slideController.value > deleteActionThreshold &&
          _slideController.value < editActionThreshold) {
        _close();
      }

      if (_slideController.value <= deleteActionThreshold) {
        _open(_SlideDirection.left);
      }
    }
  }

  void _handleLongPress() async {
    await showAppDialog(
        context: context,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Swipe right to edit, left to delete.',
              style: styles.Lato.sBlack,
              textAlign: TextAlign.center,
            ),
            Divider(height: styles.Measurements.l),
            Transform.scale(
              scale: .8,
              child: Button(
                  displayBackground: false,
                  text: 'Ok',
                  handleTap: () {
                    Navigator.of(context).pop();
                  }),
            )
          ],
        ));
  }

  TickerFuture _animateTo(double value) {
    return _slideController.animateTo(value,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void _close() {
    _animateTo(.5).then((_) => {dx = 0});

    setState(() {
      _isSliderOpen = false;
    });
  }

  void _open(_SlideDirection direction) {
    if (direction == _SlideDirection.left) {
      _animateTo(0);
    }

    if (direction == _SlideDirection.right) {
      _animateTo(1);
    }

    setState(() {
      _isSliderOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget _actions = widget.completedWorkout == null
        ? _WorkoutActions(
            handleWorkoutDeleteTap: _handleWorkoutDeleteTap,
            handleEditTap: _handleEditTap)
        : _CompletedWorkoutActions(
            handleCompletedWorkoutDeleteTap: _handleCompletedWorkoutDeleteTap,
            handleViewTap: _handleViewTap);

    return Card(
      child: SizeTransition(
        sizeFactor: _sizeAnimation,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: _actions,
            ),
            GestureDetector(
                onHorizontalDragStart: _handleDragStart,
                onHorizontalDragUpdate: _handleDragUpdate,
                onHorizontalDragEnd: _handleDragEnd,
                onLongPress: _handleLongPress,
                child: SlideTransition(
                    position: _slideAnimation,
                    child: WorkoutOverviewCard(
                        closeSlider: _close,
                        workout: widget.workout,
                        completedWorkout: widget.completedWorkout,
                        isSliderOpen: _isSliderOpen))),
          ],
        ),
      ),
    );
  }
}

class _WorkoutActions extends StatelessWidget {
  _WorkoutActions({Key key, this.handleEditTap, this.handleWorkoutDeleteTap})
      : super(key: key);

  final VoidCallback handleEditTap;
  final VoidCallback handleWorkoutDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Expanded(
          child: WorkoutOverviewEditAction(handleTap: handleEditTap), flex: 1),
      Expanded(child: SizedBox(), flex: 2),
      Expanded(
          child: WorkoutOverviewDeleteAction(handleTap: handleWorkoutDeleteTap),
          flex: 1)
    ]);
  }
}

class _CompletedWorkoutActions extends StatelessWidget {
  _CompletedWorkoutActions(
      {Key key, this.handleViewTap, this.handleCompletedWorkoutDeleteTap})
      : super(key: key);

  final VoidCallback handleViewTap;
  final VoidCallback handleCompletedWorkoutDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Expanded(
          child: WorkoutOverviewViewAction(handleTap: handleViewTap), flex: 1),
      Expanded(child: SizedBox(), flex: 2),
      Expanded(
          child: WorkoutOverviewDeleteAction(
              handleTap: handleCompletedWorkoutDeleteTap),
          flex: 1)
    ]);
  }
}
