import 'package:app/data/grips.dart';
import 'package:app/functions/board_hold_grip_compatibility.dart';
import 'package:app/functions/unit_conversion.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/unit.dart';
import 'package:app/models/workout.dart';
import 'package:app/services/toast.dart';
import 'package:app/view_models/app_state_vm.dart';
import 'package:flutter/cupertino.dart';

class HoldTabViewModel {
  HoldTabViewModel(AppState appState, ToastService toastService) {
    _toastService = toastService;
    _appState = appState;
  }

  ToastService _toastService;
  AppState _appState;
  Workout get _workout => _appState.workout;
  List<Hold> get _holdList => _appState.workout.holds.toList();

  void setHoldLeftGrip(int holdNo, Grip grip) {
    final _holds = _holdList;
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
    final _holds = _holdList;
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
    final _holds = _holdList;
    _holds[holdNo] = _holds[holdNo].rebuild((b) => b..handHold = handHold);
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldLeftGripBoardHold(int holdNo, BoardHold boardHold) {
    final _holds = _holdList;
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
    final _holds = _holdList;
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
    final _holds = _holdList;
    _holds[holdNo] =
        _holds[holdNo].rebuild((b) => b..repetitions = repetitions);
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldRestBetweenRepetitions(int holdNo, int seconds) {
    final _holds = _holdList;
    _holds[holdNo] =
        _holds[holdNo].rebuild((b) => b..restBetweenRepetitions = seconds);
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldHangTime(int holdNo, int seconds) {
    final _holds = _holdList;
    _holds[holdNo] = _holds[holdNo].rebuild((b) => b..hangTime = seconds);
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldAddedWeight(int holdNo, double addedWeight, Unit unit) {
    final _holds = _holdList;
    // Unit (metric or imperial) will be saved in kg's.
    // And converted to pounds when needed.
    double weight = addedWeight;

    if (unit == Unit.imperial) {
      weight = UnitConversion.convertPoundsToKg(addedWeight);
    }

    _holds[holdNo] = _holds[holdNo].rebuild((b) => b..addedWeight = weight);
    _appState.setWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void handleLeftHandSelected(int holdNo, HandHold handHold) {
    final _holds = _holdList;
    if (handHold == HandHold.oneHandedLeft && _holds[holdNo].leftGrip == null) {
      setHoldLeftGrip(holdNo, Grips.openHandL);
      setHoldLeftGripBoardHold(holdNo, _workout.board.defaultLeftGripHold);
    }

    if (handHold == HandHold.oneHandedLeft) {
      setHoldRightGrip(holdNo, null);
      setHoldRightGripBoardHold(holdNo, null);
    }
    setHoldHandHold(holdNo, handHold);
  }

  void handleRightHandSelected(int holdNo, HandHold handHold) {
    final _holds = _holdList;
    if (handHold == HandHold.oneHandedRight &&
        _holds[holdNo].rightGrip == null) {
      setHoldRightGrip(holdNo, Grips.openHandR);
      setHoldRightGripBoardHold(holdNo, _workout.board.defaultRightGripHold);
    }

    if (handHold == HandHold.oneHandedRight) {
      setHoldLeftGrip(holdNo, null);
      setHoldLeftGripBoardHold(holdNo, null);
    }
    setHoldHandHold(holdNo, handHold);
  }

  void handleOneHandedTap(int holdNo, HandHold handHold) {
    if (handHold == HandHold.oneHandedRight) {
      setHoldLeftGrip(holdNo, null);
      setHoldLeftGripBoardHold(holdNo, null);
    }
    if (handHold == HandHold.oneHandedLeft) {
      setHoldRightGrip(holdNo, null);
      setHoldRightGripBoardHold(holdNo, null);
    }
    setHoldHandHold(holdNo, handHold);
  }

  void handleTwoHandedTap(int holdNo, HandHold handHold) {
    final _holds = _holdList;
    final BoardHold defaultLeftGripBoardHold =
        _workout.board.defaultLeftGripHold;
    final BoardHold defaultRightGripBoardHold =
        _workout.board.defaultRightGripHold;

    if (_holds[holdNo].leftGrip == null) {
      final existingPosition = _holds[holdNo].rightGripBoardHold.position;
      if (existingPosition != defaultLeftGripBoardHold.position) {
        setHoldLeftGripBoardHold(holdNo, defaultLeftGripBoardHold);
      } else {
        final List<BoardHold> _boardHolds = _workout.board.boardHolds.toList();
        // TODO: Keep in check for other boards. This is only valid if the starting defaultBoardHold is not at position 0;
        final BoardHold newBoardHoldPosition = _boardHolds.firstWhere(
            (BoardHold boardHold) =>
                boardHold.position == defaultLeftGripBoardHold.position - 1);
        setHoldLeftGripBoardHold(holdNo, newBoardHoldPosition);
      }
      setHoldLeftGrip(holdNo, Grips.openHandL);
    }

    if (_holds[holdNo].rightGrip == null) {
      final existingPosition = _holds[holdNo].leftGripBoardHold.position;

      if (existingPosition != defaultRightGripBoardHold.position) {
        setHoldRightGripBoardHold(holdNo, defaultRightGripBoardHold);
      } else {
        final List<BoardHold> _boardHolds = _workout.board.boardHolds.toList();
        // TODO: Keep in check for other boards. This is only valid if the starting defaultBoardHold is not at position 0;
        final BoardHold newBoardHoldPosition = _boardHolds.firstWhere(
            (BoardHold boardHold) =>
                boardHold.position == defaultRightGripBoardHold.position + 1);
        setHoldRightGripBoardHold(holdNo, newBoardHoldPosition);
      }
      setHoldRightGrip(holdNo, Grips.openHandR);
    }
    setHoldHandHold(holdNo, handHold);
  }

  void handleRightGripSelected(int holdNo, Grip grip) {
    final _holds = _holdList;
    Widget errorMessage =
        checkCompatibility(grip, _holds[holdNo].rightGripBoardHold);
    if (errorMessage == null) {
      setHoldRightGrip(holdNo, grip);
    } else {
      _toastService.add(errorMessage);
    }
  }

  void handleLeftGripSelected(int holdNo, Grip grip) {
    final _holds = _holdList;
    Widget errorMessage =
        checkCompatibility(grip, _holds[holdNo].leftGripBoardHold);
    if (errorMessage == null) {
      setHoldLeftGrip(holdNo, grip);
    } else {
      _toastService.add(errorMessage);
    }
  }
}
