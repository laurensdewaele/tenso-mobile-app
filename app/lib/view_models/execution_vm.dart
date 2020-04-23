import 'package:flutter/widgets.dart';

import 'package:rxdart/rxdart.dart';

import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/congratulations.dart';
import 'package:app/services/navigation.dart';
import 'package:app/view_models/execution_vm_state.dart';
import 'package:app/view_models/execution_sequence_builder.dart';

class ExecutionViewModel {
  Workout _workout;
  AnimationController _animationController;
  int _currentSequenceIndex;
  List<SequenceEvent> _sequence;
  NavigationService _navigationService;
  List<ExecutionEvent> _events = [];
  History get _history => History((b) => b..history.replace(_events));
  Stopwatch _pauseTimer;

  BehaviorSubject<ExecutionViewModelState> _state$;
  Stream<ExecutionViewModelState> get state$ => _state$.stream;
  ExecutionViewModelState get state => _state$.value;

  ExecutionViewModel(
      {@required Workout workout,
      @required AnimationController animationController}) {
    _workout = workout;
    _animationController = animationController;
    _sequence = sequenceBuilder(workout: workout);
    _navigationService = NavigationService();
    _currentSequenceIndex = 0;
    _pauseTimer = Stopwatch();
    _state$ = BehaviorSubject.seeded(_buildState());
    _animationController.addListener(_setState);
    _animationController.addStatusListener(_animationStatusListener);
    _start();
  }

  ExecutionViewModelState _buildState() {
    final _type = _sequence[_currentSequenceIndex].type;
    final bool _isStopwatch = _type == SequenceTypes.stopwatchRest;
    return ExecutionViewModelState(
      type: _sequence[_currentSequenceIndex].type,
      duration: _sequence[_currentSequenceIndex].duration,
      seconds: _getSeconds(),
      animatedBackgroundHeightFactor:
          _isStopwatch ? _animationController.value : 0,
      endSound: _sequence[_currentSequenceIndex].endSound,
      beepSound: _sequence[_currentSequenceIndex].endSound,
      beepsBeforeEnd: _sequence[_currentSequenceIndex].beepsBeforeEnd,
      primaryColor: _sequence[_currentSequenceIndex].primaryColor,
      title: _sequence[_currentSequenceIndex].title,
      holdLabel: _sequence[_currentSequenceIndex].holdLabel,
      board: _sequence[_currentSequenceIndex].board,
      leftGrip: _sequence[_currentSequenceIndex].leftGrip,
      rightGrip: _sequence[_currentSequenceIndex].rightGrip,
      leftGripBoardHold: _sequence[_currentSequenceIndex].leftGripBoardHold,
      rightGripBoardHold: _sequence[_currentSequenceIndex].rightGripBoardHold,
      totalSets: _sequence[_currentSequenceIndex].totalSets,
      currentSet: _sequence[_currentSequenceIndex].currentSet,
      totalHangsPerSet: _sequence[_currentSequenceIndex].totalHangsPerSet,
      currentHang: _sequence[_currentSequenceIndex].currentHang,
      weightUnit: _sequence[_currentSequenceIndex].weightUnit,
      addedWeight: _sequence[_currentSequenceIndex].addedWeight,
    );
  }

  void _setState() {
    _state$.add(_buildState());
  }


  void _addCurrentTimerToHistory() {
    ExecutionEventType _type;
    switch (state.type) {
      case SequenceTypes.hang:
        _type = ExecutionEventType.hangTimer;
        break;
      case SequenceTypes.stopwatchRest:
        _type = ExecutionEventType.stopwatchTimer;
        break;
      case SequenceTypes.countdownRest:
        _type = ExecutionEventType.countdownTimer;
        break;
      case SequenceTypes.preparationRest:
        _type = ExecutionEventType.preparationTimer;
        break;
    }
    _events.add(ExecutionEvent((b) => b
      ..type = _type
      ..elapsed = _getSeconds()
      ..targetDuration = state.duration));
  }


  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      print('animationStatus completed');
      _addCurrentTimerToHistory();
      _nextSequence();
    }
  }

  void _nextSequence() {
    final bool _lastSequence = _currentSequenceIndex == _sequence.length - 1;
    if (_lastSequence == true) {
      _stop();
    }
    _currentSequenceIndex++;
    _start();
  }

  void _start() {
    final _type = _sequence[_currentSequenceIndex].type;
    if (_type == SequenceTypes.stopwatchRest) {
      _animationController.duration = Duration(minutes: 30);
      _animationController.reset();
      _animationController.forward();
    } else {
      final int _seconds = _sequence[_currentSequenceIndex].duration;
      _animationController.duration = Duration(seconds: _seconds);
      _animationController.reset();
      _animationController.forward();
    }
  }

  void _stop() {
    _animationController.stop(canceled: true);
    _addCurrentTimerToHistory();
    _events.add(ExecutionEvent((b) => b..type = ExecutionEventType.stopEvent));
    _navigationService.pushNamed(Routes.congratulationsScreen,
        arguments: RateWorkoutArguments(workout: _workout, history: _history));
  }

  void handleReadyTap() {
    _animationController.stop(canceled: false);
    _addCurrentTimerToHistory();
    _events.add(ExecutionEvent((b) => b..type = ExecutionEventType.readyEvent));
    _nextSequence();
  }

  void handlePauseTap() {
    _animationController.stop(canceled: false);
    _pauseTimer.start();
    _events.add(ExecutionEvent((b) => b..type = ExecutionEventType.pauseEvent));
    _addCurrentTimerToHistory();
  }

  void handleSkipTap() {
    _pauseTimer.stop();
    if (state.type == SequenceTypes.hang) {
      _events.add(ExecutionEvent((b) => b
        ..type = ExecutionEventType.hangTimer
        ..elapsed = _getSeconds()
        ..targetDuration = state.duration));
      _nextSequence();
    } else {
      if (_currentSequenceIndex < _sequence.length - 1) {
        _sequence.removeAt(_currentSequenceIndex + 1);
      }
      if (_currentSequenceIndex < _sequence.length - 2) {
        _sequence.removeAt(_currentSequenceIndex + 2);
      }
      _animationController.forward();
      // TODO: Notify the user => enlarge indicator?
    }
    _events.add(ExecutionEvent((b) => b
      ..type = ExecutionEventType.pauseTimer
      ..elapsed = _pauseTimer.elapsed.inSeconds));
    _events.add(ExecutionEvent((b) => b..type = ExecutionEventType.skipEvent));
    _pauseTimer.reset();

    _navigationService.pop();
  }

  void handleStopTap() {
    _stop();
  }

  void handleResumeTap() {
    _pauseTimer.stop();
    _events.add(ExecutionEvent((b) => b
      ..type = ExecutionEventType.pauseTimer
      ..elapsed = _pauseTimer.elapsed.inSeconds));
    _pauseTimer.reset();
    _events
        .add(ExecutionEvent((b) => b..type = ExecutionEventType.resumeEvent));
    _animationController.forward();
    _navigationService.pop();
  }

  int _getSeconds() {
    if (_sequence[_currentSequenceIndex].type == SequenceTypes.stopwatchRest) {
      return (_animationController.duration.inSeconds *
              _animationController.value)
          .ceil();
    } else {
      return (_animationController.duration.inSeconds -
              _animationController.duration.inSeconds *
                  _animationController.value)
          .ceil();
    }
  }

  void dispose() {
    _animationController.removeListener(_setState);
    _animationController.removeStatusListener(_animationStatusListener);
    _animationController.dispose();
    _pauseTimer.stop();
    _state$.close();
  }
}
