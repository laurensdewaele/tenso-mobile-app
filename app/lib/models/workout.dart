import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/styles/styles.dart' as styles;

enum WorkoutProperties {
  difficulty,
  sets,
  holdCount,
  restBetweenHolds,
  restBetweenSets,
  board,
  holds,
  name,
  difficultyColor,
  duration,
}

@immutable
class Workout {
  Workout({
    @required this.difficulty,
    @required this.sets,
    @required this.holdCount,
    @required this.restBetweenHolds,
    @required this.restBetweenSets,
    @required this.board,
    @required this.holds,
    @required this.name,
  })  : difficultyColor = _determineDifficultyColor(difficulty),
        duration = _calculateDuration(
            holds: holds,
            restBetweenSets: restBetweenSets,
            sets: sets,
            restBetweenHolds: restBetweenHolds);

  final String difficulty;
  final int sets;
  final int holdCount;
  final int restBetweenHolds;
  final int restBetweenSets;
  final Board board;
  final List<Hold> holds;
  final String name;
  final Color difficultyColor;
  final int duration;

  static Color _determineDifficultyColor(String difficulty) {
    final int difficultyNo = int.parse(difficulty.split('')[0]);

    if (difficultyNo - 5 <= 0) {
      return styles.difficultyColors[0];
    }

    if (difficultyNo - 5 >= 4) {
      return styles.difficultyColors[4];
    }
    return styles.difficultyColors[difficultyNo - 5];
  }

  static int _calculateDuration(
      {List<Hold> holds, sets, restBetweenSets, restBetweenHolds}) {
    int value = 0;
    value += (sets - 1) * restBetweenSets;
    value += sets * (holds.length - 1) * restBetweenHolds;
    holds.forEach((hold) {
      value += (hold.restBetweenRepetitions - 1) * hold.repetitions;
      value += hold.hangTime;
    });
    return value.toInt();
  }
}
