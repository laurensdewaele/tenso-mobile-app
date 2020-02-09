import 'package:app/models/workout.dart';
import 'package:app/view_models/app_state_vm.dart';

class ExtraTabViewModel {
  ExtraTabViewModel(AppState appState) {
    _appState = appState;
  }
  AppState _appState;
  Workout get _workout => _appState.workout;

  void setDifficulty(String difficulty) {
    _appState.setWorkout(_workout.rebuild((b) => b..difficulty = difficulty));
  }

  void setName(String name) {
    _appState.setWorkout(_workout.rebuild((b) => b..name = name));
  }
}
