import 'package:tenso_app/data/default_boards/beastmaker_1000.data.dart';
import 'package:tenso_app/data/grips.data.dart';
import 'package:tenso_app/models/models.dart';

final Board _defaultBoard = beastmaker1000;

final Group basicHalfCrimpMaxHangs = Group((b) => b
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
  ..reps = 5
  ..hangTimeS = 10
  ..restBetweenRepsFixed = true
  ..restBetweenRepsS = 4 * 60
  ..sets = null
  ..restBetweenSetsFixed = null
  ..restBetweenSetsS = null
  ..addedWeight = 0);

final Group basicHalfCrimpDensity = basicHalfCrimpMaxHangs.rebuild((b) => b
  ..hangTimeS = 20
  ..reps = 5);

final Group basicHalfCrimpRepeaters = basicHalfCrimpMaxHangs.rebuild((b) => b
  ..hangTimeS = 7
  ..restBetweenRepsFixed = true
  ..restBetweenRepsS = 3
  ..reps = 5
  ..sets = 6
  ..repeaters = true
  ..restBetweenSetsFixed = true
  ..restBetweenSetsS = 3 * 60);

final Workout basicDensity = Workout((b) => b
  ..restBetweenGroupsFixed = true
  ..restBetweenGroupsS = 4 * 60
  ..groups.addAll([basicHalfCrimpDensity])
  ..id = '1'
  ..label = Label.yellow
  ..weightSystem = WeightSystem.metric
  ..name = 'Density');

final Workout basicMaxHangs = Workout((b) => b
  ..restBetweenGroupsFixed = true
  ..restBetweenGroupsS = 4 * 60
  ..groups.addAll([basicHalfCrimpMaxHangs])
  ..id = '2'
  ..label = Label.red
  ..weightSystem = WeightSystem.metric
  ..name = 'Max hangs');

final Workout basicRepeaters = Workout((b) => b
  ..restBetweenGroupsFixed = true
  ..restBetweenGroupsS = 3 * 60
  ..groups.addAll([basicHalfCrimpRepeaters])
  ..id = '3'
  ..label = Label.blue
  ..weightSystem = WeightSystem.metric
  ..name = 'Repeaters');

final Workouts basicWorkouts = Workouts(
    (b) => b..workouts.addAll([basicDensity, basicMaxHangs, basicRepeaters]));
