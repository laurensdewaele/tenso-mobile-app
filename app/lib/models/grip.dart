import 'package:flutter/foundation.dart';

import 'package:app/models/fingers.dart';

class Grip {
  const Grip(
      {@required this.fingers,
      this.crimped = false,
      @required this.assetSrc,
      @required this.description,
      @required this.dyRelativeHangAnchorPoint,
      this.name});

  final Fingers fingers;
  final bool crimped;
  final String assetSrc;
  final String name;
  final String description;
  final double dyRelativeHangAnchorPoint;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Grip && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
