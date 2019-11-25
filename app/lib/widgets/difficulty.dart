import 'package:flutter/widgets.dart';

import 'package:app/styles/styles.dart' as styles;

class Difficulty extends StatelessWidget {
  const Difficulty({
    @required this.value,
    @required this.difficultyColor,
    @required this.width,
    @required this.height,
  });

  final String value;
  final Color difficultyColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [styles.kAppBoxShadow],
          borderRadius: styles.kAppBorderRadiusAll,
          color: difficultyColor),
      height: height,
      width: width,
      child: Center(child: Text(value, style: styles.Typography.difficulty)),
    );
  }
}
