import 'package:flutter/cupertino.dart' hide Card, Divider;

import 'package:app/styles/styles.dart' as styles;

enum InnerBoxShadowRadiusPosition { left, right }

class InnerBoxShadow extends StatelessWidget {
  InnerBoxShadow({this.position})
      : _borderRadius = _determineBorderRadius(position);

  final InnerBoxShadowRadiusPosition position;
  final BorderRadius _borderRadius;

  static BorderRadius _determineBorderRadius(
      InnerBoxShadowRadiusPosition position) {
    if (position == InnerBoxShadowRadiusPosition.left) {
      return BorderRadius.only(topLeft: styles.kAppBorderRadius);
    }
    return BorderRadius.only(topRight: styles.kAppBorderRadius);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
          borderRadius: _borderRadius,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 0, 0, .2),
                Color.fromRGBO(0, 0, 0, 0),
              ])),
    );
  }
}
