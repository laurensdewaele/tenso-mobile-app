import 'package:flutter/widgets.dart';

import 'package:app/styles/styles.dart' as styles;

class Square extends StatelessWidget {
  const Square(
      {@required this.value,
      @required this.difficultyColor,
      @required this.width,
      @required this.height,
      this.isSmall = false});

  final String value;
  final Color difficultyColor;
  final double width;
  final double height;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [styles.kAppBoxShadow],
          borderRadius: styles.kAppBorderRadiusAll,
          color: difficultyColor),
      height: height,
      width: width,
      child: Center(
          child: Text(value,
              style: isSmall
                  ? styles.Typography.smallSquare
                  : styles.Typography.difficultySquare)),
    );
  }
}
