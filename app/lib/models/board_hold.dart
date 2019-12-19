import 'dart:ui';

import 'package:flutter/foundation.dart';

class BoardHold {
//class BoardHold {
  BoardHold(
      {@required this.holdType,
      @required this.maxAllowedFingers,
      @required this.rect,
      @required this.boardSize,
      @required this.dxHangAnchor,
      @required this.dyHangAnchor,
      this.sloperDegrees,
      this.minPocketDepth,
      this.maxPocketDepth,
      this.pocketDepth})
      : relativeRect = _determineRelativeRect(rect, boardSize),
        dxRelativeHangAnchor = dxHangAnchor / boardSize.width,
        dyRelativeHangAnchor = dyHangAnchor / boardSize.height;

  final Rect rect;
  final HoldTypes holdType;
  final int maxAllowedFingers;
  final Size boardSize;
  final Rect relativeRect;
  final double sloperDegrees;
  final double minPocketDepth;
  final double maxPocketDepth;
  final double pocketDepth;
  final double dxHangAnchor;
  final double dyHangAnchor;
  final double dxRelativeHangAnchor;
  final double dyRelativeHangAnchor;

  static Rect _determineRelativeRect(Rect rect, Size boardSize) {
    return Rect.fromLTWH(
        rect.left / boardSize.width,
        rect.top / boardSize.height,
        rect.width / boardSize.width,
        rect.height / boardSize.height);
  }
}

enum HoldTypes { sloper, pocket, jug, roundedPocket }
