import 'package:flutter/cupertino.dart';

import 'package:uuid/uuid.dart';

import 'package:app/services/toast.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout_vm.dart';

class ExtraTabViewModel extends ChangeNotifier {
  ExtraTabViewModel(
      WorkoutViewModel workoutViewModel, ToastService toastService) {
    _workoutViewModel = workoutViewModel;
    _toastService = toastService;
  }

  AppState _appState;
  ToastService _toastService;
  Uuid _uuid = Uuid();
  WorkoutViewModel _workoutViewModel;

  void update(AppState appState) {
    _appState = appState;
  }

  void setDifficulty(int difficulty) {
    try {
      _workoutViewModel.setAndSaveWorkout(
          _appState?.workout?.rebuild((b) => b..difficulty = difficulty));
    } catch (_) {
      // TODO
    }
  }

  void setName(String name) {
    try {
      _workoutViewModel.setAndSaveWorkout(
          _appState?.workout?.rebuild((b) => b..name = name));
    } catch (_) {
      // TODO
    }
  }

  void addNewWorkout() {
    final String _name = _appState?.workout?.name;

    if (_name == '' || _name == null) {
      _toastService
          .add(Text('Name must be filled in.', style: styles.Lato.sBlack));
    } else {
      try {
        _workoutViewModel.addNewWorkout(_appState?.workout?.rebuild((b) => b
          ..name = _name
          ..id = _uuid.v4()));
      } catch (_) {
        // TODO
      }
    }
  }
}
