import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:app/state/settings.state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/foundation.dart';

abstract class _ExecutionTitles {
  static const String preparation = 'preparation';
  static const String hang = 'hang';
  static const String recoveryRest = 'recovery rest';
}

class SequenceTimer {
  final int index;
  final SequenceTimerType type;
  final int duration;
  final double effectiveDurationMs;
  final bool skipped;
  final bool stopped;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final double addedWeight;
  final Sound endSound;
  final Sound beepSound;
  final int beepsBeforeEnd;
  final Color primaryColor;
  final String title;
  final String holdLabel;
  final Board board;
  final int totalSets;
  final int currentSet;
  final int totalHangsPerSet;
  final int currentHangPerSet;
  final int currentHang;
  final WeightSystem weightSystem;

  const SequenceTimer({
    this.index,
    @required this.type,
    @required this.duration,
    @required this.effectiveDurationMs,
    @required this.skipped,
    @required this.stopped,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.addedWeight,
    @required this.endSound,
    @required this.beepSound,
    @required this.beepsBeforeEnd,
    @required this.primaryColor,
    @required this.title,
    @required this.holdLabel,
    @required this.board,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalHangsPerSet,
    @required this.currentHangPerSet,
    @required this.currentHang,
    @required this.weightSystem,
  });

  SequenceTimer copyWith({
    int index,
    SequenceTimerType type,
    int duration,
    double effectiveDurationMs,
    bool skipped,
    bool stopped,
    BoardHold leftGripBoardHold,
    BoardHold rightGripBoardHold,
    Grip leftGrip,
    Grip rightGrip,
    double addedWeight,
    Sound endSound,
    Sound beepSound,
    int beepsBeforeEnd,
    Color primaryColor,
    String title,
    String holdLabel,
    Board board,
    int totalSets,
    int currentSet,
    int totalHangsPerSet,
    int currentHangPerSet,
    int currentHang,
    WeightSystem weightSystem,
  }) {
    return new SequenceTimer(
      index: index ?? this.index,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      effectiveDurationMs: effectiveDurationMs ?? this.effectiveDurationMs,
      skipped: skipped ?? this.skipped,
      stopped: stopped ?? this.stopped,
      leftGripBoardHold: leftGripBoardHold ?? this.leftGripBoardHold,
      rightGripBoardHold: rightGripBoardHold ?? this.rightGripBoardHold,
      leftGrip: leftGrip ?? this.leftGrip,
      rightGrip: rightGrip ?? this.rightGrip,
      addedWeight: addedWeight ?? this.addedWeight,
      endSound: endSound ?? this.endSound,
      beepSound: beepSound ?? this.beepSound,
      beepsBeforeEnd: beepsBeforeEnd ?? this.beepsBeforeEnd,
      primaryColor: primaryColor ?? this.primaryColor,
      title: title ?? this.title,
      holdLabel: holdLabel ?? this.holdLabel,
      board: board ?? this.board,
      totalSets: totalSets ?? this.totalSets,
      currentSet: currentSet ?? this.currentSet,
      totalHangsPerSet: totalHangsPerSet ?? this.totalHangsPerSet,
      currentHangPerSet: currentHangPerSet ?? this.currentHangPerSet,
      currentHang: currentHang ?? this.currentHang,
      weightSystem: weightSystem ?? this.weightSystem,
    );
  }
}

