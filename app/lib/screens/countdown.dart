import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

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
    if (_animationController != null) {
      _animationController.removeListener(animationControllerListener);
    }

    final int duration =
        _countdownScreenViewModel.sequence[_currentSequenceIndex].duration;

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: duration))
          ..addListener(animationControllerListener);
  }

  void animationControllerListener() {
    // End of a single countdown
    if (_animationController.value == 1) {
      // On the end of the whole sequence, navigate back
      if (_currentSequenceIndex == _sequence.length - 1) {
        stop();
        Navigator.of(context).pop();
      } else {
        setState(() {
          _isRunning = false;
          _currentSequenceIndex++;
        });
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _startSequenceForIndex();
          start();
        });
      }
    } else {
      setState(() {});
    }
  }

  void stop() {
    _animationController.removeListener(animationControllerListener);
    setState(() {
      _isRunning = false;
    });
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
      unit: _sequence[_currentSequenceIndex].unit,
      addedWeight: _sequence[_currentSequenceIndex].addedWeight,
      animatedBackgroundHeightFactor: _animationController.value,
      primaryColor: _sequence[_currentSequenceIndex].color,
      title: _sequence[_currentSequenceIndex].title,
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
