import 'package:app/models/workout.dart';
import 'package:app/view_models/app_state_vm.dart';

class ExtraTabViewModel {
  ExtraTabViewModel(AppState appState) {
    _appState = appState;
    _workout = appState.workout;
  }
  AppState _appState;
  Workout _workout;

  void setDifficulty(String difficulty) {
    _appState.setWorkout(_workout.rebuild((b) => b..difficulty = difficulty));
  }

  void setName(String name) {
    _appState.setWorkout(_workout.rebuild((b) => b..name = name));
  }
}
