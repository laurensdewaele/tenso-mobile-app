import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Board {
  Board(
      {@required this.manufacturer,
      @required this.model,
      @required this.size,
      @required this.boardHolds,
      @required this.assetSrc})
      : aspectRatio = size.aspectRatio;

  final String manufacturer;
  final String model;
  final Size size;
  final double aspectRatio;
  final List<BoardHold> boardHolds;
  final String assetSrc;
}

class BoardHold {
  BoardHold(
      {@required this.rect,
      @required this.holdType,
      @required this.referenceImage,
      @required this.maxAllowedFingers,
      this.sloperDegrees,
      this.minPocketDepth,
      this.maxPocketDepth,
      this.pocketDepth})
      : relativeRect = _determineRelativeRect(rect, referenceImage),
        aspectRatio = AspectRatio(
            aspectRatio: referenceImage.width / referenceImage.height);

  final HoldType holdType;
  final Size referenceImage;
  final int maxAllowedFingers;
  final Rect rect;
  final Rect relativeRect;
  final AspectRatio aspectRatio;
  final int sloperDegrees;
  final int minPocketDepth;
  final int maxPocketDepth;
  final int pocketDepth;

  static Rect _determineRelativeRect(Rect rect, Size boardSize) {
    return Rect.fromLTWH(
        rect.left / boardSize.width,
        rect.top / boardSize.height,
        rect.width / boardSize.width,
        rect.height / boardSize.height);
  }
}

// At a later stage we can specify the degrees of the sloper.
// The depth of the pocket.
// Etc...
enum HoldType { sloper, pocket, jug }
