import 'package:flutter/cupertino.dart';

import 'package:app/models/label.dart';
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

  void setLabel(Label label) {
    _workoutViewModel.setAndSaveWorkout(
        _appState?.workout?.rebuild((b) => b..label = label));
  }

  void setName(String name) {
    if (name.trim() == '' || name == null) {
      _toastService
          .add(Text('Name must be filled in.', style: styles.Lato.sBlack));
    } else {
      _workoutViewModel.setAndSaveWorkout(
          _appState?.workout?.rebuild((b) => b..name = name.trim()));
    }
  }

  void handleButtonTap() {
    _workoutViewModel.handleExtraTabButtonTap();
  }
}
