import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/congratulations.screen.dart';
import 'package:app/services/audio_player.service.dart';
import 'package:app/services/navigation.service.dart';
import 'package:app/view_models/execution_sequence_builder.dart';
import 'package:app/view_models/execution_state.vm.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wakelock/wakelock.dart';

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
    Wakelock.enable();
    _audioPlayerService = AudioPlayerService();
    _workout = workout;
    _animationController = animationController;
    _sequence = sequenceBuilder(workout: workout);
    _navigationService = NavigationService();
    _currentSequenceIndex = 0;
    // This is only used for building the history
    _elapsedTimer = Stopwatch();
    _isPaused = false;
    _state$ = BehaviorSubject.seeded(_buildStateAndPlayBeepSound());
    _animationController.addListener(_setState);
    _animationController.addStatusListener(_animationStatusListener);
    _start();
  }

  ExecutionViewModelState _buildStateAndPlayBeepSound() {
    final int _seconds = _getDisplaySeconds();
    // Can't use state.type here because it's possible state has not been initialized yet.
    final bool _isStopwatch = _sequence[_currentSequenceIndex].type ==
        ExecutionEventType.stopwatchRestTimer;
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
      isStopwatch: _isStopwatch,
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
    _state$.add(_buildStateAndPlayBeepSound());
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (state.endSound.muted == false) {
        _audioPlayerService.play(state.endSound.filename);
      }
      _resetElapsedTimerAndAddToHistory();
      _nextSequence();
    }
  }

  void _resetElapsedTimerAndAddToHistory() {
    if (_elapsedTimer.isRunning) {
      _elapsedTimer.stop();

      if (_isPaused == false) {
        _events.add(ExecutionEvent((b) => b
          ..executionEventType = state.type
          ..elapsedMs = _elapsedTimer.elapsed.inMilliseconds));
      } else {
        _events.add(ExecutionEvent((b) => b
          ..executionEventType = ExecutionEventType.pauseTimer
          ..elapsedMs = _elapsedTimer.elapsed.inMilliseconds));
      }

      _elapsedTimer.reset();
    }
  }

  void _nextSequence() {
    final bool _lastSequence = _currentSequenceIndex == _sequence.length - 1;
    if (_lastSequence == true) {
      _stop();
    } else {
      _currentSequenceIndex++;
      _setState();
      _start();
    }
  }

  void _start() {
    if (state.isStopwatch == true) {
      _animationController.duration = Duration(minutes: 30);
      _animationController.reset();
      _animationController.forward();
    } else {
      final int _seconds = state.duration;
      _animationController.duration = Duration(seconds: _seconds);
      _animationController.reset();
      _animationController.forward();
    }
    _elapsedTimer.start();
  }

  void _stop() {
    _animationController.stop(canceled: true);
    _resetElapsedTimerAndAddToHistory();
    // settings _isPaused should be always be done after _resetElapsedTimerAndAddToHistory
    _isPaused = false;
    _events.add(ExecutionEvent(
        (b) => b..executionEventType = ExecutionEventType.stopEvent));

    if (_history.timeUnderTensionMs == 0) {
      _navigationService.pushNamed(Routes.workoutOverviewScreen);
    } else {
      _navigationService.pushNamed(Routes.congratulationsScreen,
          arguments:
              RateWorkoutArguments(workout: _workout, history: _history));
    }
    dispose();
  }

  void handleReadyTap() {
    _animationController.stop(canceled: false);
    _resetElapsedTimerAndAddToHistory();
    _events.add(ExecutionEvent(
        (b) => b..executionEventType = ExecutionEventType.readyEvent));
    _nextSequence();
  }

  void handlePauseTap() {
    _animationController.stop(canceled: false);
    _resetElapsedTimerAndAddToHistory();
    _isPaused = true;
    _events.add(ExecutionEvent(
        (b) => b..executionEventType = ExecutionEventType.pauseEvent));
    _elapsedTimer.start();
  }

  void handleSkipTap() {
    _resetElapsedTimerAndAddToHistory();
    _isPaused = false;
    _events.add(ExecutionEvent(
        (b) => b..executionEventType = ExecutionEventType.skipEvent));

    if (state.type == ExecutionEventType.hangTimer) {
      _nextSequence();
      _navigationService.pop();
    } else {
      final SequenceEvent _current = _sequence[_currentSequenceIndex];
      SequenceEvent _next;
      final List<SequenceEvent> _newSequence = []..addAll(_sequence);

      if (state.isStopwatch) {
        // There's always a preparation timer after the stopwatchRestTimer.
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

      if (!state.isStopwatch) {
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
      _elapsedTimer.start();
      _animationController.forward();
      _navigationService.pop();
    }
  }

  void handleStopTap() {
    _stop();
  }

  void handleResumeTap() {
    _resetElapsedTimerAndAddToHistory();
    _isPaused = false;
    _events.add(ExecutionEvent(
        (b) => b..executionEventType = ExecutionEventType.resumeEvent));
    _elapsedTimer.start();
    _animationController.forward();
    _navigationService.pop();
  }

  int _getDisplaySeconds() {
    if (_state$ == null) {
      return _sequence[_currentSequenceIndex].duration;
    }

    if (state.isStopwatch == true) {
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
    Wakelock.disable();
    _animationController.removeListener(_setState);
    _animationController.removeStatusListener(_animationStatusListener);
    _animationController.dispose();
    _elapsedTimer.stop();
    _state$.close();
  }
}
