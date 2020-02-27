import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/scheduler.dart';

import 'package:app/models/settings.dart';
import 'package:app/models/workout.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/countdown_screen_vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/countdown/countdown.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/icon.dart';

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
      _play();
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
      _animationController.removeListener(_animationControllerListener);
    }

    final int duration =
        _countdownScreenViewModel.sequence[_currentSequenceIndex].duration;

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: duration))
          ..addListener(_animationControllerListener);
  }

  void _animationControllerListener() {
    // End of a single countdown
    if (_animationController.value == 1) {
      // On the end of the whole sequence, navigate back
      if (_currentSequenceIndex == _sequence.length - 1) {
        _stop();
        Navigator.of(context).pop();
      } else {
        setState(() {
          _isRunning = false;
        });
        // We need this addPostFrameCallback in order
        // to display the actual 0 value.
        // Also, increasing the index needs to be a frame later.
        // If not, the sound would have already changed to the next index value,
        // when remainingSeconds == 0.
        SchedulerBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _currentSequenceIndex++;
          });
          _startSequenceForIndex();
          _play();
        });
      }
    } else {
      setState(() {});
    }
  }

  void _stop() {
    _animationController.removeListener(_animationControllerListener);
    setState(() {
      _isRunning = false;
    });
  }

  void _pause() {
    setState(() {
      _isRunning = false;
    });
    _animationController.stop();
  }

  void _play() {
    if (_isRunning != true) {
      setState(() {
        _isRunning = true;
      });
      _animationController.forward();
    }
  }

  void _handlePlayTap() {
    _play();
    Navigator.of(context).pop();
  }

  void _handleStopTap() {
    _stop();
    Navigator.of(context).pop();
    // TODO: Save completed.
  }

  void _handleTap() {
    _pause();
    showAppDialog(
        context: context,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'paused',
              style: styles.Typography.title,
            ),
            Divider(
              height: styles.Measurements.xxl,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Button(
                      text: 'play',
                      handleTap: _handlePlayTap,
                      displayBackground: false,
                      leadingIcon: Icon(
                          iconData: IconData(0xf488,
                              fontFamily: 'CupertinoIcons',
                              fontPackage: 'cupertino_icons'),
                          size: styles.Measurements.l,
                          color: styles.Colors.black)),
                ),
                Expanded(
                  flex: 1,
                  child: Button(
                    text: 'stop',
                    handleTap: _handleStopTap,
                    leadingIcon: Icon(
                        iconData: IconData(0xf371,
                            fontFamily: 'CupertinoIcons',
                            fontPackage: 'cupertino_icons'),
                        size: styles.Measurements.l,
                        color: styles.Colors.white),
                  ),
                )
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Countdown(
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
        endSound: _sequence[_currentSequenceIndex].endSound,
        beepSound: _sequence[_currentSequenceIndex].beepSound,
        beepsBeforeEnd: _sequence[_currentSequenceIndex].beepsBeforeEnd,
      ),
    );
  }
}
