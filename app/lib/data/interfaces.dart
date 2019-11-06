// Order is specified according to the designs
import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart';

const Map<int, Color> difficultyColors = {
  0: AppColors.difficultyYellow,
  1: AppColors.difficultyOrange,
  2: AppColors.difficultyBlue,
  3: AppColors.difficultyRed,
  4: AppColors.difficultyBlack,
  5: AppColors.difficultyBlack
};

class Workout {
  Workout({
    @required this.difficulty,
    @required this.duration,
    @required this.sets,
    @required this.restBetweenHolds,
    @required this.restBetweenSets,
    @required this.board,
    @required this.holds,
    @required this.name,
  })  : holdAmount = holds.length,
        difficultyColor = _calculateDifficultyColor(difficulty);

  static Color _calculateDifficultyColor(int difficulty) {
    const int difficultySteps = 20;
    final int difficultyNo = difficulty ~/ difficultySteps;
    return difficultyColors[difficultyNo];
  }

  final int difficulty;
  final Color difficultyColor;
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
  WorkoutOverview(
      {@required this.name,
      @required this.difficulty,
      @required this.repetitions,
      @required this.duration,
      @required this.sets})
      : difficultyColor = _calculateDifficultyColor(difficulty);

  static Color _calculateDifficultyColor(int difficulty) {
    const int difficultySteps = 20;
    final int difficultyNo = difficulty ~/ difficultySteps;
    return difficultyColors[difficultyNo];
  }

  final String name;
  final int difficulty;
  final Color difficultyColor;
  final int repetitions;
  final int duration;
  final int sets;
}
