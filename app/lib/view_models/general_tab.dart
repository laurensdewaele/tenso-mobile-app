import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/view_models/workout_state.dart';

class GeneralTabViewModel {
  GeneralTabViewModel(this._workoutState);
  WorkoutState _workoutState;

  void setHoldCount(int count) {
    final Workout _workout = _workoutState.workout;

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
    _workoutState.setWorkout(w);
  }
}
