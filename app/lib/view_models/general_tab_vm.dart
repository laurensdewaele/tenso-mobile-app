import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/view_models/workout_vm.dart';

class GeneralTabViewModel {
  GeneralTabViewModel(WorkoutViewModel workoutViewModel) {
    _workoutViewModel = workoutViewModel;
  }

  WorkoutViewModel _workoutViewModel;
  Workout get _workout => _workoutViewModel.workout;

  void setHoldCount(int count) {
    if (count == _workout.holdCount) {
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
    _workoutViewModel.setWorkout(w);
  }

  void setSets(int s) {
    _workoutViewModel
        .setWorkout((_workout.rebuild((b) => b..sets = s)));
  }

  void setRestBetweenHolds(int s) {
    _workoutViewModel
        .setWorkout((_workout.rebuild((b) => b..restBetweenHolds = s)));
  }

  void setRestBetweenSets(int s) {
    _workoutViewModel
        .setWorkout((_workout.rebuild((b) => b..restBetweenSets = s)));
  }

  void setBoard(Board board) {
    _workoutViewModel
        .setWorkout((_workout.rebuild((b) => b..board = board.toBuilder())));
  }
}
