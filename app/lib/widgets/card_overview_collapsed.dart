import 'package:flutter/cupertino.dart';

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
    return Text('$title');
  }
}
