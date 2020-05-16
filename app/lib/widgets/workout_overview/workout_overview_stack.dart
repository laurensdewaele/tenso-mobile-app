import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:app/widgets/workout_overview/workout_dialog_delete.dart';
import 'package:app/widgets/workout_overview/workout_overview_card.dart';
import 'package:app/widgets/workout_overview/workout_overview_delete_action.dart';
import 'package:app/widgets/workout_overview/workout_overview_edit_action.dart';
import 'package:app/widgets/workout_overview/workout_overview_view_action.dart';
import 'package:flutter/cupertino.dart' hide Icon;

enum _SlideDirection { left, right }

class WorkoutOverviewStack extends StatefulWidget {
  WorkoutOverviewStack(
      {Key key,
      this.workout,
      this.handleWorkoutDeleteTap,
      this.handleWorkoutEditTap,
      this.handleWorkoutCopyTap,
      this.handleCompletedWorkoutCopyTap,
      this.handleCompletedWorkoutViewTap,
      this.handleCompletedWorkoutDeleteTap,
      this.completedWorkout})
      : super(key: key);

  final Workout workout;
  final CompletedWorkout completedWorkout;
  final void Function(Workout workout) handleWorkoutDeleteTap;
  final void Function(Workout workout) handleWorkoutEditTap;
  final void Function(Workout workout) handleWorkoutCopyTap;
  final void Function(Workout workout) handleCompletedWorkoutViewTap;
  final void Function(CompletedWorkout completedWorkout)
      handleCompletedWorkoutDeleteTap;
  final void Function(CompletedWorkout completedWorkout)
      handleCompletedWorkoutCopyTap;

  @override
  _WorkoutOverviewStackState createState() => _WorkoutOverviewStackState();
}

class _WorkoutOverviewStackState extends State<WorkoutOverviewStack>
    with TickerProviderStateMixin {
  Animation<double> _sizeAnimation;
  Animation<Offset> _slideAnimation;
  AnimationController _sizeController;
  AnimationController _slideController;

  bool _isCompletedWorkout;
  bool _isSliderOpen = false;
  double dx = 0.0;

  @override
  void initState() {
    super.initState();
    _isCompletedWorkout = widget.completedWorkout != null;
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
    widget.handleWorkoutEditTap(widget.workout);
  }

  void _handleViewTap() {
    _close();
    widget.handleCompletedWorkoutViewTap(widget.completedWorkout.workout);
  }

  void _handleWorkoutDeleteTap() async {
    await showWorkoutDeleteDialog(
        context: context,
        workoutName: widget.workout.name,
        handleCancelTap: () {
          Navigator.of(context).pop();
          _close();
        },
        handleDeleteTap: () async {
          Navigator.of(context).pop();
          try {
            await _sizeController.forward().orCancel;
          } catch (_) {}
          widget.handleWorkoutDeleteTap(widget.workout);
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
        handleDeleteTap: () async {
          Navigator.of(context).pop();
          try {
            await _sizeController.forward().orCancel;
          } catch (_) {}
          widget.handleCompletedWorkoutDeleteTap(widget.completedWorkout);
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
        width: styles.Measurements.xxl * 6,
        landscapeWidth: styles.Measurements.xxl * 6,
        context: context,
        content: _LongPressDialog(
            handleDeleteTap: () {
              Navigator.of(context).pop();
              if (_isCompletedWorkout == true) {
                _handleCompletedWorkoutDeleteTap();
              } else {
                _handleWorkoutDeleteTap();
              }
            },
            handleViewTap: () {
              Navigator.of(context).pop();
              _handleViewTap();
            },
            handleBackTap: () {
              Navigator.of(context).pop();
            },
            handleCopyTap: () {
              Navigator.of(context).pop();
              if (_isCompletedWorkout == true) {
                widget.handleCompletedWorkoutCopyTap(widget.completedWorkout);
                Navigator.of(context).pushNamed(Routes.workoutOverviewScreen);
              } else {
                widget.handleWorkoutCopyTap(widget.workout);
              }
            },
            handleEditTap: () {
              Navigator.of(context).pop();
              _handleEditTap();
            },
            isCompletedWorkout: _isCompletedWorkout));
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

    return SizeTransition(
      sizeFactor: _sizeAnimation,
      child: Card(
        border: widget.completedWorkout != null,
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

class _LongPressDialog extends StatelessWidget {
  _LongPressDialog(
      {Key key,
      @required this.isCompletedWorkout,
      @required this.handleCopyTap,
      @required this.handleDeleteTap,
      this.handleViewTap,
      this.handleEditTap,
      @required this.handleBackTap})
      : super(key: key);

  final bool isCompletedWorkout;
  final VoidCallback handleViewTap;
  final VoidCallback handleEditTap;
  final VoidCallback handleDeleteTap;
  final VoidCallback handleCopyTap;
  final VoidCallback handleBackTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (isCompletedWorkout == true)
          Button(
              text: 'View',
              backgroundColor: styles.Colors.gray,
              displayBackground: true,
              leadingIcon: icons.searchIconWhiteXl,
              handleTap: handleViewTap,
              leadingIconTextCentered: true),
        if (isCompletedWorkout == false)
          Button(
              text: 'Edit',
              backgroundColor: styles.Colors.blue,
              displayBackground: true,
              leadingIcon: icons.editIconWhiteXl,
              handleTap: handleEditTap,
              leadingIconTextCentered: true),
        Divider(height: styles.Measurements.m),
        Button(
            text: 'Copy',
            backgroundColor: styles.Colors.turquoise,
            displayBackground: true,
            leadingIcon: icons.copyIconWhiteXl,
            handleTap: handleCopyTap,
            leadingIconTextCentered: true),
        Divider(height: styles.Measurements.m),
        Button(
            text: 'Delete',
            backgroundColor: styles.Colors.primary,
            displayBackground: true,
            leadingIcon: icons.deleteIconWhiteXl,
            handleTap: handleDeleteTap,
            leadingIconTextCentered: true),
        Divider(height: styles.Measurements.l),
        Button(
            displayBackground: false,
            text: 'Back',
            handleTap: handleBackTap,
            small: true)
      ],
    );
  }
}
