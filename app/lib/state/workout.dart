import 'package:flutter/cupertino.dart';

import 'package:app/data/grips.dart';
import 'package:app/functions/unit_conversion.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/units.dart';

// ignore_for_file: unnecessary_getters_setters

// Setters and getters are needed for Provider classes.
// Otherwise, we cannot make a call to notifyListeners() when setting as value.

class WorkoutModel extends ChangeNotifier {
  WorkoutModel(
      {int holdCount,
      int sets,
      int restBetweenHolds,
      int restBetweenSets,
      Board board,
      String difficulty,
      List<Hold> holds,
      String name,
      Color difficultyColor,
      int duration}) {
    _holdCount = holdCount;
    _sets = sets;
    _restBetweenHolds = restBetweenHolds;
    _restBetweenSets = restBetweenSets;
    _board = board;
    _difficulty = difficulty;
    _holds = holds;
    _name = name;
    _difficultyColor = difficultyColor;
    _duration = duration;
  }

  int _holdCount;
  int get holdCount => _holdCount;
  void setHoldCount(int count) {
    if (count < _holdCount) {
      _holds = _holds.take(count).toList();
    }
    if (count > holdCount) {
      final Hold defaultHold = _holds[0];
      final int difference = count - holdCount;
      final List<Hold> newHolds = List.generate(difference, (i) => defaultHold);
      _holds.addAll(newHolds);
    }
    _holdCount = count;
    notifyListeners();
  }

  int _sets;
  int get sets => _sets;
  void setSets(int s) {
    _sets = s;
    notifyListeners();
  }

  int _restBetweenHolds;
  int get restBetweenHolds => _restBetweenHolds;
  void setRestBetweenHolds(int s) {
    _restBetweenHolds = s;
    notifyListeners();
  }

  int _restBetweenSets;
  int get restBetweenSets => _restBetweenSets;
  void setRestBetweenSets(int s) {
    _restBetweenSets = s;
    notifyListeners();
  }

  Board _board;
  Board get board => _board;
  void setBoard(Board b) {
    _board = b;
    notifyListeners();
  }

  String _difficulty;
  String get difficulty => _difficulty;
  void setDifficulty(String d) {
    _difficulty = d;
    notifyListeners();
  }

  List<Hold> _holds;
  List<Hold> get holds => _holds;
  void setHolds(List<Hold> h) {
    _holds = h;
    notifyListeners();
  }

  String _name;
  String get name => _name;
  void setName(String n) {
    _name = n;
    notifyListeners();
  }

  Color _difficultyColor;
  Color get difficultyColor => _difficultyColor;
  void setDifficultyColor(Color c) {
    _difficultyColor = c;
    notifyListeners();
  }

  int _duration;
  int get duration => _duration;
  void setDuration(int n) {
    _duration = n;
    notifyListeners();
  }

  void setHoldLeftGrip(int holdNo, Grip grip) {
    _holds[holdNo] = Hold(
        leftGrip: grip,
        rightGrip: _holds[holdNo].rightGrip,
        handHold: _holds[holdNo].handHold,
        leftGripBoardHold: _holds[holdNo].leftGripBoardHold,
        rightGripBoardHold: _holds[holdNo].rightGripBoardHold,
        repetitions: _holds[holdNo].repetitions,
        restBetweenRepetitions: _holds[holdNo].restBetweenRepetitions,
        hangTime: _holds[holdNo].hangTime,
        addedWeight: _holds[holdNo].addedWeight);
    notifyListeners();
  }

  void setHoldRightGrip(int holdNo, Grip grip) {
    _holds[holdNo] = Hold(
        leftGrip: _holds[holdNo].leftGrip,
        rightGrip: grip,
        handHold: _holds[holdNo].handHold,
        leftGripBoardHold: _holds[holdNo].leftGripBoardHold,
        rightGripBoardHold: _holds[holdNo].rightGripBoardHold,
        repetitions: _holds[holdNo].repetitions,
        restBetweenRepetitions: _holds[holdNo].restBetweenRepetitions,
        hangTime: _holds[holdNo].hangTime,
        addedWeight: _holds[holdNo].addedWeight);
    notifyListeners();
  }

  void setHoldHandHold(int holdNo, HandHolds handHold) {
    _holds[holdNo] = Hold(
        leftGrip: _holds[holdNo].leftGrip,
        rightGrip: _holds[holdNo].rightGrip,
        handHold: handHold,
        leftGripBoardHold: _holds[holdNo].leftGripBoardHold,
        rightGripBoardHold: _holds[holdNo].rightGripBoardHold,
        repetitions: _holds[holdNo].repetitions,
        restBetweenRepetitions: _holds[holdNo].restBetweenRepetitions,
        hangTime: _holds[holdNo].hangTime,
        addedWeight: _holds[holdNo].addedWeight);
    _checkHands(holdNo);
    notifyListeners();
  }

  void setHoldLeftGripBoardHold(int holdNo, BoardHold boardHold) {
    _holds[holdNo] = Hold(
        leftGrip: _holds[holdNo].leftGrip,
        rightGrip: _holds[holdNo].rightGrip,
        handHold: _holds[holdNo].handHold,
        leftGripBoardHold: boardHold,
        rightGripBoardHold: _holds[holdNo].rightGripBoardHold,
        repetitions: _holds[holdNo].repetitions,
        restBetweenRepetitions: _holds[holdNo].restBetweenRepetitions,
        hangTime: _holds[holdNo].hangTime,
        addedWeight: _holds[holdNo].addedWeight);
    notifyListeners();
  }

