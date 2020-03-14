import 'dart:async';

import 'package:flutter/cupertino.dart' hide Icon;

import 'package:provider/provider.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout_vm.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:app/widgets/workout/tabs_container.dart';

class WorkoutScreen extends StatefulWidget {
  WorkoutScreen();

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final StreamController<bool> _scrollToTopStreamController =
      StreamController<bool>();
  final StreamController<bool> _navigateForwardTabStreamController =
      StreamController<bool>();
  final StreamController<bool> _navigateBackTabStreamController =
      StreamController<bool>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _navigateForwardTabStreamController.close();
    _navigateBackTabStreamController.close();
    _scrollToTopStreamController.close();
    super.dispose();
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity > 0) {
      _navigateBackTabStreamController.sink.add(true);
    }

    if (details.primaryVelocity < 0) {
      _navigateForwardTabStreamController.sink.add(true);
    }
  }

  void _scrollToTop() {
    _scrollToTopStreamController.sink.add(true);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAndToastProvider(
      child: Consumer<WorkoutViewModel>(
        builder: (context, _workoutViewModel, child) => Screen(
            gradientStartColor: _workoutViewModel.primaryColor,
            gradientStopColor: _workoutViewModel.primaryColor,
            child: KeyboardListView(
                scrollToTopStream: _scrollToTopStreamController.stream,
                children: [
                  Column(
                    children: <Widget>[
                      TopNavigation(title: _workoutViewModel.title),
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
                                    primaryColor:
                                        _workoutViewModel.primaryColor,
                                    onNavigation: _scrollToTop,
                                    holdCount:
                                        _workoutViewModel.workout.holdCount,
                                    navigateForwardTabStream:
                                        _navigateForwardTabStreamController
                                            .stream,
                                    navigateBackTabStream:
                                        _navigateBackTabStreamController
                                            .stream),
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
    );
  }
}
