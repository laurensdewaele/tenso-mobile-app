import 'package:app/data/grips.dart';
import 'package:app/functions/unit_conversion.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/unit.dart';
import 'package:app/models/workout.dart';
import 'package:app/view_models/app_state_vm.dart';

// TODO: there's a shit ton of repetitin going on with `final List<Hold> _holds = _workout.holds.toList();`
// TODO: Refactor it. Think about setting a curentHold or currentTab on the viewModel instead of on the Widgets.

class HoldTabViewModel {
  HoldTabViewModel(AppState appState) {
    _appState = appState;
  }

  AppState _appState;
  Workout get _workout => _appState.workout;

  void setHoldLeftGrip(int holdNo, Grip grip) {
    final List<Hold> _holds = _workout.holds.toList();
    if (grip == null) {
      _holds[holdNo] = Hold((b) => b
        ..rightGrip = _holds[holdNo].rightGrip?.toBuilder()
        ..handHold = _holds[holdNo].handHold
        ..addedWeight = _holds[holdNo].addedWeight
        ..hangTime = _holds[holdNo].hangTime
        ..restBetweenRepetitions = _holds[holdNo].restBetweenRepetitions
        ..repetitions = _holds[holdNo].repetitions
        ..rightGripBoardHold = _holds[holdNo].rightGripBoardHold?.toBuilder()
        ..leftGripBoardHold = _holds[holdNo].leftGripBoardHold?.toBuilder());
    } else {
      _holds[holdNo] =
          _holds[holdNo].rebuild((b) => b..leftGrip = grip.toBuilder());
    }
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldRightGrip(int holdNo, Grip grip) {
    final List<Hold> _holds = _workout.holds.toList();
    if (grip == null) {
      _holds[holdNo] = Hold((b) => b
        ..leftGrip = _holds[holdNo].leftGrip?.toBuilder()
        ..handHold = _holds[holdNo].handHold
        ..addedWeight = _holds[holdNo].addedWeight
        ..hangTime = _holds[holdNo].hangTime
        ..restBetweenRepetitions = _holds[holdNo].restBetweenRepetitions
        ..repetitions = _holds[holdNo].repetitions
        ..rightGripBoardHold = _holds[holdNo].rightGripBoardHold?.toBuilder()
        ..leftGripBoardHold = _holds[holdNo].leftGripBoardHold?.toBuilder());
    } else {
      _holds[holdNo] =
          _holds[holdNo].rebuild((b) => b..rightGrip = grip.toBuilder());
    }
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldHandHold(int holdNo, HandHold handHold) {
    final List<Hold> _holds = _workout.holds.toList();
    _holds[holdNo] = _holds[holdNo].rebuild((b) => b..handHold = handHold);
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
    _checkHands(holdNo);
  }

  void setHoldLeftGripBoardHold(int holdNo, BoardHold boardHold) {
    final List<Hold> _holds = _workout.holds.toList();
    if (boardHold == null) {
      _holds[holdNo] = Hold((b) => b
        ..leftGrip = _holds[holdNo].leftGrip?.toBuilder()
        ..rightGrip = _holds[holdNo].rightGrip?.toBuilder()
        ..handHold = _holds[holdNo].handHold
        ..addedWeight = _holds[holdNo].addedWeight
        ..hangTime = _holds[holdNo].hangTime
        ..restBetweenRepetitions = _holds[holdNo].restBetweenRepetitions
        ..repetitions = _holds[holdNo].repetitions
        ..rightGripBoardHold = _holds[holdNo].rightGripBoardHold?.toBuilder());
    } else {
      _holds[holdNo] = _holds[holdNo]
          .rebuild((b) => b..leftGripBoardHold = boardHold.toBuilder());
    }
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldRightGripBoardHold(int holdNo, BoardHold boardHold) {
    final List<Hold> _holds = _workout.holds.toList();
    if (boardHold == null) {
      _holds[holdNo] = Hold((b) => b
        ..leftGrip = _holds[holdNo].leftGrip?.toBuilder()
        ..rightGrip = _holds[holdNo].rightGrip?.toBuilder()
        ..handHold = _holds[holdNo].handHold
        ..addedWeight = _holds[holdNo].addedWeight
        ..hangTime = _holds[holdNo].hangTime
        ..restBetweenRepetitions = _holds[holdNo].restBetweenRepetitions
        ..repetitions = _holds[holdNo].repetitions
        ..leftGripBoardHold = _holds[holdNo].leftGripBoardHold?.toBuilder());
    } else {
      _holds[holdNo] = _holds[holdNo]
          .rebuild((b) => b..rightGripBoardHold = boardHold.toBuilder());
    }
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldRepetitions(int holdNo, int repetitions) {
    final List<Hold> _holds = _workout.holds.toList();
    _holds[holdNo] =
        _holds[holdNo].rebuild((b) => b..repetitions = repetitions);
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldRestBetweenRepetitions(int holdNo, int seconds) {
    final List<Hold> _holds = _workout.holds.toList();
    _holds[holdNo] =
        _holds[holdNo].rebuild((b) => b..restBetweenRepetitions = seconds);
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldHangTime(int holdNo, int seconds) {
    final List<Hold> _holds = _workout.holds.toList();
    _holds[holdNo] = _holds[holdNo].rebuild((b) => b..hangTime = seconds);
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldAddedWeight(int holdNo, double addedWeight, Unit unit) {
    final List<Hold> _holds = _workout.holds.toList();

    // Unit (metric or imperial) will be saved in kg's.
    // And converted to pounds when needed.
    double weight = addedWeight;

    if (unit == Unit.imperial) {
      weight = UnitConversion.convertPoundsToKg(addedWeight);
    }

    _holds[holdNo] = _holds[holdNo].rebuild((b) => b..addedWeight = weight);
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldOneHandedTap(int holdNo) {
    final List<Hold> _holds = _workout.holds.toList();
    final hold = _holds[holdNo];

    if (hold.leftGrip == null) {
      setHoldHandHold(holdNo, HandHold.oneHandedRight);
    }

    if (hold.rightGrip == null) {
      setHoldHandHold(holdNo, HandHold.oneHandedLeft);
    }
  }

  void _checkHands(int holdNo) {
    final List<Hold> _holds = _workout.holds.toList();
    final hold = _holds[holdNo];

    if (hold.handHold == HandHold.oneHandedLeft) {
      setHoldRightGrip(holdNo, null);
      setHoldRightGripBoardHold(holdNo, null);
    }

    if (hold.handHold == HandHold.oneHandedLeft && hold.leftGrip == null) {
      setHoldLeftGrip(holdNo, Grips.openHandL);
    }

    if (hold.handHold == HandHold.oneHandedRight) {
      setHoldLeftGrip(holdNo, null);
      setHoldLeftGripBoardHold(holdNo, null);
    }

    if (hold.handHold == HandHold.oneHandedRight && hold.rightGrip == null) {
      setHoldRightGrip(holdNo, Grips.openHandR);
    }

    if (hold.handHold == HandHold.twoHanded) {
      if (hold.leftGrip == null) {
        setHoldLeftGrip(holdNo, Grips.openHandL);
      }
      if (hold.rightGrip == null) {
        setHoldRightGrip(holdNo, Grips.openHandR);
      }
    }
  }
}
