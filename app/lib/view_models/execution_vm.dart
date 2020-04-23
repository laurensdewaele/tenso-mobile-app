import 'package:flutter/widgets.dart';

import 'package:rxdart/rxdart.dart';

import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/congratulations.dart';
import 'package:app/services/audio_player.dart';
import 'package:app/services/navigation.dart';
import 'package:app/view_models/execution_vm_state.dart';
import 'package:app/view_models/execution_sequence_builder.dart';

class ExecutionViewModel {
  AudioPlayerService _audioPlayerService;
  Workout _workout;
  AnimationController _animationController;
  int _currentSequenceIndex;
  List<SequenceEvent> _sequence;
  NavigationService _navigationService;
  List<ExecutionEvent> _events = [];
  History get _history => History((b) => b..history.replace(_events));
  Stopwatch _elapsedTimer;
  bool _isPaused;

  BehaviorSubject<ExecutionViewModelState> _state$;
  Stream<ExecutionViewModelState> get state$ => _state$.stream;
  ExecutionViewModelState get state => _state$.value;

  ExecutionViewModel(
      {@required Workout workout,
      @required AnimationController animationController}) {
    _audioPlayerService = AudioPlayerService();
    _workout = workout;
    _animationController = animationController;
    _sequence = sequenceBuilder(workout: workout);
    _navigationService = NavigationService();
    _currentSequenceIndex = 0;
    // This is only used for building the history
    _elapsedTimer = Stopwatch();
    _isPaused = false;
    _state$ = BehaviorSubject.seeded(_buildStateAndPlaySounds());
    _animationController.addListener(_setState);
    _animationController.addStatusListener(_animationStatusListener);
    _start();
  }

  ExecutionViewModelState _buildStateAndPlaySounds() {
    final int _seconds = _getDisplaySeconds();
    final _type = _sequence[_currentSequenceIndex].type;
    final bool _isStopwatch = _type == SequenceTypes.stopwatchRest;
    final bool _isCountdown = !_isStopwatch;
    if (_state$ != null &&
        _isCountdown == true &&
        state.beepSound.muted == false &&
        _seconds != state.seconds &&
        _seconds != 0 &&
        _seconds <= state.beepsBeforeEnd) {
      _audioPlayerService.play(state.beepSound.filename);
    }

    return ExecutionViewModelState(
      type: _sequence[_currentSequenceIndex].type,
      duration: _sequence[_currentSequenceIndex].duration,
      seconds: _seconds,
      animatedBackgroundHeightFactor:
          _isStopwatch == false ? _animationController.value : 0,
      endSound: _sequence[_currentSequenceIndex].endSound,
      beepSound: _sequence[_currentSequenceIndex].beepSound,
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
    _state$.add(_buildStateAndPlaySounds());
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (state.endSound.muted == false) {
        _audioPlayerService.play(state.endSound.filename);
      }
      _elapsedTimer.stop();
      _addCurrentTimerToHistory();
      _nextSequence();
    }
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

    if (_isPaused == false) {
      _events.add(ExecutionEvent((b) => b
        ..type = _type
        ..elapsedMs = _elapsedTimer.elapsed.inMilliseconds));
    } else {
      _events.add(ExecutionEvent((b) => b
        ..type = ExecutionEventType.pauseTimer
        ..elapsedMs = _elapsedTimer.elapsed.inMilliseconds));
    }
  }

  void _nextSequence() {
    _elapsedTimer.reset();
    final bool _lastSequence = _currentSequenceIndex == _sequence.length - 1;
    if (_lastSequence == true) {
      _stop();
    } else {
      _currentSequenceIndex++;
      _start();
    }
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
    _elapsedTimer.start();
  }

  void _stop() {
    if (_elapsedTimer.isRunning == true) {
      _elapsedTimer.stop();
      _addCurrentTimerToHistory();
    }
    _animationController.stop(canceled: true);
    _isPaused = false;
    _events.add(ExecutionEvent((b) => b..type = ExecutionEventType.stopEvent));
    _navigationService.pushNamed(Routes.congratulationsScreen,
        arguments: RateWorkoutArguments(workout: _workout, history: _history));
  }

  void handleReadyTap() {
    _elapsedTimer.stop();
    _animationController.stop(canceled: false);
    _addCurrentTimerToHistory();
    _events.add(ExecutionEvent((b) => b..type = ExecutionEventType.readyEvent));
    _nextSequence();
  }

  void handlePauseTap() {
    _elapsedTimer.stop();
    _animationController.stop(canceled: false);
    _addCurrentTimerToHistory();
    _isPaused = true;
    _elapsedTimer.reset();
    _elapsedTimer.start();
    _events.add(ExecutionEvent((b) => b..type = ExecutionEventType.pauseEvent));
  }

  void handleSkipTap() {
    _elapsedTimer.stop();
    _addCurrentTimerToHistory();
    _isPaused = false;
    _events.add(ExecutionEvent((b) => b..type = ExecutionEventType.skipEvent));

    if (state.type == SequenceTypes.hang) {
      _nextSequence();
      _navigationService.pop();
    } else {
      final SequenceEvent _current = _sequence[_currentSequenceIndex];
      SequenceEvent _next;
      final List<SequenceEvent> _newSequence = []..addAll(_sequence);

      if (_workout.stopwatchRestTimer) {
        if (_currentSequenceIndex < _sequence.length - 3) {
          _next = _sequence[_currentSequenceIndex + 3];
          _newSequence[_currentSequenceIndex + 3] =
              _next.copyWith(type: _current.type, duration: _current.duration);
          _currentSequenceIndex = _currentSequenceIndex + 3;
        } else {
          _stop();
          return;
        }
      }

      if (!_workout.stopwatchRestTimer) {
        if (_currentSequenceIndex < _sequence.length - 2) {
          _next = _sequence[_currentSequenceIndex + 2];
          _newSequence[_currentSequenceIndex + 2] =
              _next.copyWith(type: _current.type, duration: _current.duration);
          _currentSequenceIndex = _currentSequenceIndex + 2;
        } else {
          _stop();
          return;
        }
      }

      _sequence = _newSequence;
      _setState();
      _elapsedTimer.reset();
      _elapsedTimer.start();
      _animationController.forward();
      _navigationService.pop();
    }
  }

  void handleStopTap() {
    _stop();
  }

  void handleResumeTap() {
    _elapsedTimer.stop();
    _addCurrentTimerToHistory();
    _elapsedTimer.reset();
    _elapsedTimer.start();
    _isPaused = false;
    _events
        .add(ExecutionEvent((b) => b..type = ExecutionEventType.resumeEvent));
    _animationController.forward();
    _navigationService.pop();
  }

  int _getDisplaySeconds() {
    if (_animationController.duration == null) {
      return 0;
    }

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
    _elapsedTimer.stop();
    _state$.close();
  }
}
