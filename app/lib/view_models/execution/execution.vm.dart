import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/congratulations.screen.dart';
import 'package:app/services/audio_player.service.dart';
import 'package:app/services/navigation.service.dart';
import 'package:app/view_models/execution/execution_sequence_builder.dart';
import 'package:app/view_models/execution/execution_state.vm.dart';
import 'package:app/view_models/execution/log_hangs_dialog.vm.dart';
import 'package:app/widgets/execution/log_hangs_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wakelock/wakelock.dart';

class ExecutionViewModel {
  AudioPlayerService _audioPlayerService;
  Workout _workout;
  AnimationController _animationController;
  int _currentSequenceIndex;
  List<SequenceTimer> _sequence;
  NavigationService _navigationService;
  List<PastHang> get pastHangs => _getPastHangs();
  int get totalHangs => _workout.totalHangs;

  BehaviorSubject<ExecutionState> _state$;
  Stream<ExecutionState> get state$ => _state$.stream;
  ExecutionState get state => _state$.value;

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
    _state$ = BehaviorSubject.seeded(_buildStateAndPlayBeepSound());
    _animationController.addListener(_setState);
    _animationController.addStatusListener(_animationStatusListener);
    _start();
  }

  List<PastHang> _getPastHangs() {
    final List<SequenceTimer> _pastHangEvents = _sequence
        .where((SequenceTimer t) =>
            t.type == SequenceTimerType.hangTimer &&
            t.currentHang < state.currentHang)
        .toList();
    return _pastHangEvents.map((SequenceTimer t) {
      return PastHang(
        skipped: t.skipped,
        duration: t.duration,
        durationInput: t.duration.toString(),
        addedWeight: t.hold.addedWeight,
        addedWeightInput: t.hold.addedWeight.toString(),
        totalSets: t.totalSets,
        totalHangsPerSet: t.totalHangsPerSet,
        currentHangPerSet: t.currentHangPerSet,
        currentSet: t.currentSet,
        currentHang: t.currentHang,
        isSelected: t.currentHang == state.currentHang - 1,
        boardAspectRatio: t.board.aspectRatio,
        rightGrip: t.hold.rightGrip,
        leftGrip: t.hold.leftGrip,
        leftGripBoardHold: t.hold.leftGripBoardHold,
        rightGripBoardHold: t.hold.rightGripBoardHold,
        handToBoardHeightRatio: t.board.handToBoardHeightRatio,
        customBoardHoldImages: t.board.customBoardHoldImages?.toList(),
        imageAsset: t.board.imageAsset,
        weightUnit: t.weightSystem.unit,
        imageAssetWidth: t.board.imageAssetWidth,
      );
    }).toList();
  }

  ExecutionState _buildStateAndPlayBeepSound() {
    final int _seconds = _getDisplaySeconds();
    // Can't use state.type here because it's possible state has not been initialized yet.
    final bool _isStopwatch = _sequence[_currentSequenceIndex].type ==
        SequenceTimerType.stopwatchRestTimer;
    final bool _isCountdown = !_isStopwatch;
    if (_state$ != null &&
        _isCountdown == true &&
        state.beepSound.muted == false &&
        _seconds != state.seconds &&
        _seconds != 0 &&
        _seconds <= state.beepsBeforeEnd) {
      _audioPlayerService.play(state.beepSound.filename);
    }

    return ExecutionState(
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
      _nextSequence();
    }
  }

  void _nextSequence() {
    final bool _lastSequence = _currentSequenceIndex == _sequence.length - 1;
    if (_lastSequence == true) {
      _stop();
    } else {
      _currentSequenceIndex++;
      if (_sequence[_currentSequenceIndex].skipped == true) {
        _nextSequence();
      }
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
  }

  void _stop() {
    _animationController.stop(canceled: true);

    _sequence = _sequence.map((SequenceTimer t) {
      if (_currentSequenceIndex == t.index) {
        return t.copyWith(duration: state.seconds);
      } else if (_currentSequenceIndex < t.index) {
        return t.copyWith(skipped: true);
      } else {
        return t;
      }
    }).toList();

    History _history = _generateHistory();
    if (_history.timerUnderTensionS == 0) {
      _navigationService.pushNamed(Routes.workoutOverviewScreen);
    } else {
      _navigationService.pushNamed(Routes.congratulationsScreen,
          arguments:
              RateWorkoutArguments(workout: _workout, history: _history));
    }
    dispose();
  }

  History _generateHistory() {
    final List<SequenceTimerLog> _logs = _sequence
        .map((SequenceTimer t) => SequenceTimerLog((b) => b
          ..duration = t.duration
          ..type = t.type
          ..skipped = t.skipped))
        .toList();

    return History((b) => b..sequenceTimerLogs.addAll(_logs));
  }

  void handleReadyTap() {
    _animationController.stop(canceled: false);
    _nextSequence();
  }

  void handlePauseTap() {
    _animationController.stop(canceled: false);
  }

  void handleSkipTap() {
    _setDuration() {
      _sequence[_currentSequenceIndex] = _sequence[_currentSequenceIndex]
          .copyWith(duration: state.seconds, skipped: true);
    }

    if (state.type == SequenceTimerType.hangTimer) {
      _setDuration();
      _nextSequence();
      _navigationService.pop();
      return;
    }

    final int _currentIndex = _sequence[_currentSequenceIndex].index;
    final int _nextIndex = _workout.stopwatchRestTimer
        ? _sequence[_currentSequenceIndex].index + 3
        : _sequence[_currentSequenceIndex].index + 2;

    final _nextHang = _sequence.firstWhere(
        (SequenceTimer t) =>
            t.index > _nextIndex && t.type == SequenceTimerType.hangTimer,
        orElse: () => null);

    if (_nextHang == null) {
      _setDuration();
      _stop();
      _navigationService.pop();
      return;
    }

    _sequence = _sequence.map((SequenceTimer t) {
      if (t.index > _currentIndex && t.index <= _nextIndex) {
        return t.copyWith(duration: 0, skipped: true);
      } else {
        return t;
      }
    }).toList();

    _sequence[_currentSequenceIndex] =
        _sequence[_currentSequenceIndex].copyWith(
      index: _nextIndex,
      skipped: true,
      hold: _nextHang.hold,
      holdLabel: _nextHang.holdLabel,
      board: _nextHang.board,
      currentSet: _nextHang.currentSet,
      currentHangPerSet: _nextHang.currentHangPerSet,
      currentHang: _nextHang.currentHang,
    );

    _setState();
    _animationController.forward();
    _navigationService.pop();
  }

  void handleStopTap() {
    _stop();
  }

  void handleResumeTap() {
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

  void handleLoggedHangs(List<LoggedHangs> loggedHangs) {}

  void dispose() {
    Wakelock.disable();
    _animationController.removeListener(_setState);
    _animationController.removeStatusListener(_animationStatusListener);
    _animationController.dispose();
    _state$.close();
  }
}
