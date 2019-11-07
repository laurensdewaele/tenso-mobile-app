import 'package:app/widgets/difficulty.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';

class CardOverviewCollapsed extends StatelessWidget {
  const CardOverviewCollapsed(
      {@required this.title,
      @required this.difficultyColor,
      @required this.difficulty});

  final String title;
  final Color difficultyColor;
  final int difficulty;

  @override
  Widget build(BuildContext context) {
    return Card(
        padding: EdgeInsets.all(styles.Spacings.s),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: styles.Typography.title),
              Difficulty(
                difficulty: difficulty,
                difficultyColor: difficultyColor,
              )
            ]));
  }
}
