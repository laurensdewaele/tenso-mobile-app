// Order is specified according to the designs
import 'package:flutter/cupertino.dart';

class Workout {
  const Workout({
    @required this.difficulty,
    @required this.duration,
    @required this.sets,
    @required this.restBetweenHolds,
    @required this.restBetweenSets,
    @required this.board,
    @required this.holds,
    @required this.name,
  }) : holdAmount = holds.length;

  final int difficulty;
  final int duration;
  final int holdAmount;
  final int sets;
  final int restBetweenHolds;
  final int restBetweenSets;
  final String board;
  final List<Hold> holds;
  final String name;
}

class Hold {
  const Hold(
      {@required this.grip,
      @required this.twoHanded,
      @required this.leftHanded,
      @required this.rightHanded,
      @required this.pockets,
      @required this.repetitions,
      @required this.restBetweenRepetitions,
      @required this.hangTime,
      @required this.addedWeight});

  final String grip;
  final bool twoHanded;
  final bool leftHanded;
  final bool rightHanded;
  final List<String> pockets;
  final int repetitions;
  final int restBetweenRepetitions;
  final int hangTime;
  final int addedWeight;
}

class WorkoutOverview {
  const WorkoutOverview(
      {@required this.name,
      @required this.difficulty,
      @required this.repetitions,
      @required this.duration,
      @required this.sets});

  final String name;
  final int difficulty;
  final int repetitions;
  final int duration;
  final int sets;
}
