import 'package:flutter/widgets.dart';

import 'package:app/models/models.dart';
import 'package:app/state/settings_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/execution/execution.dart';

class ExecutionViewModel {
  AnimationController _animationController;
  TickerProvider _tickerProvider;
  int _currentSequenceIndex = 0;
  List<_SequenceEvent> _sequence;

  ExecutionViewModel(
      {Workout workout,
      AnimationController animationController,
      TickerProvider vsync}) {
    _animationController = animationController;
    _sequence = _sequenceBuilder(workout: workout);
  }
}

enum _SequenceTypes { hang, preparationRest, countdownRest, stopwatchRest }

class _SequenceEvent {
  final _SequenceTypes type;
  final int duration;

  final Sound endSound;
  final Sound beepSound;
  final int beepsBeforeEnd;
  final Color primaryColor;
  final String title;
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

  const _SequenceEvent({
    @required this.type,
    @required this.duration,
    @required this.endSound,
    @required this.beepSound,
    @required this.beepsBeforeEnd,
    @required this.primaryColor,
    @required this.title,
    @required this.holdLabel,
    @required this.board,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalHangsPerSet,
    @required this.currentHang,
    @required this.weightUnit,
    @required this.addedWeight,
  });
}

List<_SequenceEvent> _sequenceBuilder({@required Workout workout}) {
  Settings _settings = SettingsState().settings;
  Workout _workout = workout;

  List<_SequenceEvent> _sequence = [];

  void _addPreparationSequence() {
    _sequence.add(_SequenceEvent(
        type: _SequenceTypes.preparationRest,
        duration: _settings.preparationTimer,
        endSound: _settings.hangSound,
        beepSound: _settings.beepSound,
        beepsBeforeEnd: _settings.beepsBeforeHang,
        weightUnit: _workout.weightUnit,
        addedWeight: _workout.holds[0].addedWeight,
        primaryColor: styles.Colors.blue,
        title: ExecutionTitles.preparation,
        holdLabel: ExecutionHoldLabels.nextUp,
        board: _workout.board,
        leftGrip: _workout.holds[0].leftGrip,
        rightGrip: _workout.holds[0].rightGrip,
        leftGripBoardHold: _workout.holds[0].leftGripBoardHold,
        rightGripBoardHold: _workout.holds[0].rightGripBoardHold,
        totalSets: _workout.sets,
        currentSet: 1,
        currentHang: 1,
        totalHangsPerSet: workout.totalHangsPerSet));
  }

  void _addHangSequence(
      int _currentSet, int _currentHold, int _currentHangPerSet) {
    _sequence.add(
      _SequenceEvent(
          type: _SequenceTypes.hang,
          duration: _workout.holds[_currentHold - 1].hangTime,
          endSound: _settings.restSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeRest,
          weightUnit: _workout.weightUnit,
          addedWeight: _workout.holds[_currentHold - 1].addedWeight,
          primaryColor: styles.Colors.primary,
          title: ExecutionTitles.hang,
          holdLabel: ExecutionHoldLabels.hang,
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

  void _addCountdownRestSequence(
      int _currentSet, int _currentHold, int _currentHangPerSet) {
    _sequence.add(
      _SequenceEvent(
          type: _SequenceTypes.countdownRest,
          duration: _workout.holds[_currentHold - 1].countdownRestDuration,
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          weightUnit: _workout.weightUnit,
          addedWeight: _workout.holds[_currentHold - 1].addedWeight,
          primaryColor: styles.Colors.blue,
          title: ExecutionTitles.recoveryRest,
          holdLabel: ExecutionHoldLabels.nextUp,
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

  return _sequence;
}
