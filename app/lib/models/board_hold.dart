import 'dart:ui';

import 'package:flutter/foundation.dart';

class BoardHold {
  BoardHold(
      {@required this.holdType,
      @required this.maxAllowedFingers,
      @required this.rect,
      @required this.boardSize,
      this.sloperDegrees,
      this.minPocketDepth,
      this.maxPocketDepth,
      this.pocketDepth})
      : relativeRect = _determineRelativeRect(rect, boardSize);

  final Rect rect;
  final HoldType holdType;
  final int maxAllowedFingers;
  final Size boardSize;
  final Rect relativeRect;
  final double sloperDegrees;
  final double minPocketDepth;
  final double maxPocketDepth;
  final double pocketDepth;

  static Rect _determineRelativeRect(Rect rect, Size boardSize) {
    return Rect.fromLTWH(
        rect.left / boardSize.width,
        rect.top / boardSize.height,
        rect.width / boardSize.width,
        rect.height / boardSize.height);
  }
}

enum HoldType { sloper, pocket, jug }
