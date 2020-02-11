import 'package:app/models/workout.dart';
import 'package:app/state/app_state.dart';

class NewOrEditWorkoutViewModel {
  NewOrEditWorkoutViewModel(AppState appState) {
    _appState = appState;
  }

  AppState _appState;

  bool _isNewWorkout = true;
  bool _isEditWorkout = false;
  bool get isNewWorkout => _isNewWorkout;
  bool get isEditWorkout => _isEditWorkout;
  void setNewWorkout(bool isNewWorkout) {
    _isNewWorkout = isNewWorkout;
    _isEditWorkout = !isNewWorkout;
  }

  void saveWorkout(Workout workout) {
    if (_isNewWorkout) {
      _appState.saveNewWorkout(workout);
    } else {
      _appState.saveEditWorkout(workout);
    }
  }
}
