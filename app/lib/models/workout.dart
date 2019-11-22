import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/models/hold.dart';

@immutable
class Workout {
  // TODO: Mark all as required (disabled for testing purposes).
  Workout({
    this.difficulty,
    this.duration,
    this.sets,
    this.restBetweenHolds,
    this.restBetweenSets,
    this.board,
    this.holds,
    this.name,
  })  : holdAmount = holds.length,
        difficultyColor = _determineDifficultyColor(difficulty),
        repetitions = _determineRepetitions(holds);

  final String difficulty;
  final Color difficultyColor;
  final String repetitions;
  final int duration;
  final int holdAmount;
  final int sets;
  final int restBetweenHolds;
  final int restBetweenSets;
  final String board;
  final List<Hold> holds;
  final String name;

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

  static String _determineRepetitions(List<Hold> holds) {
    String repetitions;

    for (final hold in holds) {
      if (repetitions == null) {
        repetitions = hold.repetitions.toString();
      } else {
        if (hold.repetitions.toString() != repetitions) {
          repetitions = 'mixed';
          break;
        }
      }
    }

    return repetitions;
  }
}
