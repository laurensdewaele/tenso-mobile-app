import 'package:app/models/workout.dart';
import 'package:app/view_models/new_or_edit_workout_vm.dart';

class ExtraTabViewModel {
  ExtraTabViewModel(NewOrEditWorkoutViewModel newOrEditWorkoutViewModel) {
    _newOrEditWorkoutViewModel = newOrEditWorkoutViewModel;
  }

  NewOrEditWorkoutViewModel _newOrEditWorkoutViewModel;
  Workout get _workout => _newOrEditWorkoutViewModel.workout;

  void setDifficulty(String difficulty) {
    _newOrEditWorkoutViewModel
        .saveWorkout(_workout.rebuild((b) => b..difficulty = difficulty));
  }

  void setName(String name) {
    _newOrEditWorkoutViewModel
        .saveWorkout(_workout.rebuild((b) => b..name = name));
  }
}
