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

  Workout get workout {
    if (_isNewWorkout) {
      return _appState.newWorkout;
    } else {
      return _appState.editWorkout;
    }
  }

  void setNewWorkout({bool isNewWorkout, bool isEditWorkout}) {
    if (isNewWorkout) {
      _isNewWorkout = true;
      _isEditWorkout = false;
    } else {
      _isNewWorkout = false;
      _isEditWorkout = true;
    }
  }

  void saveWorkout(Workout workout) {
    if (_isNewWorkout) {
      _appState.saveNewWorkout(workout);
    } else {
      _appState.saveEditWorkout(workout);
    }
  }
}
