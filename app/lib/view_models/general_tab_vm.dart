import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/view_models/app_state_vm.dart';

class GeneralTabViewModel {
  GeneralTabViewModel(AppState appState) {
    _appState = appState;
  }

  AppState _appState;
  Workout get _workout => _appState.workout;

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
    _appState.setWorkout(w);
  }

  void setSets(int s) {
    _appState.setWorkout((_workout.rebuild((b) => b..sets = s)));
  }

  void setRestBetweenHolds(int s) {
    _appState.setWorkout((_workout.rebuild((b) => b..restBetweenHolds = s)));
  }

  void setRestBetweenSets(int s) {
    _appState.setWorkout((_workout.rebuild((b) => b..restBetweenSets = s)));
  }

  void setBoard(Board board) {
    _appState
        .setWorkout((_workout.rebuild((b) => b..board = board.toBuilder())));
  }
}
