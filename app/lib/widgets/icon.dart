import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

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
              shadows: [
                Shadow(
                    color: styles.Colors.shadow,
                    offset: styles.kShadowOffset,
                    blurRadius: styles.kShadowBlurRadius)
              ]),
        ));
  }
}
