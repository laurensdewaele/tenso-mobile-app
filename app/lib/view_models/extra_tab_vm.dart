import 'package:flutter/cupertino.dart';

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
  WorkoutViewModel _workoutViewModel;

  void update(AppState appState) {
    _appState = appState;
  }

  void setDifficulty(int difficulty) {
    _workoutViewModel.setAndSaveWorkout(
        _appState?.workout?.rebuild((b) => b..difficulty = difficulty));
  }

  void setName(String name) {
    _workoutViewModel
        .setAndSaveWorkout(_appState?.workout?.rebuild((b) => b..name = name));
  }

  void handleButtonTap() {
    final String _name = _appState?.workout?.name;

    if (_name == '' || _name == null) {
      _toastService
          .add(Text('Name must be filled in.', style: styles.Lato.sBlack));
    } else {
      _workoutViewModel.handleExtraTabButtonTap();
    }
  }
}
