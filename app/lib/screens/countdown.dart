import 'package:flutter/cupertino.dart';

import 'package:app/models/settings.dart';
import 'package:app/models/workout.dart';
import 'package:app/view_models/countdown_screen_vm.dart';
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
  CountdownScreenViewModel _countdownScreenViewModel;
  List<CountdownViewModel> get _sequence => _countdownScreenViewModel.sequence;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_countdownScreenViewModel == null) {
      final CountdownScreenArguments routeArguments =
          ModalRoute.of(context).settings.arguments;
      _countdownScreenViewModel = CountdownScreenViewModel(
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
    _animationController.dispose();
    super.dispose();
  }

  void _startSequenceForIndex() {
    final int duration =
        _countdownScreenViewModel.sequence[_currentSequenceIndex].duration;

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: duration))
          ..addListener(() {
            setState(() {});
            if (_animationController.value == 1) {
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
  }

  void pause() {
    setState(() {
      _isRunning = false;
    });
    _animationController.stop();
  }

  void start() {
    if (_isRunning != true) {
      setState(() {
        _isRunning = true;
      });
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      animatedBackgroundHeightFactor: _animationController.value,
      animatedBackgroundColor: _sequence[_currentSequenceIndex].color,
      title: _sequence[_currentSequenceIndex].title,
      // TODO: Fix rounding
      remainingSeconds: (_animationController.duration.inSeconds -
              _animationController.duration.inSeconds *
                  _animationController.value)
          .ceil(),
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
