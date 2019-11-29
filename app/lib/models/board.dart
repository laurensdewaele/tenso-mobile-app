import 'dart:ui';

class Board {
  Board({this.manufacturer, this.model, this.size, this.holds})
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
