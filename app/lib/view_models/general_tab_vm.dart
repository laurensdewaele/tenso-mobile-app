import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/services/toast.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout_vm.dart';

class GeneralTabViewModel extends ChangeNotifier {
  GeneralTabViewModel(
      WorkoutViewModel workoutViewModel, ToastService toastService) {
    _workoutViewModel = workoutViewModel;
    _toastService = toastService;
  }

  AppState _appState;
  ToastService _toastService;
  WorkoutViewModel _workoutViewModel;
  Workout get _workout => _appState?.workout;

  void update(AppState appState) {
    _appState = appState;
  }

  void setHoldCount(int count) {
    if (count == _workout.holdCount) {
      return;
    }

    if (_validateInput(count) == false) {
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
    if (_validateInput(s) == false) {
      return;
    }
    _workoutViewModel.setAndSaveWorkout((_workout.rebuild((b) => b..sets = s)));
  }

  void setRestBetweenHolds(int s) {
    if (_validateInput(s) == false) {
      return;
    }
    _workoutViewModel
        .setAndSaveWorkout((_workout.rebuild((b) => b..restBetweenHolds = s)));
  }

  void setRestBetweenSets(int s) {
    if (_validateInput(s) == false) {
      return;
    }
    _workoutViewModel
        .setAndSaveWorkout((_workout.rebuild((b) => b..restBetweenSets = s)));
  }

  void setBoard(Board board) {
    _workoutViewModel.setAndSaveWorkout(
        (_workout.rebuild((b) => b..board = board.toBuilder())));
  }

  bool _validateInput(int n) {
    if (n < 1) {
      _toastService.add(RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Please input a value ',
            style: styles.Lato.sBlack,
            children: [
              TextSpan(text: 'bigger than 0.', style: styles.Lato.sBlackBold),
            ]),
      ));
      return false;
    } else {
      return true;
    }
  }
}
