import 'package:app/data/boards/beastmaker_1000.dart';
import 'package:app/data/grips.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';

final Workout basicWorkout = Workout(
  difficulty: '5A',
  sets: 3,
  holdCount: 3,
  restBetweenSets: 60 * 3,
  board: beastmaker1000,
  holds: [
    Hold(
        leftGrip: Grips.openHandL,
        rightGrip: Grips.openHandR,
        handHold: HandHolds.twoHanded,
        leftGripBoardHold: beastmaker1000.defaultLeftGripHold,
        rightGripBoardHold: beastmaker1000.defaultRightGripHold,
        repetitions: 8,
        restBeforeNextHold: 60 * 2,
        restBetweenRepetitions: 60,
        hangTime: 7,
        addedWeight: 20)
  ],
  name: 'Basic workout',
);
