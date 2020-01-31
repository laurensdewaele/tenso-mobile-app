import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/view_models/app_state.dart';

class GeneralTabViewModel {
  GeneralTabViewModel(this._appState);
  AppState _appState;

  void setHoldCount(int count) {
    final Workout _workout = _appState.workout;

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
    _appState.setWorkout(w);
  }
}
