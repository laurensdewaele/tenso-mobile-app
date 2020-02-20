import 'package:flutter/cupertino.dart';

import 'package:app/models/settings.dart';
import 'package:app/models/workout.dart';
import 'package:app/view_models/countdown_vm.dart';
import 'package:app/widgets/countdown.dart';

class CountdownScreenArguments {
  CountdownScreenArguments({this.workout, this.settings});

  final Workout workout;
  final Settings settings;
}

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  int _currentSequenceIndex = 0;
  bool _isRunning = false;
  CountdownViewModel _countdownViewModel;
  List<SequenceItem> get _sequence => _countdownViewModel.sequence;
  int _remainingSeconds;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_countdownViewModel == null) {
      final CountdownScreenArguments routeArguments =
          ModalRoute.of(context).settings.arguments;
      _countdownViewModel = CountdownViewModel(
          workout: routeArguments.workout, settings: routeArguments.settings);
      _startSequenceForIndex();
      start();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _startSequenceForIndex() {
    final int duration =
        _countdownViewModel.sequence[_currentSequenceIndex].duration;
    _remainingSeconds = duration;

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: duration))
          ..addListener(() {
            setState(() {});
          });
    // The stream closes itself once the timer reaches 0.
    // TODO: Try if you can only use the animationController for the countdown.

    _sequence[_currentSequenceIndex]
        .countdownTimer
        .stream
        .listen((remainingSeconds) {
      setState(() {
        _remainingSeconds = remainingSeconds;
      });
      if (_remainingSeconds == 0) {
        setState(() {
          _isRunning = false;
          _currentSequenceIndex++;
        });
        _animationController.dispose();
        if (_sequence[_currentSequenceIndex] != null) {
          _startSequenceForIndex();
          start();
        }
      }
    });
  }

  void stop() {
    setState(() {
      _isRunning = false;
    });
    _animationController.dispose();
    _sequence[_currentSequenceIndex].countdownTimer.cancel();
  }

  void pause() {
    setState(() {
      _isRunning = false;
    });
    _animationController.stop();
    _sequence[_currentSequenceIndex].countdownTimer.pause();
  }

  void start() {
    if (_isRunning != true) {
      setState(() {
        _isRunning = true;
      });
      _animationController.forward();
      _sequence[_currentSequenceIndex].countdownTimer.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      animatedBackgroundHeightFactor: _animationController.value,
      animatedBackgroundColor: _sequence[_currentSequenceIndex].color,
      title: _sequence[_currentSequenceIndex].title,
      remainingSeconds: _remainingSeconds,
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
    );
  }
}
