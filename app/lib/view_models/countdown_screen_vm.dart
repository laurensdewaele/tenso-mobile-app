import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/sound.dart';
import 'package:app/models/unit.dart';
import 'package:app/models/workout.dart';
import 'package:app/styles/styles.dart' as styles;

abstract class _Titles {
  static const String preparation = 'preparation';
  static const String hang = 'hang';
  static const String restBetweenHolds = 'rest between holds';
  static const String restBetweenSets = 'rest between sets';
  static const String restBetweenRepetitions = 'rest between repetitions';
}

abstract class _HoldLabels {
  static const String nextUp = 'next up';
  // It needs to be empty, otherwise there's a shift in height across screens
  static const String hang = '';
}

class CountdownViewModel {
  CountdownViewModel({
    @required this.color,
    @required this.title,
    @required this.duration,
    @required this.holdLabel,
    @required this.board,
    this.leftGrip,
    this.rightGrip,
    this.leftGripBoardHold,
    this.rightGripBoardHold,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalHangsPerSet,
    @required this.currentHang,
    this.addedWeight,
    @required this.unit,
    @required this.beepsBeforeEnd,
    @required this.beepSound,
    @required this.endSound,
  });

  final Sound endSound;
  final Sound beepSound;
  final int beepsBeforeEnd;
  final Color color;
  final String title;
  final int duration;
  final String holdLabel;
  final Board board;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final int totalSets;
  final int currentSet;
  final int totalHangsPerSet;
  final int currentHang;
  final Unit unit;
  final double addedWeight;
}

class CountdownScreenViewModel {
  CountdownScreenViewModel({Workout workout, Settings settings}) {
    _workout = workout;
    _settings = settings;
    _initialize();
  }

  Workout _workout;
  Workout get workout => _workout;
  Settings _settings;
  List<CountdownViewModel> sequence = [];

  void _initialize() {
    _addPreparationSequence();
    // Secondly, we need to generate all holds that need to be done.
    // This means looping over sets, than all the holds and we also need to
    // include the repetitions per hold.
    int _currentHang = 1;
    int _currentSet = 1;

    void _incrementSet() {
      _currentSet++;
      _currentHang = 1;
    }

    while (_currentSet <= _workout.sets) {
      for (var _currentHold = 0;
          _currentHold < _workout.holds.length;
          _currentHold++) {
        for (var _currentRepetitionPerHold = 1;
            _currentRepetitionPerHold <=
                _workout.holds[_currentHold].repetitions;
            _currentRepetitionPerHold++) {
          _addHoldSequence(_currentSet, _currentHold, _currentHang);

          _currentHang++;

          if (_workout.holds[_currentHold].repetitions > 1 &&
              _currentRepetitionPerHold <
                  _workout.holds[_currentHold].repetitions) {
            _addHoldRepetitionRestSequence(
                _currentSet, _currentHold, _currentHang);
          }
        }

        if (_workout.holds.length > 1 &&
            _currentHold < _workout.holds.length - 1) {
          _addHoldRestSequence(_currentSet, _currentHold, _currentHang);
        }
      }

      _incrementSet();
      if (_workout.sets > 1 && _currentSet <= _workout.sets) {
        _addSetRestSequence(_currentSet, _currentHang);
      }
    }
  }

  void _addPreparationSequence() {
    sequence.add(
      CountdownViewModel(
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          unit: _workout.holds[0].unit,
          addedWeight: _workout.holds[0].addedWeight,
          color: styles.Colors.blue,
          title: _Titles.preparation,
          duration: _settings.preparationTimer,
          holdLabel: _HoldLabels.nextUp,
          board: _workout.board,
          leftGrip: _workout.holds[0].leftGrip,
          rightGrip: _workout.holds[0].rightGrip,
          leftGripBoardHold: _workout.holds[0].leftGripBoardHold,
          rightGripBoardHold: _workout.holds[0].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: 1,
          currentHang: 1,
          totalHangsPerSet: _getTotalHangs(_workout.holds.toList())),
    );
  }

  void _addHoldSequence(int _currentSet, int _currentHold, int _currentHang) {
    sequence.add(
      CountdownViewModel(
          endSound: _settings.restSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeRest,
          unit: _workout.holds[_currentHold].unit,
          addedWeight: _workout.holds[_currentHold].addedWeight,
          color: styles.Colors.primary,
          title: _Titles.hang,
          duration: _workout.holds[_currentHold].hangTime,
          holdLabel: _HoldLabels.hang,
          board: _workout.board,
          leftGrip: _workout.holds[_currentHold].leftGrip,
          rightGrip: _workout.holds[_currentHold].rightGrip,
          leftGripBoardHold: _workout.holds[_currentHold].leftGripBoardHold,
          rightGripBoardHold: _workout.holds[_currentHold].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHang,
          totalHangsPerSet: _getTotalHangs(_workout.holds.toList())),
    );
  }

  void _addHoldRepetitionRestSequence(
      int _currentSet, int _currentHold, int _currentHang) {
    sequence.add(
      CountdownViewModel(
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          unit: _workout.holds[_currentHold].unit,
          addedWeight: _workout.holds[_currentHold].addedWeight,
          color: styles.Colors.blue,
          title: _Titles.restBetweenRepetitions,
          duration: _workout.holds[_currentHold].restBetweenRepetitions,
          holdLabel: _HoldLabels.nextUp,
          board: _workout.board,
          leftGrip: _workout.holds[_currentHold].leftGrip,
          rightGrip: _workout.holds[_currentHold].rightGrip,
          leftGripBoardHold: _workout.holds[_currentHold].leftGripBoardHold,
          rightGripBoardHold: _workout.holds[_currentHold].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHang,
          totalHangsPerSet: _getTotalHangs(_workout.holds.toList())),
    );
  }

  void _addHoldRestSequence(
      int _currentSet, int _currentHold, int _currentHang) {
    sequence.add(
      CountdownViewModel(
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          unit: _workout.holds[_currentHold + 1].unit,
          addedWeight: _workout.holds[_currentHold + 1].addedWeight,
          color: styles.Colors.blue,
          title: _Titles.restBetweenHolds,
          duration: _workout.restBetweenHolds,
          holdLabel: _HoldLabels.nextUp,
          board: _workout.board,
          leftGrip: _workout.holds[_currentHold + 1].leftGrip,
          rightGrip: _workout.holds[_currentHold + 1].rightGrip,
          leftGripBoardHold: _workout.holds[_currentHold + 1].leftGripBoardHold,
          rightGripBoardHold:
              _workout.holds[_currentHold + 1].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHang,
          totalHangsPerSet: _getTotalHangs(_workout.holds.toList())),
    );
  }

  void _addSetRestSequence(int _currentSet, int _currentHang) {
    sequence.add(
      CountdownViewModel(
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          unit: _workout.holds[0].unit,
          addedWeight: _workout.holds[0].addedWeight,
          color: styles.Colors.blue,
          title: _Titles.restBetweenSets,
          duration: _workout.restBetweenSets,
          holdLabel: _HoldLabels.nextUp,
          board: _workout.board,
          leftGrip: _workout.holds[0].leftGrip,
          rightGrip: _workout.holds[0].rightGrip,
          leftGripBoardHold: _workout.holds[0].leftGripBoardHold,
          rightGripBoardHold: _workout.holds[0].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHang,
          totalHangsPerSet: _getTotalHangs(_workout.holds.toList())),
    );
  }
}

int _getTotalHangs(List<Hold> holds) {
  int total = 0;
  holds.forEach((hold) => {total += hold.repetitions});
  return total;
}
