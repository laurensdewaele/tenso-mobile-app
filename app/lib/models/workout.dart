import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/styles/styles.dart' as styles;

enum WorkoutProperties {
  difficulty,
  duration,
  sets,
  holdCount,
  restBetweenSets,
  board,
  holds,
  name,
  averageRepetitions,
  averageRestBetweenHolds,
  averageRestBetweenRepetitions,
  averageHangTime
}

@immutable
class Workout {
  Workout({
    @required this.difficulty,
    @required this.sets,
    @required this.holdCount,
    @required this.restBetweenSets,
    @required this.board,
    @required this.holds,
    @required this.name,
  })  : difficultyColor = _determineDifficultyColor(difficulty),
        duration = _calculateDuration(
            holds: holds, restBetweenSets: restBetweenSets, sets: sets);

  final String name;
  final String difficulty;
  final Color difficultyColor;
  final int duration;
  final int holdCount;
  final int sets;
  final int restBetweenSets;
  final Board board;
  final List<Hold> holds;

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

  static int _calculateDuration({List<Hold> holds, sets, restBetweenSets}) {
    int value = 0;
    value += sets * restBetweenSets;
    holds.forEach((hold) {
      value += hold.restBetweenRepetitions * hold.repetitions;
      value += hold.restBeforeNextHold;
      value += hold.hangTime;
    });
    return value.toInt();
  }
}
