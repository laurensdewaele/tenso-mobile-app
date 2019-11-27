import 'package:flutter/cupertino.dart';

// Had to make a custom Icon widget in order to bypass the standard padding.
class Icon extends StatelessWidget {
  Icon({this.iconData, this.color, this.size = 22.0});

  final IconData iconData;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return RichText(
        overflow: TextOverflow.visible, // Never clip.
        text: TextSpan(
          text: String.fromCharCode(iconData.codePoint),
          style: TextStyle(
            inherit: false,
            color: color,
            fontSize: size,
            fontFamily: iconData.fontFamily,
            package: iconData.fontPackage,
          ),
        ));
  }
}
