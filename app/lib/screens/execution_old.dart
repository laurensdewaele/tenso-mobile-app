//import 'package:flutter/cupertino.dart' hide Icon;
//import 'package:flutter/scheduler.dart';
//
//import 'package:app/models/models.dart';
//import 'package:app/routes/routes.dart';
//import 'package:app/screens/congratulations.dart';
//import 'package:app/styles/styles.dart' as styles;
//import 'package:app/view_models/countdown_screen_vm.dart';
//import 'package:app/widgets/button.dart';
//import 'package:app/widgets/divider.dart';
//import 'package:app/widgets/dialog.dart';
//import 'package:app/widgets/icons.dart' as icons;
//
//class ExecutionScreenArguments {
//  ExecutionScreenArguments({this.workout});
//
//  final Workout workout;
//}
//
//class ExecutionScreen3 extends StatefulWidget {
//  @override
//  _ExecutionScreenState3 createState() => _ExecutionScreenState3();
//}
//
//class _ExecutionScreenState3 extends State<ExecutionScreen3>
//    with TickerProviderStateMixin {
//  AnimationController _animationController;
//  int _currentSequenceIndex = 0;
//  bool _isRunning = false;
//  CountdownScreenViewModel _countdownScreenViewModel;
//  List<CountdownViewModel> get _sequence => _countdownScreenViewModel.sequence;
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    if (_countdownScreenViewModel == null) {
//      final ExecutionScreenArguments routeArguments =
//          ModalRoute.of(context).settings.arguments;
//      _countdownScreenViewModel =
//          CountdownScreenViewModel(workout: routeArguments.workout);
//      _startSequenceForIndex();
//      _play();
//    }
//  }
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    _animationController.dispose();
//    super.dispose();
//  }
//
//  void _startSequenceForIndex() {
//    if (_animationController != null) {
//      _animationController.removeListener(_animationControllerListener);
//    }
//
//    final int duration =
//        _countdownScreenViewModel.sequence[_currentSequenceIndex].duration;
//
//    _animationController =
//        AnimationController(vsync: this, duration: Duration(seconds: duration))
//          ..addListener(_animationControllerListener);
//  }
//
//  void _animationControllerListener() {
//    // End of a single sequence
//    if (_animationController.value == 1) {
//      // On the end of the whole sequence, navigate back
//      if (_currentSequenceIndex == _sequence.length - 1) {
//        _stop();
//        Navigator.of(context).pushNamed(Routes.congratulationsScreen,
//            arguments: RateWorkoutArguments(
//              workout: _countdownScreenViewModel.workout,
//            ));
//      } else {
//        setState(() {
//          _isRunning = false;
//        });
//        // We need this addPostFrameCallback in order
//        // to display the actual 0 value.
//        // Also, increasing the index needs to be a frame later.
//        // If not, the sound would have already changed to the next index value,
//        // when remainingSeconds == 0.
//        SchedulerBinding.instance.addPostFrameCallback((_) {
//          setState(() {
//            _currentSequenceIndex++;
//          });
//          _startSequenceForIndex();
//          _play();
//        });
//      }
//    } else {
//      setState(() {});
//    }
//  }
//
//  void _stop() {
//    _animationController.removeListener(_animationControllerListener);
//    setState(() {
//      _isRunning = false;
//    });
//  }
//
//  void _pause() {
//    setState(() {
//      _isRunning = false;
//    });
//    _animationController.stop();
//  }
//
//  void _play() {
//    if (_isRunning != true) {
//      setState(() {
//        _isRunning = true;
//      });
//      _animationController.forward();
//    }
//  }
//
//  void _handlePlayTap() {
//    Navigator.of(context).pop();
//    _play();
//  }
//
//  void _handleStopTap() {
//    _stop();
//    Navigator.of(context).pushNamed(Routes.workoutOverviewScreen);
//  }
//
//  void _handleTap() {
//    _pause();
//    showAppDialog(
//        context: context,
//        content: Column(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            Text(
//              'paused',
//              style: styles.Staatliches.xlBlack,
//            ),
//            Divider(
//              height: styles.Measurements.xxl,
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Expanded(
//                  flex: 1,
//                  child: Button(
//                      text: 'play',
//                      handleTap: _handlePlayTap,
//                      displayBackground: false,
//                      leadingIcon: icons.playIconBlackXl),
//                ),
//                Expanded(
//                  flex: 1,
//                  child: Button(
//                    text: 'stop',
//                    handleTap: _handleStopTap,
//                    leadingIcon: icons.stopIconWhiteXl,
//                  ),
//                )
//              ],
//            )
//          ],
//        ));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final int _remainingSeconds = (_animationController.duration.inSeconds -
//            _animationController.duration.inSeconds *
//                _animationController.value)
//        .ceil();
//
//    return GestureDetector(
//      onTap: _handleTap,
//      child: Execution(
//        weightUnit: _sequence[_currentSequenceIndex].weightUnit,
//        addedWeight: _sequence[_currentSequenceIndex].addedWeight,
//        animatedBackgroundHeightFactor: _animationController.value,
//        primaryColor: _sequence[_currentSequenceIndex].color,
//        title: _sequence[_currentSequenceIndex].title,
//        remainingSeconds: _remainingSeconds,
//        holdLabel: _sequence[_currentSequenceIndex].holdLabel,
//        board: _sequence[_currentSequenceIndex].board,
//        leftGrip: _sequence[_currentSequenceIndex].leftGrip,
//        rightGrip: _sequence[_currentSequenceIndex].rightGrip,
//        leftGripBoardHold: _sequence[_currentSequenceIndex].leftGripBoardHold,
//        rightGripBoardHold: _sequence[_currentSequenceIndex].rightGripBoardHold,
//        totalSets: _sequence[_currentSequenceIndex].totalSets,
//        currentSet: _sequence[_currentSequenceIndex].currentSet,
//        totalHangsPerSet: _sequence[_currentSequenceIndex].totalHangsPerSet,
//        currentHang: _sequence[_currentSequenceIndex].currentHang,
//        endSound: _sequence[_currentSequenceIndex].endSound,
//        beepSound: _sequence[_currentSequenceIndex].beepSound,
//        beepsBeforeEnd: _sequence[_currentSequenceIndex].beepsBeforeEnd,
//      ),
//    );
//  }
//}
