import 'package:app/data/boards/beastmaker_1000.dart';
import 'package:app/data/grips.dart';
import 'package:app/models/models.dart';

final Workout basicWorkout = Workout((b) => b
  ..id = '1'
  ..label = Label.blue
  ..sets = 1
  ..holdCount = 3
  ..stopwatchRestTimers = false
  ..restBetweenHolds = 60 * 3
  ..restBetweenSets = 60 * 3
  ..board = beastmaker1000.toBuilder()
  ..weightUnit = WeightUnit.metric
  ..holds.addAll([
    Hold((b) => b
      ..leftGrip = Grips.openHandL.toBuilder()
      ..rightGrip = Grips.openHandR.toBuilder()
      ..handHold = HandHold.twoHanded
      ..leftGripBoardHold = beastmaker1000.defaultLeftGripHold.toBuilder()
      ..rightGripBoardHold = beastmaker1000.defaultRightGripHold.toBuilder()
      ..repetitions = 3
      ..restBetweenRepetitions = 60 * 3
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
      ..restBetweenRepetitions = 60 * 3
      ..hangTime = 7
      ..addedWeight = 0),
    Hold((b) => b
      ..leftGrip = Grips.frontThreeL.toBuilder()
      ..rightGrip = Grips.frontThreeR.toBuilder()
      ..handHold = HandHold.twoHanded
      ..leftGripBoardHold = beastmaker1000.defaultLeftGripHold.toBuilder()
      ..rightGripBoardHold = beastmaker1000.defaultRightGripHold.toBuilder()
      ..repetitions = 3
      ..restBetweenRepetitions = 60 * 3
      ..hangTime = 7
      ..addedWeight = 0)
  ])
  ..name = 'Example workout');

final Workouts basicWorkouts =
    Workouts((b) => b..workouts.addAll([basicWorkout]));
