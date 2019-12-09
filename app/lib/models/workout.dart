import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/models/hold.dart';

enum WorkoutProperties {
  difficulty,
  duration,
  sets,
  holdAmount,
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
  // TODO: Mark all as required (disabled for testing purposes).
  Workout(
      {this.difficulty,
      this.duration,
      this.sets,
      this.holdAmount,
      this.restBetweenSets,
      this.board,
      this.holds,
      this.name,
      this.averageRestBetweenHolds,
      this.averageRestBetweenRepetitions,
      this.averageHangTime})
      : difficultyColor = _determineDifficultyColor(difficulty),
        averageRepetitions = _determineAverageRepetitions(holds);

  final String name;
  final String difficulty;
  final Color difficultyColor;
  final int duration;
  final int holdAmount;
  final int sets;
  final int restBetweenSets;
  final String board;
  final List<Hold> holds;

  final int averageRepetitions;
  final int averageRestBetweenHolds;
  final int averageRestBetweenRepetitions;
  final int averageHangTime;

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

  static int _determineAverageRepetitions(List<Hold> holds) {
    int value = 0;
    holds.forEach((hold) => value += hold.repetitions);
    return value ~/ holds.length;
  }
}
