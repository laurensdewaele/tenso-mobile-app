import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/screens/rate_workout.screen.dart';
import 'package:tenso_app/services/audio_player.service.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/state/settings.state.dart';
import 'package:tenso_app/view_models/execution/adjust_hangs_dialog.vm.dart';
import 'package:tenso_app/view_models/execution/execution_sequence_builder.dart';
import 'package:tenso_app/view_models/execution/execution_state.vm.dart';
import 'package:tenso_app/widgets/dialog.dart';
import 'package:tenso_app/widgets/execution/adjust_hangs_dialog.dart';
import 'package:tenso_app/widgets/execution/comments_dialog.dart';
import 'package:tenso_app/widgets/execution/congratulations_content.dart';
import 'package:wakelock/wakelock.dart';

class ExecutionViewModel {
  BuildContext _context;
  AudioPlayerService _audioPlayerService;
  Workout _workout;
  AnimationController _animationController;
  int _currentSequenceIndex;
  List<SequenceTimer> _sequence;
  SequenceTimer get _currentSequence => _sequence[_currentSequenceIndex];
  NavigationService _navigationService;
  List<PastHang> get pastHangs => _getPastHangs();
  double get _effectiveDurationMs => _getEffectiveDurationMs();
  int get _displaySeconds => _getDisplaySeconds();
  int _preparationTimer;
  String _comments = '';

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
    _sequence =
        sequenceBuilder(workout: workout, settings: SettingsState().settings);
    _preparationTimer = SettingsState().settings.preparationTimer;
    _navigationService = NavigationService();
    _currentSequenceIndex = 0;
    _state$ = BehaviorSubject.seeded(_buildStateAndPlayBeepSound());
    _animationController.addListener(_setState);
    _animationController.addStatusListener(_animationStatusListener);
    _start();
  }

  List<PastHang> _getPastHangs() {
    final List<SequenceTimer> _pastHangSequences = _sequence
        .where((SequenceTimer t) =>
            t.type == SequenceTimerType.hangTimer &&
            t.index <= _currentSequenceIndex)
        .toList();

    return _pastHangSequences.map((SequenceTimer t) {
      final double _effectiveDurationS =
          double.parse((t.effectiveDurationMs / 1000).toStringAsFixed(1));
      return PastHang(
        sequenceTimerIndex: t.index,
        currentGroup: t.currentGroup,
        currentRep: t.currentRep,
        totalGroups: t.totalGroups,
        totalReps: t.totalReps,
        skipped: t.skipped,
        totalSets: t.totalSets,
        currentSet: t.currentSet,
        effectiveDurationS: _effectiveDurationS,
        effectiveDurationSInput: _effectiveDurationS.toString(),
        effectiveAddedWeight: t.originalAddedWeight,
        effectiveAddedWeightInput: t.originalAddedWeight.toString(),
        isSelected:
            t.index == _pastHangSequences[_pastHangSequences.length - 1].index,
        boardAspectRatio: t.board.aspectRatio,
        rightGrip: t.rightGrip,
        leftGrip: t.leftGrip,
        leftGripBoardHold: t.leftGripBoardHold,
        rightGripBoardHold: t.rightGripBoardHold,
        handToBoardHeightRatio: t.board.handToBoardHeightRatio,
        customBoardHoldImages: t.board.customBoardHoldImages?.toList(),
        imageAsset: t.board.imageAsset,
        weightUnit: t.weightSystem.unit,
        imageAssetWidth: t.board.imageAssetWidth,
      );
    }).toList();
  }

  ExecutionState _buildStateAndPlayBeepSound() {
    // Can't use state.type here because it's possible state has not been initialized yet.
    final bool _isVariableRestTimer =
        _currentSequence.type == SequenceTimerType.variableRestTimer;
    final bool _isCountdown = !_isVariableRestTimer;
    if (_state$ != null &&
        _isCountdown == true &&
        state.beepSound.muted == false &&
        _displaySeconds != state.displaySeconds &&
        _displaySeconds != 0 &&
        _displaySeconds <= state.beepsBeforeEnd) {
      _audioPlayerService.play(state.beepSound.filename);
    }

    return ExecutionState(
      displayEndScreen: false,
      totalReps: _currentSequence.totalReps,
      totalGroups: _currentSequence.totalGroups,
      currentRep: _currentSequence.currentRep,
      currentGroup: _currentSequence.currentGroup,
      type: _currentSequence.type,
      isVariableRestTimer: _isVariableRestTimer,
      duration: _currentSequence.originalDurationS,
      displaySeconds: _displaySeconds,
      animatedBackgroundHeightFactor:
          _isVariableRestTimer == false ? _animationController.value : 0,
      endSound: _currentSequence.endSound,
      beepSound: _currentSequence.beepSound,
      beepsBeforeEnd: _currentSequence.beepsBeforeEnd,
      primaryColor: _currentSequence.primaryColor,
      title: _currentSequence.title,
      holdLabel: _currentSequence.holdLabel,
      board: _currentSequence.board,
      leftGrip: _currentSequence.leftGrip,
      rightGrip: _currentSequence.rightGrip,
      leftGripBoardHold: _currentSequence.leftGripBoardHold,
      rightGripBoardHold: _currentSequence.rightGripBoardHold,
      totalSets: _currentSequence.totalSets,
      currentSet: _currentSequence.currentSet,
      weightSystem: _currentSequence.weightSystem,
      addedWeight: _currentSequence.originalAddedWeight,
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
      _stop(manual: false);
    } else {
      _currentSequenceIndex++;
      if (_currentSequence.skipped == true) {
        _nextSequence();
      }
      _setState();
      _start();
    }
  }

  void _start() {
    if (state.isVariableRestTimer == true) {
      final int _kMaxVariableTimerDuration = 10;
      _animationController.duration =
          Duration(minutes: _kMaxVariableTimerDuration);
      _animationController.reset();
      _animationController.forward();
    } else {
      final int _seconds = state.duration;
      _animationController.duration = Duration(seconds: _seconds);
      _animationController.reset();
      _animationController.forward();
    }
  }

  void _displayEndScreen() {
    _state$.add(state.copyWith(displayEndScreen: true));
  }

  void _stop({@required bool manual}) async {
    _animationController.stop(canceled: true);
    _displayEndScreen();

    // Only if the sequence is stopped manually, we need to adjust
    // this sequence and the sequences after that.
    // Otherwise, _stop() occurs on the last sequence, and adjusting
    // isn't necessary.
    if (manual == true) {
      _sequence = _sequence.map((SequenceTimer t) {
        if (_currentSequenceIndex == t.index) {
          return t.copyWith(
              stopped: true, effectiveDurationMs: _effectiveDurationMs);
        }
        if (t.index > _currentSequenceIndex) {
          return t.copyWith(stopped: true, effectiveDurationMs: 0);
        }
        return t;
      }).toList();
    }

    History _history = _generateHistory();
    if (_history.timerUnderTensionMs == 0) {
      _navigationService.pushNamed(Routes.workoutOverviewScreen);
    } else {
      showAppDialog(
          fullWidth: true,
          context: _context,
          content: WillPopScope(
            onWillPop: () async => false,
            child: CongratulationsContent(
              handleAdjustHangsTap: _handleAdjustHangsTap,
              handleRateWorkoutTap: _handleRateWorkoutTap,
            ),
          ),
          smallWidth: false);
    }
    dispose();
  }

  void _handleRateWorkoutTap() {
    History _history = _generateHistory();
    _navigationService.pushNamed(Routes.rateWorkoutScreen,
        arguments: RateWorkoutArguments(
            workout: _workout, history: _history, comments: _comments));
  }

  void _handleAdjustHangsTap() {
    showAppDialog(
        fullWidth: true,
        context: _context,
        content: AdjustHangsDialog(
          pastHangs: pastHangs,
          handleAdjustedHangs: handleAdjustedHangs,
        ),
        smallWidth: false);
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  History _generateHistory() {
    final List<SequenceTimerLog> _logs = _sequence
        .map((SequenceTimer t) => SequenceTimerLog((b) => b
          ..index = t.index
          ..weightSystem = t.weightSystem
          ..originalDurationS = t.originalDurationS
          ..effectiveDurationMs = t.effectiveDurationMs
          ..originalAddedWeight = t.originalAddedWeight
          ..effectiveAddedWeight = t.effectiveAddedWeight
          ..type = t.type
          ..skipped = t.skipped
          ..stopped = t.stopped
          ..groupIndex = t.currentGroup - 1))
        .toList();

    return History((b) => b..sequenceTimerLogs.addAll(_logs));
  }

  void handleReadyTap() {
    _animationController.stop(canceled: false);
    _sequence[_currentSequenceIndex] =
        _currentSequence.copyWith(effectiveDurationMs: _effectiveDurationMs);
    _nextSequence();
  }

  void handlePauseTap() {
    if (state.type == SequenceTimerType.hangTimer ||
        state.type == SequenceTimerType.preparationTimer) {
      _animationController.stop(canceled: false);
    }

    if (state.type == SequenceTimerType.fixedRestTimer) {
      if (_displaySeconds <= _preparationTimer) {
        _animationController.stop(canceled: false);
      } else {
        _animationController.addListener(_pausedDurationListener);
      }
    }
  }

  void _pausedDurationListener() {
    if (_displaySeconds <= _preparationTimer) {
      _animationController.stop(canceled: false);
    }
  }

  void handleSkipTap() {
    if (state.type == SequenceTimerType.hangTimer) {
      _sequence[_currentSequenceIndex] = _currentSequence.copyWith(
          effectiveDurationMs: _effectiveDurationMs, skipped: true);
      _navigationService.pop();
      _nextSequence();
      return;
    }

    final _skippedHang = _sequence.firstWhere(
        (SequenceTimer t) =>
            t.skipped != true &&
            t.index > _currentSequenceIndex &&
            t.type == SequenceTimerType.hangTimer,
        orElse: () => null);

    final _hangAfterSkippedHang = _sequence.firstWhere(
        (SequenceTimer t) =>
            t.skipped != true &&
            t.index > _skippedHang.index &&
            t.type == SequenceTimerType.hangTimer,
        orElse: () => null);

    if (_hangAfterSkippedHang == null) {
      _stop(manual: true);
      return;
    }

    _sequence[_currentSequenceIndex] = _currentSequence.copyWith(
        originalAddedWeight: _hangAfterSkippedHang.originalAddedWeight,
        effectiveAddedWeight: _hangAfterSkippedHang.effectiveAddedWeight,
        leftGripBoardHold: Nullable(_hangAfterSkippedHang.leftGripBoardHold),
        rightGripBoardHold: Nullable(_hangAfterSkippedHang.rightGripBoardHold),
        leftGrip: Nullable(_hangAfterSkippedHang.leftGrip),
        rightGrip: Nullable(_hangAfterSkippedHang.rightGrip),
        holdLabel: _hangAfterSkippedHang.holdLabel,
        board: _hangAfterSkippedHang.board,
        totalGroups: _hangAfterSkippedHang.totalGroups,
        currentGroup: _hangAfterSkippedHang.currentGroup,
        totalSets: _hangAfterSkippedHang.totalSets,
        currentSet: _hangAfterSkippedHang.currentSet,
        totalReps: _hangAfterSkippedHang.totalReps,
        currentRep: _hangAfterSkippedHang.currentRep);

    _sequence = _sequence.map((SequenceTimer t) {
      // If we're currently on the variable rest timer,
      // we still need the preparation sequence before
      // the next hang.
      if (state.isVariableRestTimer == true &&
          t.index > _currentSequenceIndex &&
          t.index < _hangAfterSkippedHang.index - 1) {
        return t.copyWith(effectiveDurationMs: 0, skipped: true);
      }
      if (state.isVariableRestTimer == false &&
          t.index > _currentSequenceIndex &&
          t.index < _hangAfterSkippedHang.index) {
        return t.copyWith(effectiveDurationMs: 0, skipped: true);
      }
      return t;
    }).toList();

    _setState();
    _animationController.forward();
    _navigationService.pop();
  }

  void handleStopTap() {
    _stop(manual: true);
  }

  void handleResumeTap() {
    _animationController.removeListener(_pausedDurationListener);
    _animationController.forward();
    _navigationService.pop();
  }

  void handleAddCommentsTap() {
    showAppDialog(
        fullWidth: true,
        context: _context,
        content: CommentsDialog(
          initialComments: _comments,
          setComments: _setComments,
        ),
        smallWidth: false);
  }

  void _setComments(String comments) {
    _comments = comments;
  }

  int _getDisplaySeconds() {
    if (_state$ == null) {
      return _currentSequence.originalDurationS;
    }

    if (state.isVariableRestTimer == true) {
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

  double _getEffectiveDurationMs() {
    return (_animationController.duration.inMilliseconds *
        _animationController.value);
  }

  void handleAdjustedHangs(List<AdjustedHang> adjustedHangs) {
    _sequence = _sequence.map((SequenceTimer t) {
      final _relevantAdjustedHang = adjustedHangs.firstWhere(
          (AdjustedHang adjustedHang) =>
              t.index == adjustedHang.sequenceTimerIndex,
          orElse: () => null);

      if (t.type == SequenceTimerType.hangTimer &&
          _relevantAdjustedHang != null) {
        return t.copyWith(
            effectiveDurationMs:
                _relevantAdjustedHang.effectiveDurationS * 1000,
            effectiveAddedWeight: _relevantAdjustedHang.effectiveAddedWeight);
      }

      return t;
    }).toList();
  }

  void dispose() {
    Wakelock.disable();
    _animationController.removeListener(_setState);
    _animationController.removeStatusListener(_animationStatusListener);
    _animationController.dispose();
    _state$.close();
  }
}
