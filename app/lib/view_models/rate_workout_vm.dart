import 'package:flutter/cupertino.dart';

import 'package:uuid/uuid.dart';

import 'package:app/models/completed_workout.dart';
import 'package:app/models/completed_workouts.dart';
import 'package:app/models/workout.dart';
import 'package:app/services/toast.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;

class RateWorkoutViewModel {
  RateWorkoutViewModel(AppState appState, ToastService toastService) {
    _appState = appState;
    _toastService = toastService;
    _uuid = Uuid();
  }

  ToastService _toastService;
  AppState _appState;
  Uuid _uuid;
  int _perceivedExertion = 0;

  void setPerceivedExertion(int n) {
    if (_validateInput(n) == false) {
      _perceivedExertion = 0;
      return;
    }
    _perceivedExertion = n;
  }

  bool completeWorkout(Workout workout) {
    if (_validateInput(_perceivedExertion) == false) {
      return false;
    } else {
      _saveCompletedWorkout(
          workout: workout, perceivedExertion: _perceivedExertion);
      return true;
    }
  }

  bool _validateInput(n) {
    if (n < 1 || n > 10) {
      _toastService.add(RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Please define an exertion level ranging from',
            style: styles.Lato.sBlack,
            children: [
              TextSpan(text: '1 to 10.', style: styles.Lato.sBlackBold),
            ]),
      ));
      return false;
    } else {
      return true;
    }
  }

  void _saveCompletedWorkout({Workout workout, int perceivedExertion}) {
    final CompletedWorkout completedWorkout = CompletedWorkout((b) => b
      ..workout = workout.toBuilder()
      ..perceivedExertion = perceivedExertion
      ..completedDate = DateTime.now().toUtc()
      ..id = _uuid.v4());

    final _completedWorkouts = _appState.completedWorkouts
        .rebuild((b) => b..completedWorkouts.add(completedWorkout));
    _setAndSaveCompletedWorkouts(_completedWorkouts);
  }

  void _setAndSaveCompletedWorkouts(CompletedWorkouts completedWorkouts) {
    _appState.setCompletedWorkouts(completedWorkouts);
    _appState.saveCompletedWorkouts(completedWorkouts);
  }
}
