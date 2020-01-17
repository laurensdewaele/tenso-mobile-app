import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';

// ignore_for_file: unnecessary_getters_setters

// Setters and getters are needed for Provider classes.
// Otherwise, we cannot make a call to notifyListeners() when setting as value.

class WorkoutModel extends ChangeNotifier {
  WorkoutModel(int holdCount, int sets, int restBetweenHolds,
      int restBetweenSets, Board board) {
    _holdCount = holdCount;
    _sets = sets;
    _restBetweenHolds = restBetweenHolds;
    _restBetweenSets = restBetweenSets;
    _board = board;
  }

  int _holdCount;
  int get holdCount => _holdCount;
  void setHoldCount(int count) {
    _holdCount = count;
    print('setting hold count to: $count');
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
//  final String _difficulty;
//  final List<Hold> _holds;
//  final String _name;
//  final Color _difficultyColor;
//  final int _duration;
}
