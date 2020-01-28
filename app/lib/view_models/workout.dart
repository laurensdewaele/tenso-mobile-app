import 'package:flutter/cupertino.dart';

import 'package:app/data/grips.dart';
import 'package:app/functions/unit_conversion.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/unit.dart';

// ignore_for_file: unnecessary_getters_setters

// Setters and getters are needed for Provider classes.
// Otherwise, we cannot make a call to notifyListeners() when setting as value.

class WorkoutViewModel extends ChangeNotifier {
  WorkoutViewModel(
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
    _holds[holdNo] =
        _holds[holdNo].rebuild((b) => b..leftGrip = grip.toBuilder());
    notifyListeners();
  }

  void setHoldRightGrip(int holdNo, Grip grip) {
    _holds[holdNo] =
        _holds[holdNo].rebuild((b) => b..rightGrip = grip.toBuilder());
    notifyListeners();
  }

  void setHoldHandHold(int holdNo, HandHold handHold) {
    _holds[holdNo] = _holds[holdNo].rebuild((b) => b..handHold = handHold);
    _checkHands(holdNo);
    notifyListeners();
  }

  void setHoldLeftGripBoardHold(int holdNo, BoardHold boardHold) {
    _holds[holdNo] = _holds[holdNo]
        .rebuild((b) => b..leftGripBoardHold = boardHold.toBuilder());
    notifyListeners();
  }

  void setHoldRightGripBoardHold(int holdNo, BoardHold boardHold) {
    _holds[holdNo] = _holds[holdNo]
        .rebuild((b) => b..rightGripBoardHold = boardHold.toBuilder());
    notifyListeners();
  }

  void setHoldRepetitions(int holdNo, int repetitions) {
    _holds[holdNo] =
        _holds[holdNo].rebuild((b) => b..repetitions = repetitions);
    notifyListeners();
  }

  void setHoldRestBetweenRepetitions(int holdNo, int seconds) {
    _holds[holdNo] =
        _holds[holdNo].rebuild((b) => b..restBetweenRepetitions = seconds);
    notifyListeners();
  }

  void setHoldHangTime(int holdNo, int seconds) {
    _holds[holdNo] = _holds[holdNo].rebuild((b) => b..hangTime = seconds);
    notifyListeners();
  }

  void setHoldAddedWeight(int holdNo, double addedWeight, Unit unit) {
    // Unit (metric or imperial) will be saved in kg's.
    // And converted to pounds when needed.
    double weight = addedWeight;

    if (unit == Unit.imperial) {
      weight = UnitConversion.convertPoundsToKg(addedWeight);
    }

    _holds[holdNo] = _holds[holdNo].rebuild((b) => b..addedWeight = weight);
    notifyListeners();
  }

  void setHoldOneHandedTap(int holdNo) {
    final hold = _holds[holdNo];

    if (hold.leftGrip == null) {
      setHoldHandHold(holdNo, HandHold.oneHandedRight);
    }

    if (hold.rightGrip == null) {
      setHoldHandHold(holdNo, HandHold.oneHandedLeft);
    }
  }

  void _checkHands(int holdNo) {
    final hold = _holds[holdNo];

    if (hold.handHold == HandHold.oneHandedLeft) {
      setHoldRightGrip(holdNo, null);
    }

    if (hold.handHold == HandHold.oneHandedLeft && hold.leftGrip == null) {
      setHoldLeftGrip(holdNo, Grips.openHandL);
    }

    if (hold.handHold == HandHold.oneHandedRight) {
      setHoldLeftGrip(holdNo, null);
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
