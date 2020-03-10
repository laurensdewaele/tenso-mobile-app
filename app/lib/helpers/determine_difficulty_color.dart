import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

Color determineDifficultyColor(int difficulty) {
  if (difficulty == 10) return styles.difficultyColors[4];
  return styles.difficultyColors[difficulty ~/ 2];
}
