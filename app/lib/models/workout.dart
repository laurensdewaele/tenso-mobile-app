import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/styles/styles.dart' as styles;

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
  Workout({
    @required this.difficulty,
    @required this.duration,
    @required this.sets,
    @required this.holdAmount,
    @required this.restBetweenSets,
    @required this.board,
    @required this.holds,
    @required this.name,
  })  : difficultyColor = _determineDifficultyColor(difficulty),
        averageRepetitions = _determineAverageRepetitions(holds),
        averageHangTime = _determineAverageHangTime(holds),
        averageRestBetweenRepetitions =
            _determineAverageRestBetweenRepetitions(holds),
        averageRestBetweenHolds = _determineAverageRestBetweenHolds(holds);

  final String name;
  final String difficulty;
  final Color difficultyColor;
  final int duration;
  final int holdAmount;
  final int sets;
  final int restBetweenSets;
  final Board board;
  final List<Hold> holds;

  final int averageRepetitions;
  final int averageHangTime;
  final int averageRestBetweenRepetitions;
  final int averageRestBetweenHolds;

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

  static int _determineAverageHangTime(List<Hold> holds) {
    int value = 0;
    holds.forEach((hold) => value += hold.hangTime);
    return value ~/ holds.length;
  }

  static int _determineAverageRestBetweenRepetitions(List<Hold> holds) {
    int value = 0;
    holds.forEach((hold) => value += hold.restBetweenRepetitions);
    return value ~/ holds.length;
  }

  static int _determineAverageRestBetweenHolds(List<Hold> holds) {
    int value = 0;
    holds.forEach((hold) => value += hold.restBeforeNextHold);
    return value ~/ holds.length;
  }
}
