import 'dart:async';

import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/scheduler.dart';

import 'package:app/data/basic_workout.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/keyboard_screen.dart';
import 'package:app/widgets/new_workout/tabs_container.dart';
import 'package:app/widgets/toast.dart';
import 'package:app/widgets/top_navigation.dart';

class NewWorkoutScreen extends StatefulWidget {
  NewWorkoutScreen();

  @override
  _NewWorkoutScreenState createState() => _NewWorkoutScreenState();
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
  final StreamController<bool> _shouldLoseFocusStreamController =
      StreamController<bool>.broadcast();
  final StreamController<Widget> _errorMessageStreamController =
      StreamController<Widget>();
  final ScrollController _scrollController = ScrollController();
  final StreamController<bool> _navigateForwardTabStreamController =
      StreamController<bool>();
  final StreamController<bool> _navigateBackTabStreamController =
      StreamController<bool>();

  double _keyboardOffsetHeight = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _shouldLoseFocusStreamController.close();
    _errorMessageStreamController.close();
    _navigateForwardTabStreamController.close();
    _navigateBackTabStreamController.close();
    super.dispose();
  }

  void _onScreenTap() {
    _shouldLoseFocusStreamController.sink.add(true);
    setState(() {
      _keyboardOffsetHeight = 0;
    });
  }

  void _handleErrorMessage(Widget message) {
    _errorMessageStreamController.sink.add(message);
  }

  // This method gets triggered a lot.
  // Because we do not keep track of which number input is active at the time.
  // When we do a validation, we validate all number fields.
  // Fine for now. Assuming this does not cause too much of a performance hit.
  // It might be when we integrate state management.
  // TODO: Keep track of performance impact
  void _handleValueChanged(
      {int value,
      WorkoutProperties workoutProperty,
      HoldProperties holdProperty}) {}

  void _handleKeyboardOffset(Offset offset) {
    setState(() {
      _keyboardOffsetHeight = offset.dy;
    });

    if (offset.dy == 0) return;

    final double originalScrollDifference =
        _scrollController.position.maxScrollExtent - _scrollController.offset;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent - originalScrollDifference,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity > 0) {
      _navigateBackTabStreamController.sink.add(true);
    }

    if (details.primaryVelocity < 0) {
      _navigateForwardTabStreamController.sink.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: _onScreenTap,
          child: KeyBoardScreen(
              handleKeyboardOffset: _handleKeyboardOffset,
              gradientStartColor: styles.Colors.primary,
              gradientStopColor: styles.Colors.primary,
              child: ListView(
                  controller: _scrollController,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Column(
                      children: <Widget>[
                        TopNavigation(title: 'New workout'),
                        Divider(height: styles.Measurements.xxl),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: styles.Measurements.xs),
                          child: GestureDetector(
                            onHorizontalDragEnd: _onHorizontalDragEnd,
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TabsContainer(
                                      onNavigation: _scrollToTop,
                                      // TODO: Replace
                                      workout: basicWorkout,
                                      shouldLoseFocusStream:
                                          _shouldLoseFocusStreamController
                                              .stream,
                                      handleErrorMessage: _handleErrorMessage,
                                      navigateForwardTabStream:
                                          _navigateForwardTabStreamController
                                              .stream,
                                      navigateBackTabStream:
                                          _navigateBackTabStreamController
                                              .stream),
                                  SizedBox(
                                    height: _keyboardOffsetHeight,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(height: styles.Measurements.xxl)
                      ],
                    )
                  ])),
        ),
        Toast(messageStream: _errorMessageStreamController.stream),
      ],
    );
  }
}
