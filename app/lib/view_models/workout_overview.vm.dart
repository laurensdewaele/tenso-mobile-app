import 'dart:async';

import 'package:app/data/empty_workout.dart';
import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/execution.screen.dart';
import 'package:app/screens/workout.screen.dart';
import 'package:app/services/navigation.service.dart';
import 'package:app/state/user.state.dart';
import 'package:app/state/workouts.state.dart';
import 'package:app/view_models/workout/workout.vm.dart';
import 'package:flutter/cupertino.dart';

class WorkoutOverviewViewModel extends ChangeNotifier {
  List<Workout> _workoutList;
  List<Workout> get workoutList => _workoutList;
  bool startOpen;
  WorkoutsState _workoutsState;
  StreamSubscription _sub;

  NavigationService _navigationService;

  WorkoutOverviewViewModel() {
    startOpen = UserState().deviceInfo.firstLaunch;
    _navigationService = NavigationService();
    _workoutsState = WorkoutsState();
    _workoutList = _workoutsState.workoutList;
    _sub = _workoutsState.workoutList$.listen((List<Workout> workoutList) {
      _workoutList = workoutList;
      notifyListeners();
    });
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
