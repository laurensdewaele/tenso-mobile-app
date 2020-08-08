import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/data/empty_workout.data.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/screens/execution.screen.dart';
import 'package:tenso_app/screens/workout.screen.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/state/user.state.dart';
import 'package:tenso_app/state/versioning.state.dart';
import 'package:tenso_app/state/workouts.state.dart';
import 'package:tenso_app/view_models/workout/workout.vm.dart';

class WorkoutOverviewViewModel extends ChangeNotifier {
  List<Workout> _workoutList;
  List<Workout> get workoutList => _workoutList;
  bool bottomMenuOpen;
  bool _displayChangelog;
  bool get displayChangelog => _displayChangelog;
  WorkoutsState _workoutsState;
  StreamSubscription _sub;

  NavigationService _navigationService;

  WorkoutOverviewViewModel() {
    bottomMenuOpen = UserState().deviceInfo.firstLaunch;
    _displayChangelog = VersioningState().displayChangelog;
    _navigationService = NavigationService();
    _workoutsState = WorkoutsState();
    _workoutList = _workoutsState.workoutList;
    _sub = _workoutsState.workoutList$.listen((List<Workout> workoutList) {
      _workoutList = workoutList;
      notifyListeners();
    });
  }

  void setDisplayChangelogFalse() {
    _displayChangelog = false;
    VersioningState().setDisplayChangelogFalse();
  }

  void deleteWorkout(Workout workout) {
    _workoutsState.deleteWorkout(workout);
  }

  void copyWorkout(Workout workout) {
    _workoutsState.copyWorkout(workout);
  }

  void addWorkout() {
    _navigationService.pushNamed(Routes.workoutScreen,
        arguments: WorkoutScreenArguments(
          workoutAction: WorkoutActions.newWorkout,
          workout: emptyWorkout,
        ));
  }

  void editWorkout(Workout workout) {
    _navigationService.pushNamed(Routes.workoutScreen,
        arguments: WorkoutScreenArguments(
            workoutAction: WorkoutActions.editWorkout, workout: workout));
  }

  void start(Workout workout) {
    _navigationService.pushNamed(Routes.executionScreen,
        arguments: ExecutionScreenArguments(workout: workout));
  }

  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
