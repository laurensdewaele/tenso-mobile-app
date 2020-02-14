import 'package:app/data/boards/beastmaker_1000.dart';
import 'package:app/data/grips.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';

final Workout basicWorkout = Workout((b) => b
..id = '1'
  ..difficulty = '5A'
  ..sets = 3
  ..holdCount = 3
  ..restBetweenHolds = 60 * 2
  ..restBetweenSets = 60 * 3
  ..board = beastmaker1000.toBuilder()
  ..holds.addAll([
    Hold((b) => b
      ..leftGrip = Grips.openHandL.toBuilder()
      ..rightGrip = Grips.openHandR.toBuilder()
      ..handHold = HandHold.twoHanded
      ..leftGripBoardHold = beastmaker1000.defaultLeftGripHold.toBuilder()
      ..rightGripBoardHold = beastmaker1000.defaultRightGripHold.toBuilder()
      ..repetitions = 8
      ..restBetweenRepetitions = 60
      ..hangTime = 7
      ..addedWeight = 20),
    Hold((b) => b
      ..leftGrip = Grips.halfCrimpL.toBuilder()
      ..rightGrip = Grips.halfCrimpR.toBuilder()
      ..handHold = HandHold.twoHanded
      ..leftGripBoardHold = beastmaker1000.defaultLeftGripHold.toBuilder()
      ..rightGripBoardHold = beastmaker1000.defaultRightGripHold.toBuilder()
      ..repetitions = 8
      ..restBetweenRepetitions = 60
      ..hangTime = 7
      ..addedWeight = 20),
    Hold((b) => b
      ..leftGrip = Grips.openHandL.toBuilder()
      ..rightGrip = Grips.openHandR.toBuilder()
      ..handHold = HandHold.twoHanded
      ..leftGripBoardHold = beastmaker1000.defaultLeftGripHold.toBuilder()
      ..rightGripBoardHold = beastmaker1000.defaultRightGripHold.toBuilder()
      ..repetitions = 8
      ..restBetweenRepetitions = 60
      ..hangTime = 7
      ..addedWeight = 20)
  ])
  ..name = 'Basic workout');