import 'package:flutter/foundation.dart';

import 'package:app/models/fingers.dart';
import 'package:app/models/hand_types.dart';

class Grip {
  const Grip(
      {@required this.fingers,
      this.crimped = false,
      @required this.assetSrc,
      @required this.description,
      @required this.assetWidth,
      @required this.assetHeight,
      @required this.dxHangAnchor,
      @required this.dyHangAnchor,
      @required this.handType,
      @required this.name})
      : dxRelativeHangAnchor = dxHangAnchor / assetWidth,
        dyRelativeHangAnchor = dyHangAnchor / assetHeight,
        assetAspectRatio = assetWidth / assetHeight;

  final HandTypes handType;
  final Fingers fingers;
  final bool crimped;
  final String assetSrc;
  final String name;
  final String description;
  final double dxHangAnchor;
  final double dyHangAnchor;
  final double dxRelativeHangAnchor;
  final double dyRelativeHangAnchor;
  final double assetWidth;
  final double assetHeight;
  final double assetAspectRatio;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Grip && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