List<SequenceTimer> sequenceBuilder({@required Workout workout}) {
  Settings _settings = SettingsState().settings;
  List<SequenceTimer> _sequence = [];

  void _addPreparationRestSequence(
      {int currentSet,
      int currentHoldIndex,
      int currentHangPerSet,
      int currentHang}) {
    _sequence.add(SequenceTimer(
        stopped: false,
        skipped: false,
        addedWeight: workout.holds[currentHoldIndex].addedWeight,
        leftGripBoardHold: workout.holds[currentHoldIndex].leftGripBoardHold,
        rightGripBoardHold: workout.holds[currentHoldIndex].rightGripBoardHold,
        leftGrip: workout.holds[currentHoldIndex].leftGrip,
        rightGrip: workout.holds[currentHoldIndex].rightGrip,
        type: SequenceTimerType.preparationTimer,
        duration: _settings.preparationTimer,
        effectiveDurationMs: (_settings.preparationTimer * 1000).toDouble(),
        endSound: _settings.hangSound,
        beepSound: _settings.beepSound,
        beepsBeforeEnd: _settings.beepsBeforeHang,
        weightSystem: workout.weightSystem,
        primaryColor: styles.Colors.blue,
        title: _ExecutionTitles.preparation,
        holdLabel:
            'next up: hang $currentHangPerSet/${workout.totalHangsPerSet}',
        board: workout.board,
        totalSets: workout.sets,
        currentSet: currentSet,
        currentHangPerSet: currentHangPerSet,
        currentHang: currentHang,
        totalHangsPerSet: workout.totalHangsPerSet));
  }

  void _addHangSequence(
      {int currentSet,
      int currentHoldIndex,
      int currentHangPerSet,
      int currentHang}) {
    _sequence.add(
      SequenceTimer(
          stopped: false,
          skipped: false,
          addedWeight: workout.holds[currentHoldIndex].addedWeight,
          leftGripBoardHold: workout.holds[currentHoldIndex].leftGripBoardHold,
          rightGripBoardHold:
              workout.holds[currentHoldIndex].rightGripBoardHold,
          leftGrip: workout.holds[currentHoldIndex].leftGrip,
          rightGrip: workout.holds[currentHoldIndex].rightGrip,
          type: SequenceTimerType.hangTimer,
          duration: workout.holds[currentHoldIndex].hangTime,
          effectiveDurationMs:
              (workout.holds[currentHoldIndex].hangTime * 1000).toDouble(),
          endSound: _settings.restSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeRest,
          weightSystem: workout.weightSystem,
          primaryColor: styles.Colors.primary,
          title: _ExecutionTitles.hang,
          holdLabel: 'hang $currentHangPerSet/${workout.totalHangsPerSet}',
          board: workout.board,
          totalSets: workout.sets,
          currentSet: currentSet,
          currentHangPerSet: currentHangPerSet,
          currentHang: currentHang,
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }

  void _addCountdownRestSequence(
      {int currentSet,
      int currentHoldIndex,
      int currentHangPerSet,
      int currentHang}) {
    _sequence.add(
      SequenceTimer(
          skipped: false,
          stopped: false,
          addedWeight: workout.holds[currentHoldIndex].addedWeight,
          leftGripBoardHold: workout.holds[currentHoldIndex].leftGripBoardHold,
          rightGripBoardHold:
              workout.holds[currentHoldIndex].rightGripBoardHold,
          leftGrip: workout.holds[currentHoldIndex].leftGrip,
          rightGrip: workout.holds[currentHoldIndex].rightGrip,
          type: SequenceTimerType.countdownRestTimer,
          duration: workout.holds[currentHoldIndex].countdownRestDuration,
          effectiveDurationMs:
              (workout.holds[currentHoldIndex].countdownRestDuration * 1000)
                  .toDouble(),
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          weightSystem: workout.weightSystem,
          primaryColor: styles.Colors.blue,
          title: _ExecutionTitles.recoveryRest,
          holdLabel:
              'next up: hang $currentHangPerSet/${workout.totalHangsPerSet}',
          board: workout.board,
          totalSets: workout.sets,
          currentSet: currentSet,
          currentHangPerSet: currentHangPerSet,
          currentHang: currentHang,
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }

  void _addStopwatchRestSequence(
      {int currentSet,
      int currentHoldIndex,
      int currentHangPerSet,
      int currentHang}) {
    _sequence.add(
      SequenceTimer(
          stopped: false,
          skipped: false,
          addedWeight: workout.holds[currentHoldIndex].addedWeight,
          leftGripBoardHold: workout.holds[currentHoldIndex].leftGripBoardHold,
          rightGripBoardHold:
              workout.holds[currentHoldIndex].rightGripBoardHold,
          leftGrip: workout.holds[currentHoldIndex].leftGrip,
          rightGrip: workout.holds[currentHoldIndex].rightGrip,
          type: SequenceTimerType.stopwatchRestTimer,
          duration: 0,
          effectiveDurationMs: 0,
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          weightSystem: workout.weightSystem,
          primaryColor: styles.Colors.blue,
          title: _ExecutionTitles.recoveryRest,
          holdLabel:
              'next up: hang $currentHangPerSet/${workout.totalHangsPerSet}',
          board: workout.board,
          totalSets: workout.sets,
          currentSet: currentSet,
          currentHangPerSet: currentHangPerSet,
          currentHang: currentHang,
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }

  void _generate() {
    void Function(
        {int currentSet,
        int currentHoldIndex,
        int currentHangPerSet,
        int currentHang}) _addRestSequence;

    if (workout.stopwatchRestTimer) {
      _addRestSequence = _addStopwatchRestSequence;
    } else {
      _addRestSequence = _addCountdownRestSequence;
    }

    int _currentHang = 1;
    int _currentHangPerSet = 1;
    int _currentSet = 1;

    void _incrementSet() {
      _currentSet++;
      _currentHangPerSet = 1;
    }

    _addPreparationRestSequence(
        currentSet: _currentSet,
        currentHoldIndex: 0,
        currentHangPerSet: _currentHangPerSet,
        currentHang: _currentHang);

    while (_currentSet <= workout.sets) {
      for (var _currentHold = 1;
          _currentHold <= workout.holdCount;
          _currentHold++) {
        for (var _currentRepetitionPerHold = 1;
            _currentRepetitionPerHold <=
                workout.holds[_currentHold - 1].repetitions;
            _currentRepetitionPerHold++) {
          if (_currentHang == 1) {
            _addHangSequence(
                currentSet: _currentSet,
                currentHoldIndex: _currentHold - 1,
                currentHangPerSet: _currentHangPerSet,
                currentHang: _currentHang);
          } else {
            _addRestSequence(
                currentSet: _currentSet,
                currentHoldIndex: _currentHold - 1,
                currentHangPerSet: _currentHangPerSet,
                currentHang: _currentHang);
            if (workout.stopwatchRestTimer) {
              _addPreparationRestSequence(
                  currentSet: _currentSet,
                  currentHoldIndex: _currentHold - 1,
                  currentHangPerSet: _currentHangPerSet,
                  currentHang: _currentHang);
            }
            _addHangSequence(
                currentSet: _currentSet,
                currentHoldIndex: _currentHold - 1,
                currentHangPerSet: _currentHangPerSet,
                currentHang: _currentHang);
          }
          _currentHang++;
          _currentHangPerSet++;
        }
      }
      _incrementSet();
    }
  }

  _generate();

  return _sequence
      .asMap()
      .map((int index, SequenceTimer t) {
        return MapEntry(index, t.copyWith(index: index));
      })
      .values
      .toList();
}
