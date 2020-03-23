import 'package:flutter/cupertino.dart';

import 'package:app/data/grips.dart';
import 'package:app/helpers/grip_board_hold_compatibility.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/unit.dart';
import 'package:app/models/workout.dart';
import 'package:app/services/toast.dart';
import 'package:app/state/app_state.dart';
import 'package:app/view_models/workout_vm.dart';
import 'package:app/styles/styles.dart' as styles;

class HoldTabViewModel extends ChangeNotifier {
  HoldTabViewModel(
      ToastService toastService, WorkoutViewModel workoutViewModel) {
    _toastService = toastService;
    _workoutViewModel = workoutViewModel;
  }

  AppState _appState;
  ToastService _toastService;
  WorkoutViewModel _workoutViewModel;
  Workout get _workout => _appState?.workout;

  void update(AppState appState) {
    _appState = appState;
  }

  void setHoldLeftGrip(int holdNo, Grip grip) {
    final _holds = []..addAll(_appState?.workout?.holds?.toList());
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
    _workoutViewModel
        .setAndSaveWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldRightGrip(int holdNo, Grip grip) {
    final _holds = []..addAll(_appState?.workout?.holds?.toList());
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
    _workoutViewModel
        .setAndSaveWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldHandHold(int holdNo, HandHold handHold) {
    final _holds = []..addAll(_appState?.workout?.holds?.toList());
    _holds[holdNo] = _holds[holdNo].rebuild((b) => b..handHold = handHold);
    _workoutViewModel
        .setAndSaveWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldLeftGripBoardHold(int holdNo, BoardHold boardHold) {
    final _holds = []..addAll(_appState?.workout?.holds?.toList());
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
    _workoutViewModel
        .setAndSaveWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldRightGripBoardHold(int holdNo, BoardHold boardHold) {
    final _holds = []..addAll(_appState?.workout?.holds?.toList());
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
    _workoutViewModel
        .setAndSaveWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldRepetitions(int holdNo, int repetitions) {
    if (_validateInput(repetitions) == false) {
      return;
    }

    final _holds = []..addAll(_appState?.workout?.holds?.toList());
    _holds[holdNo] =
        _holds[holdNo].rebuild((b) => b..repetitions = repetitions);
    _workoutViewModel
        .setAndSaveWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldRestBetweenRepetitions(int holdNo, int seconds) {
    if (_validateInput(seconds) == false) {
      return;
    }

    final _holds = []..addAll(_appState?.workout?.holds?.toList());
    _holds[holdNo] =
        _holds[holdNo].rebuild((b) => b..restBetweenRepetitions = seconds);
    _workoutViewModel
        .setAndSaveWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldHangTime(int holdNo, int seconds) {
    if (_validateInput(seconds) == false) {
      return;
    }

    final _holds = []..addAll(_appState?.workout?.holds?.toList());
    _holds[holdNo] = _holds[holdNo].rebuild((b) => b..hangTime = seconds);
    _workoutViewModel
        .setAndSaveWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void setHoldAddedWeight(int holdNo, double addedWeight, Unit unit) {
    final _holds = []..addAll(_appState?.workout?.holds?.toList());
    _holds[holdNo] = _holds[holdNo].rebuild((b) => b
      ..addedWeight = addedWeight
      ..unit = unit);
    _workoutViewModel
        .setAndSaveWorkout(_workout.rebuild((b) => b..holds.replace(_holds)));
  }

  void handleLeftHandSelected(int holdNo, HandHold handHold) {
    final _holds = []..addAll(_appState?.workout?.holds?.toList());
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
    final _holds = []..addAll(_appState?.workout?.holds?.toList());
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
    final _holds = []..addAll(_appState?.workout?.holds?.toList());
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
    final _holds = []..addAll(_appState?.workout?.holds?.toList());
    Widget errorMessage = checkGripBoardHoldCompatibility(
        grip, _holds[holdNo].rightGripBoardHold);
    if (errorMessage == null) {
      setHoldRightGrip(holdNo, grip);
    } else {
      _toastService.add(errorMessage);
    }
  }

  void handleLeftGripSelected(int holdNo, Grip grip) {
    final _holds = []..addAll(_appState?.workout?.holds?.toList());
    Widget errorMessage =
        checkGripBoardHoldCompatibility(grip, _holds[holdNo].leftGripBoardHold);
    if (errorMessage == null) {
      setHoldLeftGrip(holdNo, grip);
    } else {
      _toastService.add(errorMessage);
    }
  }

  bool _validateInput(int n) {
    if (n < 1) {
      _toastService.add(RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Please input a value ',
            style: styles.Lato.sBlack,
            children: [
              TextSpan(text: 'bigger than 0.', style: styles.Lato.sBlackBold),
            ]),
      ));
      return false;
    } else {
      return true;
    }
  }
}
