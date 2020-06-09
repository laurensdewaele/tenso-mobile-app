import 'package:app/data/boards/beastmaker_1000.data.dart';
import 'package:app/data/grips.data.dart';
import 'package:app/models/models.dart';

const int basicCountdownRestDuration = 3 * 60;

final Board _defaultBoard = beastmaker1000;

final Group basicGroup = Group((b) => b
  ..board = _defaultBoard.toBuilder()
  ..handHold = HandHold.twoHanded
  ..leftGrip = Grips.openHandL.toBuilder()
  ..rightGrip = Grips.openHandR.toBuilder()
  ..leftGripBoardHold = _defaultBoard.defaultLeftGripHold.toBuilder()
  ..rightGripBoardHold = _defaultBoard.defaultRightGripHold.toBuilder()
  ..repeaters = false
  ..repetitions = 1
  ..hangTimeS = 7
  ..restBetweenRepsFixed = true
  ..restBetweenRepsS = 180
  ..sets = 1
  ..restBetweenSetsFixed = true
  ..restBetweenSetsS = 180
  ..addedWeight = 0);

final Workout basicWorkout = Workout((b) => b
  ..restBetweenGroupsFixed = true
  ..restBetweenGroupsS = 180
  ..groups.addAll([])
  ..id = '1'
  ..label = Label.blue
  ..sets = 1
  ..holdCount = 3
  ..countdownRestTimer = true
  ..board = _defaultBoard.toBuilder()
  ..weightSystem = WeightSystem.metric
  ..holds.addAll([
    Hold((b) => b
      ..leftGrip = Grips.openHandL.toBuilder()
      ..rightGrip = Grips.openHandR.toBuilder()
      ..handHold = HandHold.twoHanded
      ..leftGripBoardHold = _defaultBoard.defaultLeftGripHold.toBuilder()
      ..rightGripBoardHold = _defaultBoard.defaultRightGripHold.toBuilder()
      ..repetitions = 3
      ..countdownRestDuration = basicCountdownRestDuration
      ..hangTime = 10
      ..addedWeight = 0),
    Hold((b) => b
      ..leftGrip = Grips.halfCrimpL.toBuilder()
      ..rightGrip = Grips.halfCrimpR.toBuilder()
      ..handHold = HandHold.twoHanded
      ..leftGripBoardHold = boardHolds
          .singleWhere((boardHold) => boardHold.position == 18)
          .toBuilder()
      ..rightGripBoardHold = boardHolds
          .singleWhere((boardHold) => boardHold.position == 23)
          .toBuilder()
      ..repetitions = 3
      ..countdownRestDuration = basicCountdownRestDuration
      ..hangTime = 7
      ..addedWeight = 0),
    Hold((b) => b
      ..leftGrip = Grips.frontThreeL.toBuilder()
      ..rightGrip = Grips.frontThreeR.toBuilder()
      ..handHold = HandHold.twoHanded
      ..leftGripBoardHold = _defaultBoard.defaultLeftGripHold.toBuilder()
      ..rightGripBoardHold = _defaultBoard.defaultRightGripHold.toBuilder()
      ..repetitions = 3
      ..countdownRestDuration = basicCountdownRestDuration
      ..hangTime = 7
      ..addedWeight = 0)
  ])
  ..name = '');

final Workouts basicWorkouts =
    Workouts((b) => b..workouts.addAll([basicWorkout]));
