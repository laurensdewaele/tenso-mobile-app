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
  ..reps = 1
  ..hangTimeS = 7
  ..restBetweenRepsFixed = false
  ..restBetweenRepsS = null
  ..sets = null
  ..restBetweenSetsFixed = null
  ..restBetweenSetsS = null
  ..addedWeight = 0);

final Workout basicWorkout = Workout((b) => b
  ..restBetweenGroupsFixed = false
  ..restBetweenGroupsS = 180
  ..groups.addAll([basicGroup])
  ..id = '1'
  ..label = Label.blue
  ..weightSystem = WeightSystem.metric
  ..name = 'basic');

final Workouts basicWorkouts =
    Workouts((b) => b..workouts.addAll([basicWorkout]));
