import 'package:app/data/boards/beastmaker_1000.data.dart';
import 'package:app/data/grips.data.dart';
import 'package:app/models/models.dart';
import 'package:app/state/boards.state.dart';

const int basicCountdownRestDuration = 3 * 60;

final Board _defaultBoard = BoardsState().defaultBoard;

final Workout basicWorkout = Workout((b) => b
  ..id = '1'
  ..label = Label.blue
  ..sets = 1
  ..holdCount = 3
  ..countdownRestTimer = true
  ..board = _defaultBoard.toBuilder()
  ..weightUnit = WeightUnit.metric
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
  ..name = 'Example workout');

final Workouts basicWorkouts =
    Workouts((b) => b..workouts.addAll([basicWorkout]));
