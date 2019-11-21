import 'package:flutter/cupertino.dart';

import 'package:app/routes/routes.dart';
import 'package:app/styles/styles.dart' as styles;

const Map<int, Color> difficultyColors = {
  0: styles.Colors.difficultyYellow,
  1: styles.Colors.difficultyOrange,
  2: styles.Colors.difficultyBlue,
  3: styles.Colors.primary,
  4: styles.Colors.black
};

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

  final int difficulty;
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

  static Color _determineDifficultyColor(int difficulty) {
    final int totalSteps = difficultyColors.length;
    final double divider = 100 / totalSteps;
    final int step = difficulty ~/ divider;

    if (step >= totalSteps) {
      return difficultyColors[totalSteps - 1];
    }

    return difficultyColors[step];
  }

  static String _determineRepetitions(List<Hold> holds) {
    String repetitions;

    for (final hold in holds) {
      if (repetitions == null) {
        repetitions = hold.repetitions.toString();
      } else {
        if (hold.repetitions.toString() != repetitions) {
          repetitions = 'mixed';
        }
      }
    }

    return repetitions;
  }
}

@immutable
class Hold {
  const Hold(
      // TODO: Mark all as required
      {this.grip,
      this.twoHanded,
      this.leftHanded,
      this.rightHanded,
      this.pockets,
      this.repetitions,
      this.restBetweenRepetitions,
      this.hangTime,
      this.addedWeight});

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

class MenuItem {
  const MenuItem({this.name, this.route});
  final String name;
  final Routes route;
}
