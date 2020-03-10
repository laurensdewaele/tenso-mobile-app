import 'package:app/models/workout.dart';
import 'package:app/view_models/workout_vm.dart';

class ExtraTabViewModel {
  ExtraTabViewModel(WorkoutViewModel workoutViewModel) {
    _workoutViewModel = workoutViewModel;
  }

  WorkoutViewModel _workoutViewModel;
  Workout get _workout => _workoutViewModel.workout;

  void setDifficulty(int difficulty) {
    _workoutViewModel
        .saveWorkout(_workout.rebuild((b) => b..difficulty = difficulty));
  }

  void setName(String name) {
    _workoutViewModel
        .saveWorkout(_workout.rebuild((b) => b..name = name));
  }

  void addNewWorkoutToWorkouts() {
    _workoutViewModel.addNewWorkoutToWorkouts();
  }
}
