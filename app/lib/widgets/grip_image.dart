import 'dart:math' show pi;

import 'package:flutter/cupertino.dart';

import 'package:app/models/hand_hold.dart';
import 'package:app/styles/styles.dart' as styles;

class GripImage extends StatelessWidget {
  GripImage(
      {Key key,
      @required this.handHold,
      @required this.imageWidth,
      @required this.assetSrc,
      @required this.selected})
      : super(key: key);

  final HandHolds handHold;
  final double imageWidth;
  final String assetSrc;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final Widget image = Image.asset(
      assetSrc,
      color: selected ? styles.Colors.black : styles.Colors.lightGray,
    );

    return handHold == HandHolds.oneHandedLeft
        ? image
        : Transform.translate(
            offset: Offset(imageWidth, 0),
            child: Transform(
              transform: Matrix4.rotationY(pi),
              child: image,
            ),
          );
  }
}
