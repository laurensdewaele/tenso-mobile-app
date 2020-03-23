import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/state/app_state.dart';
import 'package:app/view_models/workout_vm.dart';

class GeneralTabViewModel extends ChangeNotifier {
  GeneralTabViewModel(WorkoutViewModel workoutViewModel) {
    _workoutViewModel = workoutViewModel;
  }

  AppState _appState;
  WorkoutViewModel _workoutViewModel;
  Workout get _workout => _appState?.workout;

  void update(AppState appState) {
    _appState = appState;
  }

  void setHoldCount(int count) {
    if (count == _workout.holdCount) {
      return;
    }

    List<Hold> _holds;

    if (count < _workout.holdCount) {
      _holds = _workout.holds.take(count).toList();
    }
    if (count > _workout.holdCount) {
      final Hold defaultHold = _workout.holds[0];
      final int difference = count - _workout.holdCount;
      _holds = [
        ..._workout.holds,
        ...List.generate(difference, (i) => defaultHold)
      ];
    }
    final Workout w = _workout.rebuild((b) => b
      ..holdCount = count
      ..holds.replace(_holds));
    _workoutViewModel.setAndSaveWorkout(w);
  }

  void setSets(int s) {
    _workoutViewModel.setAndSaveWorkout((_workout.rebuild((b) => b..sets = s)));
  }

  void setRestBetweenHolds(int s) {
    _workoutViewModel
        .setAndSaveWorkout((_workout.rebuild((b) => b..restBetweenHolds = s)));
  }

  void setRestBetweenSets(int s) {
    _workoutViewModel
        .setAndSaveWorkout((_workout.rebuild((b) => b..restBetweenSets = s)));
  }

  void setBoard(Board board) {
    _workoutViewModel
        .setAndSaveWorkout((_workout.rebuild((b) => b..board = board.toBuilder())));
  }
}
