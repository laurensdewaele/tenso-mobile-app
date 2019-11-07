import 'package:flutter/widgets.dart';

import 'package:app/styles/styles.dart' as styles;

class Difficulty extends StatelessWidget {
  const Difficulty({this.difficulty, this.difficultyColor});

  final int difficulty;
  final Color difficultyColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [styles.kAppBoxShadow],
          borderRadius: styles.kAppBorderRadius,
          color: difficultyColor),
      height: styles.Spacings.xl,
      width: styles.Spacings.xl,
      child: Center(
          child:
              Text(difficulty.toString(), style: styles.Typography.difficulty)),
    );
  }
}
