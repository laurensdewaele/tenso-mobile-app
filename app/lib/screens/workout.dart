import 'dart:async';

import 'package:flutter/cupertino.dart' hide Icon;

import 'package:provider/provider.dart';

import 'package:app/state/app_state.dart';
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
  WorkoutScreen({Key key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final StreamController<bool> _scrollToTopStreamController =
      StreamController<bool>();
  Stream get _scrollToTopStream => _scrollToTopStreamController.stream;

  final StreamController<bool> _navigateForwardTabStreamController =
      StreamController<bool>();
  Stream get _navigateForwardTabStream =>
      _navigateForwardTabStreamController.stream;

  final StreamController<bool> _navigateBackTabStreamController =
      StreamController<bool>();
  Stream get _navigateBackTabStream => _navigateBackTabStreamController.stream;

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
    final WorkoutViewModel _workoutViewModel =
        Provider.of<WorkoutViewModel>(context, listen: true);

    return KeyboardAndToastProvider(
      child: Screen(
          gradientStartColor: _workoutViewModel.primaryColor,
          gradientStopColor: _workoutViewModel.primaryColor,
          child: KeyboardListView(
              scrollToTopStream: _scrollToTopStream,
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
                        child: Consumer<AppState>(
                            builder: (context, _appState, child) {
                          return TabsContainer(
                              primaryColor:
                                  _workoutViewModel.primaryColor,
                              onNavigation: _scrollToTop,
                              holdCount: _appState.workout.holdCount,
                              navigateForwardTabStream:
                                  _navigateForwardTabStream,
                              navigateBackTabStream:
                                  _navigateBackTabStream);
                        }),
                      ),
                    ),
                    Divider(height: styles.Measurements.xxl)
                  ],
                )
              ])),
    );
  }
}
