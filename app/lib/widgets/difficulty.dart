import 'package:flutter/widgets.dart';

import 'package:app/styles/styles.dart';

class Difficulty extends StatelessWidget {
  const Difficulty({this.difficulty, this.difficultyColor});

  final int difficulty;
  final Color difficultyColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [kAppBoxShadow],
          borderRadius: kAppBorderRadius,
          color: difficultyColor),
      padding: EdgeInsets.all(AppSpacings.small),
      child: Text(difficulty.toString()),
    );
  }
}