  void setHoldRightGripBoardHold(int holdNo, BoardHold boardHold) {
    _holds[holdNo] = Hold(
        leftGrip: _holds[holdNo].leftGrip,
        rightGrip: _holds[holdNo].rightGrip,
        handHold: _holds[holdNo].handHold,
        leftGripBoardHold: _holds[holdNo].leftGripBoardHold,
        rightGripBoardHold: boardHold,
        repetitions: _holds[holdNo].repetitions,
        restBetweenRepetitions: _holds[holdNo].restBetweenRepetitions,
        hangTime: _holds[holdNo].hangTime,
        addedWeight: _holds[holdNo].addedWeight);
    notifyListeners();
  }

  void setHoldRepetitions(int holdNo, int reps) {
    _holds[holdNo] = Hold(
        leftGrip: _holds[holdNo].leftGrip,
        rightGrip: _holds[holdNo].rightGrip,
        handHold: _holds[holdNo].handHold,
        leftGripBoardHold: _holds[holdNo].leftGripBoardHold,
        rightGripBoardHold: _holds[holdNo].rightGripBoardHold,
        repetitions: reps,
        restBetweenRepetitions: _holds[holdNo].restBetweenRepetitions,
        hangTime: _holds[holdNo].hangTime,
        addedWeight: _holds[holdNo].addedWeight);
    notifyListeners();
  }

  void setHoldRestBetweenRepetitions(int holdNo, int seconds) {
    _holds[holdNo] = Hold(
        leftGrip: _holds[holdNo].leftGrip,
        rightGrip: _holds[holdNo].rightGrip,
        handHold: _holds[holdNo].handHold,
        leftGripBoardHold: _holds[holdNo].leftGripBoardHold,
        rightGripBoardHold: _holds[holdNo].rightGripBoardHold,
        repetitions: _holds[holdNo].repetitions,
        restBetweenRepetitions: seconds,
        hangTime: _holds[holdNo].hangTime,
        addedWeight: _holds[holdNo].addedWeight);
    notifyListeners();
  }

  void setHoldHangTime(int holdNo, int seconds) {
    _holds[holdNo] = Hold(
        leftGrip: _holds[holdNo].leftGrip,
        rightGrip: _holds[holdNo].rightGrip,
        handHold: _holds[holdNo].handHold,
        leftGripBoardHold: _holds[holdNo].leftGripBoardHold,
        rightGripBoardHold: _holds[holdNo].rightGripBoardHold,
        repetitions: _holds[holdNo].repetitions,
        restBetweenRepetitions: _holds[holdNo].restBetweenRepetitions,
        hangTime: seconds,
        addedWeight: _holds[holdNo].addedWeight);
    notifyListeners();
  }

  void setHoldAddedWeight(int holdNo, double addedWeight, Units unit) {
    // Units (metric or imperial) will be saved in kg's.
    // And converted to pounds when needed.
    double weight = addedWeight;

    if (unit == Units.imperial) {
      weight = UnitConversion.convertPoundsToKg(addedWeight);
    }

    _holds[holdNo] = Hold(
        leftGrip: _holds[holdNo].leftGrip,
        rightGrip: _holds[holdNo].rightGrip,
        handHold: _holds[holdNo].handHold,
        leftGripBoardHold: _holds[holdNo].leftGripBoardHold,
        rightGripBoardHold: _holds[holdNo].rightGripBoardHold,
        repetitions: _holds[holdNo].repetitions,
        restBetweenRepetitions: _holds[holdNo].restBetweenRepetitions,
        hangTime: _holds[holdNo].hangTime,
        addedWeight: weight);
    notifyListeners();
  }

  void setHoldOneHandedTap(int holdNo) {
    final hold = _holds[holdNo];

    if (hold.leftGrip == null) {
      setHoldHandHold(holdNo, HandHolds.oneHandedRight);
    }

    if (hold.rightGrip == null) {
      setHoldHandHold(holdNo, HandHolds.oneHandedLeft);
    }
  }

  void _checkHands(int holdNo) {
    final hold = _holds[holdNo];

    if (hold.handHold == HandHolds.oneHandedLeft) {
      setHoldRightGrip(holdNo, null);
    }

    if (hold.handHold == HandHolds.oneHandedLeft && hold.leftGrip == null) {
      setHoldLeftGrip(holdNo, Grips.openHandL);
    }

    if (hold.handHold == HandHolds.oneHandedRight) {
      setHoldLeftGrip(holdNo, null);
    }

    if (hold.handHold == HandHolds.oneHandedRight && hold.rightGrip == null) {
      setHoldRightGrip(holdNo, Grips.openHandR);
    }

    if (hold.handHold == HandHolds.twoHanded) {
      if (hold.leftGrip == null) {
        setHoldLeftGrip(holdNo, Grips.openHandL);
      }
      if (hold.rightGrip == null) {
        setHoldRightGrip(holdNo, Grips.openHandR);
      }
    }
  }
}
