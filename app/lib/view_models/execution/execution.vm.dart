import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/congratulations.screen.dart';
import 'package:app/services/audio_player.service.dart';
import 'package:app/services/navigation.service.dart';
import 'package:app/state/workouts.state.dart';
import 'package:app/view_models/execution/edit_hangs_dialog.vm.dart';
import 'package:app/view_models/execution/execution_sequence_builder.dart';
import 'package:app/view_models/execution/execution_state.vm.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wakelock/wakelock.dart';

class ExecutionViewModel {
  WorkoutsState _workoutsState;
  AudioPlayerService _audioPlayerService;
  Workout _workout;
  AnimationController _animationController;
  int _currentSequenceIndex;
  List<SequenceEvent> _sequence;
  NavigationService _navigationService;
  List<ExecutionEvent> _eventLog = [];
  List<ExecutionEvent> _hangTimes = [];
  Stopwatch _elapsedTimer;
  bool _isPaused;
  List<Hang> get hangs => _getHangs();
  int get totalHangs => _workout.totalHangs;

  BehaviorSubject<ExecutionViewModelState> _state$;
  Stream<ExecutionViewModelState> get state$ => _state$.stream;
  ExecutionViewModelState get state => _state$.value;

  ExecutionViewModel(
      {@required Workout workout,
      @required AnimationController animationController}) {
    Wakelock.enable();
    _workoutsState = WorkoutsState();
    _audioPlayerService = AudioPlayerService();
    _workout = workout;
    _animationController = animationController;
    _sequence = sequenceBuilder(workout: workout);
    _hangTimes = _sequence
        .where((SequenceEvent sequenceEvent) =>
            sequenceEvent.type == ExecutionEventType.hangTimer)
        .map((SequenceEvent sequenceEvent) => ExecutionEvent((b) => b
          ..executionEventType = ExecutionEventType.hangTimer
          ..elapsedMs = sequenceEvent.duration * 1000))
        .toList();
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

  List<Hang> _getHangs() {
    final List<SequenceEvent> _hangEvents = _sequence
        .where((SequenceEvent e) => e.type == ExecutionEventType.hangTimer)
        .toList();
    return _hangEvents.map((SequenceEvent e) {
      return Hang(
        duration: e.duration,
        durationInput: e.duration.toString(),
        addedWeight: e.hold.addedWeight,
        addedWeightInput: e.hold.addedWeight.toString(),
        totalSets: e.totalSets,
        totalHangsPerSet: e.totalHangsPerSet,
        currentHangPerSet: e.currentHangPerSet,
        currentSet: e.currentSet,
        currentHang: e.currentHang,
        isSelected: e.currentHang == state.currentHang,
        isPastHang: e.currentHang < state.currentHang,
        boardAspectRatio: e.board.aspectRatio,
        rightGrip: e.hold.rightGrip,
        leftGrip: e.hold.leftGrip,
        leftGripBoardHold: e.hold.leftGripBoardHold,
        rightGripBoardHold: e.hold.rightGripBoardHold,
        handToBoardHeightRatio: e.board.handToBoardHeightRatio,
        customBoardHoldImages: e.board.customBoardHoldImages?.toList(),
        imageAsset: e.board.imageAsset,
        weightUnit: e.weightSystem.unit,
        imageAssetWidth: e.board.imageAssetWidth,
      );
    }).toList();
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
      currentHang: _sequence[_currentSequenceIndex].currentHang,
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
      leftGrip: _sequence[_currentSequenceIndex].hold.leftGrip,
      rightGrip: _sequence[_currentSequenceIndex].hold.rightGrip,
      leftGripBoardHold:
          _sequence[_currentSequenceIndex].hold.leftGripBoardHold,
      rightGripBoardHold:
          _sequence[_currentSequenceIndex].hold.rightGripBoardHold,
      totalSets: _sequence[_currentSequenceIndex].totalSets,
      currentSet: _sequence[_currentSequenceIndex].currentSet,
      totalHangsPerSet: _sequence[_currentSequenceIndex].totalHangsPerSet,
      currentHangPerSet: _sequence[_currentSequenceIndex].currentHangPerSet,
      weightSystem: _sequence[_currentSequenceIndex].weightSystem,
      addedWeight: _sequence[_currentSequenceIndex].hold.addedWeight,
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
        _eventLog.add(ExecutionEvent((b) => b
          ..executionEventType = state.type
          ..elapsedMs = _elapsedTimer.elapsed.inMilliseconds));
      } else {
        _eventLog.add(ExecutionEvent((b) => b
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
    _eventLog.add(ExecutionEvent(
        (b) => b..executionEventType = ExecutionEventType.stopEvent));

    History _history = _generateHistory();
    if (_history.timeUnderTensionMs == 0) {
      _navigationService.pushNamed(Routes.workoutOverviewScreen);
    } else {
      _navigationService.pushNamed(Routes.congratulationsScreen,
          arguments:
              RateWorkoutArguments(workout: _workout, history: _history));
    }
    dispose();
  }

  History _generateHistory() {
    return History(
        (b) => b..eventLog.replace(_eventLog)..hangTimes.replace(_hangTimes));
  }

  void handleReadyTap() {
    _animationController.stop(canceled: false);
    _resetElapsedTimerAndAddToHistory();
    _eventLog.add(ExecutionEvent(
        (b) => b..executionEventType = ExecutionEventType.readyEvent));
    _nextSequence();
  }

  void handlePauseTap() {
    _animationController.stop(canceled: false);
    _resetElapsedTimerAndAddToHistory();
    _isPaused = true;
    _eventLog.add(ExecutionEvent(
        (b) => b..executionEventType = ExecutionEventType.pauseEvent));
    _elapsedTimer.start();
  }

  void handleSkipTap() {
    _resetElapsedTimerAndAddToHistory();
    _isPaused = false;
    _eventLog.add(ExecutionEvent(
        (b) => b..executionEventType = ExecutionEventType.skipEvent));

    final SequenceEvent _current = _sequence[_currentSequenceIndex];
    SequenceEvent _next;
    final List<SequenceEvent> _newSequence = []..addAll(_sequence);

    if (state.type == ExecutionEventType.hangTimer) {
      _newSequence[_currentSequenceIndex] =
          _sequence[_currentSequenceIndex].copyWith(duration: state.seconds);
      _sequence = _newSequence;
      _nextSequence();
      _navigationService.pop();
    } else {
      SequenceEvent _skippedHangSequence;
      int _skippedHangSequenceIndex;
      _sequence.asMap().forEach((int index, SequenceEvent sequenceEvent) {
        if (_skippedHangSequence == null &&
            index > _currentSequenceIndex &&
            sequenceEvent.type == ExecutionEventType.hangTimer) {
          _skippedHangSequence = sequenceEvent;
          _skippedHangSequenceIndex = index;
        }
      });
      if (_skippedHangSequence != null) {
        _newSequence[_skippedHangSequenceIndex] =
            _skippedHangSequence.copyWith(duration: 0);
      }

      if (_workout.stopwatchRestTimer == true) {
        if (_currentSequenceIndex < _sequence.length - 3) {
          _next = _sequence[_currentSequenceIndex + 3];
          _newSequence[_currentSequenceIndex + 3] =
              _next.copyWith(duration: _current.duration);
          _currentSequenceIndex = _currentSequenceIndex + 3;
        } else {
          _stop();
          return;
        }
      }

      if (_workout.countdownRestTimer == true) {
        if (_currentSequenceIndex < _sequence.length - 2) {
          _next = _sequence[_currentSequenceIndex + 2];
          _newSequence[_currentSequenceIndex + 2] = _next.copyWith(
              type: _current.type,
              duration: _current.duration,
              title: _current.title);
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
    _eventLog.add(ExecutionEvent(
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

  void handleEditHangsTap() {
    _elapsedTimer.stop();
    _eventLog.add(ExecutionEvent((b) => b
      ..executionEventType = ExecutionEventType.pauseTimer
      ..elapsedMs = _elapsedTimer.elapsed.inMilliseconds));
    _eventLog.add(ExecutionEvent(
        (b) => b..executionEventType = ExecutionEventType.editHangsEvent));
    _elapsedTimer.reset();
    _elapsedTimer.start();
  }

  void handleEditedHangs(List<EditedHang> editedHangs) {
    _elapsedTimer.stop();
    _eventLog.add(ExecutionEvent((b) => b
      ..executionEventType = ExecutionEventType.editHangsTimer
      ..elapsedMs = _elapsedTimer.elapsed.inMilliseconds));
    _eventLog.add(ExecutionEvent(
        (b) => b..executionEventType = ExecutionEventType.editHangsDoneEvent));
    _elapsedTimer.reset();
    _elapsedTimer.start();

    _sequence = _sequence.map((SequenceEvent sequenceEvent) {
      final _editedHang = editedHangs.firstWhere((EditedHang editedHang) =>
          editedHang.currentHang == sequenceEvent.currentHang);

      if (sequenceEvent.type == ExecutionEventType.hangTimer) {
        return sequenceEvent.copyWith(
            hold: sequenceEvent.hold.rebuild((b) => b
              ..addedWeight = _editedHang.addedWeight
              ..hangTime =
                  _editedHang.duration > 0 ? _editedHang.duration : b.hangTime),
            duration: _editedHang.duration);
      } else if (sequenceEvent.type == ExecutionEventType.countdownRestTimer ||
          sequenceEvent.type == ExecutionEventType.stopwatchRestTimer) {
        return sequenceEvent.copyWith(
            hold: sequenceEvent.hold
                .rebuild((b) => b..addedWeight = _editedHang.addedWeight));
      } else {
        return sequenceEvent;
      }
    }).toList();

    _hangTimes = editedHangs
        .map((EditedHang editedHang) => ExecutionEvent((b) => b
          ..executionEventType = ExecutionEventType.hangTimer
          ..elapsedMs = editedHang.duration * 1000))
        .toList();

    _replaceExistingWorkoutFromEditedHangs(editedHangs);
  }

  void _replaceExistingWorkoutFromEditedHangs(List<EditedHang> editedHangs) {
    final List<SequenceEvent> _hangSequences = _sequence
        .where((SequenceEvent sequenceEvent) =>
            sequenceEvent.type == ExecutionEventType.hangTimer)
        .toList();
    _hangSequences.removeWhere((hangSequence) => hangSequence.currentSet > 1);

    final List<Hold> _allHolds = _hangSequences
        .map((SequenceEvent sequenceEvent) =>
            sequenceEvent.hold.rebuild((b) => b..repetitions = 1))
        .toList();

    List<Hold> _nonDuplicateHolds = [];
    Hold _tempHold;
    _allHolds.forEach((hold) {
      if (hold.equalsWithoutRepetitions(_tempHold) == true) {
        final Hold _existingHold = _nonDuplicateHolds.firstWhere(
            (existingHold) => existingHold.equalsWithoutRepetitions(hold));
        if (_existingHold != null) {
          final int _existingHoldIndex =
              _nonDuplicateHolds.indexOf(_existingHold);
          final List<Hold> _newHolds = []..addAll(_nonDuplicateHolds);
          _newHolds[_existingHoldIndex] = _existingHold
              .rebuild((b) => b..repetitions = _existingHold.repetitions + 1);
          _nonDuplicateHolds = _newHolds;
        } else {
          _nonDuplicateHolds.add(hold);
        }
      } else {
        _nonDuplicateHolds.add(hold);
      }
      _tempHold = hold;
    });

    _workout = _workout.rebuild((b) => b
      ..holds.replace(_nonDuplicateHolds)
      ..holdCount = _nonDuplicateHolds.length);
    _workoutsState.editWorkout(_workout);
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
