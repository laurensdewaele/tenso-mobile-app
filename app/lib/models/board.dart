import 'dart:ui';

import 'package:flutter/foundation.dart';

class Board {
  Board(
      {@required this.manufacturer,
      @required this.model,
      @required this.size,
      @required this.holds})
      : aspectRatio = size.aspectRatio;

  final String manufacturer;
  final String model;
  final Size size;
  final double aspectRatio;
  final List<BoardHold> holds;
}

class BoardHold {
  BoardHold({this.offset, this.size, this.holdType})
      : relativeRect = offset & size;

  final Offset offset;
  final Size size;
  final Rect relativeRect;
  final HoldType holdType;
}

// At a later stage we can specify the degrees of the sloper.
// The depth of the pocket.
// Etc...
enum HoldType { sloper, pocket, jug }

final beastmaker1000 = Board(
    manufacturer: 'Beastmaker',
    model: '1000',
    size: Size(10, 10),
    holds: [
      BoardHold(
          offset: Offset(0, 0), size: Size(10, 20), holdType: HoldType.jug)
    ]);
