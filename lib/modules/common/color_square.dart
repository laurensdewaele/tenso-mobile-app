import 'package:flutter/widgets.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class ColorSquare extends StatelessWidget {
  const ColorSquare({
    this.text,
    @required this.color,
    @required this.width,
    @required this.height,
  });

  final String text;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            boxShadow: [styles.kBoxShadow],
            borderRadius: styles.kBorderRadiusAll,
            color: color),
        height: height,
        width: width,
        child: text != null
            ? Center(child: Text(text, style: styles.Staatliches.colorSquare))
            : null);
  }
}
