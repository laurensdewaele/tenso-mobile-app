import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:app/models/board_hold.dart';

class Board {
  const Board(
      {@required this.manufacturer,
      @required this.model,
      @required this.size,
      @required this.boardHolds,
      @required this.assetSrc,
      @required this.handToBoardHeightRatio,
      @required this.aspectRatio,
      @required this.defaultLeftGripHold,
      @required this.defaultRightGripHold});

  final String manufacturer;
  final String model;
  final Size size;
  final double aspectRatio;
  final List<BoardHold> boardHolds;
  final double handToBoardHeightRatio;
  final String assetSrc;
  final BoardHold defaultLeftGripHold;
  final BoardHold defaultRightGripHold;
}
