import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/state/settings_state.dart';
import 'package:app/styles/styles.dart' as styles;

abstract class _Titles {
  static const String preparation = 'preparation';
  static const String hang = 'hang';
  static const String recoveryRest = 'recovery rest';
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
    @required this.weightUnit,
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
  final WeightUnit weightUnit;
  final double addedWeight;
}

class CountdownScreenViewModel {
  CountdownScreenViewModel({@required Workout workout}) {
    _workout = workout;
    _settings = SettingsState().settings;
    _generateSequence();
  }

  Workout _workout;
  Workout get workout => _workout;
  Settings _settings;
  List<CountdownViewModel> sequence = [];

  void _generateSequence() {
    _addPreparationSequence();

    int _currentHang = 1;
    int _currentHangPerSet = 1;
    int _currentSet = 1;

    void _incrementSet() {
      _currentSet++;
      _currentHangPerSet = 1;
    }

    while (_currentSet <= _workout.sets) {
      for (var _currentHold = 1;
          _currentHold <= _workout.holdCount;
          _currentHold++) {
        for (var _currentRepetitionPerHold = 1;
            _currentRepetitionPerHold <=
                _workout.holds[_currentHold - 1].repetitions;
            _currentRepetitionPerHold++) {
          _addHoldSequence(_currentSet, _currentHold, _currentHangPerSet);
          if (_currentHang < workout.totalHangsPerSet * workout.sets) {
            _addRestAfterHangSequence(
                _currentSet, _currentHold, _currentHangPerSet);
          }
          _currentHang++;
          _currentHangPerSet++;
        }
      }
      _incrementSet();
    }
  }

  void _addPreparationSequence() {
    sequence.add(
      CountdownViewModel(
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          weightUnit: _workout.weightUnit,
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
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }

  void _addHoldSequence(
      int _currentSet, int _currentHold, int _currentHangPerSet) {
    sequence.add(
      CountdownViewModel(
          endSound: _settings.restSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeRest,
          weightUnit: _workout.weightUnit,
          addedWeight: _workout.holds[_currentHold - 1].addedWeight,
          color: styles.Colors.primary,
          title: _Titles.hang,
          duration: _workout.holds[_currentHold - 1].hangTime,
          holdLabel: _HoldLabels.hang,
          board: _workout.board,
          leftGrip: _workout.holds[_currentHold - 1].leftGrip,
          rightGrip: _workout.holds[_currentHold - 1].rightGrip,
          leftGripBoardHold: _workout.holds[_currentHold - 1].leftGripBoardHold,
          rightGripBoardHold:
              _workout.holds[_currentHold - 1].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHangPerSet,
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }

  void _addRestAfterHangSequence(
      int _currentSet, int _currentHold, int _currentHangPerSet) {
    sequence.add(
      CountdownViewModel(
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          weightUnit: _workout.weightUnit,
          addedWeight: _workout.holds[_currentHold - 1].addedWeight,
          color: styles.Colors.blue,
          title: _Titles.recoveryRest,
          duration: _workout.holds[_currentHold - 1].countdownRestDuration,
          holdLabel: _HoldLabels.nextUp,
          board: _workout.board,
          leftGrip: _workout.holds[_currentHold - 1].leftGrip,
          rightGrip: _workout.holds[_currentHold - 1].rightGrip,
          leftGripBoardHold: _workout.holds[_currentHold - 1].leftGripBoardHold,
          rightGripBoardHold:
              _workout.holds[_currentHold - 1].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHangPerSet,
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }
}
