import 'package:flutter/cupertino.dart';

// Had to make a custom Icon widget in order to bypass the standard padding.
class Icon extends StatelessWidget {
  Icon({this.iconData, this.color});

  final IconData iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RichText(
        overflow: TextOverflow.visible, // Never clip.
        text: TextSpan(
          text: String.fromCharCode(iconData.codePoint),
          style: TextStyle(
            inherit: false,
            color: color,
            fontSize: 22,
            fontFamily: iconData.fontFamily,
            package: iconData.fontPackage,
          ),
        ));
  }
}
