import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/models/hold.dart';

enum WorkoutProperties {
  difficulty,
  duration,
  sets,
  holdAmount,
  repetitions,
  restBetweenHolds,
  restBetweenRepetitions,
  restBetweenSets,
  board,
  holds,
  name,
  averageHoldAmount,
  averageRepetitions,
  averageRestBetweenHolds,
  averageRestBetweenRepetitions
}

@immutable
class Workout {
  // TODO: Mark all as required (disabled for testing purposes).
  Workout(
      {this.difficulty,
      this.duration,
      this.sets,
      this.holdAmount,
      this.repetitions,
      this.restBetweenHolds,
      this.restBetweenRepetitions,
      this.restBetweenSets,
      this.board,
      this.holds,
      this.name,
      this.averageHoldAmount,
      this.averageRepetitions,
      this.averageRestBetweenHolds,
      this.averageRestBetweenRepetitions})
      : difficultyColor = _determineDifficultyColor(difficulty);

  final String difficulty;
  final Color difficultyColor;
  final int repetitions;
  final int duration;
  final int holdAmount;
  final int sets;
  final int restBetweenHolds;
  final int restBetweenRepetitions;
  final int restBetweenSets;
  final String board;
  final List<Hold> holds;
  final String name;

  final int averageRepetitions;
  final int averageHoldAmount;
  final int averageRestBetweenHolds;
  final int averageRestBetweenRepetitions;

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
}
