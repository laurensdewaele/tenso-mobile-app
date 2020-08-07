import 'package:tenso_app/data/default_boards/beastmaker_1000.data.dart';
import 'package:tenso_app/data/grips.data.dart';
import 'package:tenso_app/models/models.dart';

const int basicCountdownRestDuration = 3 * 60;

final Board _defaultBoard = beastmaker1000;

final Group basicOpenHand = Group((b) => b
  ..board = _defaultBoard.toBuilder()
  ..handHold = HandHold.twoHanded
  ..leftGrip = Grips.openHandL.toBuilder()
  ..rightGrip = Grips.openHandR.toBuilder()
  ..leftGripBoardHold = _defaultBoard.defaultLeftGripHold.toBuilder()
  ..rightGripBoardHold = _defaultBoard.defaultRightGripHold.toBuilder()
  ..repeaters = false
  ..reps = 3
  ..hangTimeS = 20
  ..restBetweenRepsFixed = true
  ..restBetweenRepsS = basicCountdownRestDuration
  ..sets = null
  ..restBetweenSetsFixed = null
  ..restBetweenSetsS = null
  ..addedWeight = 0);

final Group basicHalfCrimp = Group((b) => b
  ..board = _defaultBoard.toBuilder()
  ..handHold = HandHold.twoHanded
  ..leftGrip = Grips.halfCrimpL.toBuilder()
  ..rightGrip = Grips.halfCrimpR.toBuilder()
  ..leftGripBoardHold = _defaultBoard.boardHolds
      .firstWhere((BoardHold boardHold) => boardHold.position == 18)
      .toBuilder()
  ..rightGripBoardHold = _defaultBoard.boardHolds
      .firstWhere((BoardHold boardHold) => boardHold.position == 23)
      .toBuilder()
  ..repeaters = false
  ..reps = 3
  ..hangTimeS = 10
  ..restBetweenRepsFixed = true
  ..restBetweenRepsS = basicCountdownRestDuration
  ..sets = null
  ..restBetweenSetsFixed = null
  ..restBetweenSetsS = null
  ..addedWeight = 0);

final Group basicThreeFingerDrag = Group((b) => b
  ..board = _defaultBoard.toBuilder()
  ..handHold = HandHold.twoHanded
  ..leftGrip = Grips.frontThreeL.toBuilder()
  ..rightGrip = Grips.frontThreeR.toBuilder()
  ..leftGripBoardHold = _defaultBoard.defaultLeftGripHold.toBuilder()
  ..rightGripBoardHold = _defaultBoard.defaultRightGripHold.toBuilder()
  ..repeaters = false
  ..reps = 3
  ..hangTimeS = 10
  ..restBetweenRepsFixed = true
  ..restBetweenRepsS = basicCountdownRestDuration
  ..sets = null
  ..restBetweenSetsFixed = null
  ..restBetweenSetsS = null
  ..addedWeight = 0);

final Workout basicDensity = Workout((b) => b
  ..restBetweenGroupsFixed = true
  ..restBetweenGroupsS = basicCountdownRestDuration
  ..groups.addAll([basicOpenHand, basicHalfCrimp, basicThreeFingerDrag])
  ..id = '1'
  ..label = Label.yellow
  ..weightSystem = WeightSystem.metric
  ..name = 'Density');

final Workout basicMaxHangs = Workout((b) => b
  ..restBetweenGroupsFixed = true
  ..restBetweenGroupsS = basicCountdownRestDuration
  ..groups.addAll([
    basicOpenHand.rebuild((b) => b..hangTimeS = 10),
    basicHalfCrimp,
    basicThreeFingerDrag
  ])
  ..id = '2'
  ..label = Label.red
  ..weightSystem = WeightSystem.metric
  ..name = 'Max hangs');

final Workouts basicWorkouts =
    Workouts((b) => b..workouts.addAll([basicDensity, basicMaxHangs]));
