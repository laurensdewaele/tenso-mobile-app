import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class Card extends StatelessWidget {
  const Card(
      {@required this.child,
      this.padding,
      this.border = false,
      this.bgColor = styles.Colors.bgWhite});

  final Widget child;
  final EdgeInsets padding;
  final bool border;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final BoxDecoration _boxDecoration = border == true
        ? BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border: Border.all(color: styles.Colors.gray),
            color: bgColor,
          )
        : BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            color: bgColor,
          );

    return Container(
      decoration: _boxDecoration,
      padding: padding,
      child: child,
    );
  }
}
