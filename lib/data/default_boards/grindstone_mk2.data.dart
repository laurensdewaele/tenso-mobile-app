import 'dart:ui';

import 'package:tenso_app/models/models.dart';

const Size _kBoardSize = const Size(558, 153);

final List<BoardHold> _boardHolds = [
  BoardHold((b) => b
    ..anchorXPercent = 65 / _kBoardSize.width
    ..anchorYPercent = 0 / _kBoardSize.height
    ..leftPercent = 0 / _kBoardSize.width
    ..topPercent = -15 / _kBoardSize.height
    ..widthPercent = 117 / _kBoardSize.width
    ..heightPercent = 25 / _kBoardSize.height
    ..position = 1
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 182 / _kBoardSize.width
    ..anchorYPercent = 0 / _kBoardSize.height
    ..leftPercent = 117 / _kBoardSize.width
    ..topPercent = -15 / _kBoardSize.height
    ..widthPercent = 117 / _kBoardSize.width
    ..heightPercent = 25 / _kBoardSize.height
    ..position = 2
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 284 / _kBoardSize.width
    ..anchorYPercent = 0 / _kBoardSize.height
    ..leftPercent = 234 / _kBoardSize.width
    ..topPercent = -15 / _kBoardSize.height
    ..widthPercent = 97 / _kBoardSize.width
    ..heightPercent = 25 / _kBoardSize.height
    ..position = 3
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 392 / _kBoardSize.width
    ..anchorYPercent = 0 / _kBoardSize.height
    ..leftPercent = 331 / _kBoardSize.width
    ..topPercent = -15 / _kBoardSize.height
    ..widthPercent = 114 / _kBoardSize.width
    ..heightPercent = 25 / _kBoardSize.height
    ..position = 4
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 500 / _kBoardSize.width
    ..anchorYPercent = 0 / _kBoardSize.height
    ..leftPercent = 445 / _kBoardSize.width
    ..topPercent = -15 / _kBoardSize.height
    ..widthPercent = 114 / _kBoardSize.width
    ..heightPercent = 25 / _kBoardSize.height
    ..position = 5
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 72 / _kBoardSize.width
    ..anchorYPercent = 38 / _kBoardSize.height
    ..leftPercent = 14 / _kBoardSize.width
    ..topPercent = 10 / _kBoardSize.height
    ..widthPercent = 107 / _kBoardSize.width
    ..heightPercent = 34 / _kBoardSize.height
    ..position = 6
    ..holdType = HoldType.pocket
    ..depth = 10
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 167 / _kBoardSize.width
    ..anchorYPercent = 38 / _kBoardSize.height
    ..leftPercent = 121 / _kBoardSize.width
    ..topPercent = 10 / _kBoardSize.height
    ..widthPercent = 95 / _kBoardSize.width
    ..heightPercent = 34 / _kBoardSize.height
    ..position = 7
    ..holdType = HoldType.pocket
    ..depth = 8
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 398 / _kBoardSize.width
    ..anchorYPercent = 38 / _kBoardSize.height
    ..leftPercent = 346 / _kBoardSize.width
    ..topPercent = 10 / _kBoardSize.height
    ..widthPercent = 102 / _kBoardSize.width
    ..heightPercent = 34 / _kBoardSize.height
    ..position = 8
    ..holdType = HoldType.pocket
    ..depth = 10
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 494 / _kBoardSize.width
    ..anchorYPercent = 38 / _kBoardSize.height
    ..leftPercent = 448 / _kBoardSize.width
    ..topPercent = 10 / _kBoardSize.height
    ..widthPercent = 97 / _kBoardSize.width
    ..heightPercent = 34 / _kBoardSize.height
    ..position = 9
    ..holdType = HoldType.pocket
    ..depth = 8
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 76 / _kBoardSize.width
    ..anchorYPercent = 88 / _kBoardSize.height
    ..leftPercent = 14 / _kBoardSize.width
    ..topPercent = 54 / _kBoardSize.height
    ..widthPercent = 114 / _kBoardSize.width
    ..heightPercent = 41 / _kBoardSize.height
    ..position = 10
    ..holdType = HoldType.pocket
    ..depth = 30
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 171 / _kBoardSize.width
    ..anchorYPercent = 88 / _kBoardSize.height
    ..leftPercent = 128 / _kBoardSize.width
    ..topPercent = 54 / _kBoardSize.height
    ..widthPercent = 88 / _kBoardSize.width
    ..heightPercent = 41 / _kBoardSize.height
    ..position = 11
    ..holdType = HoldType.pocket
    ..depth = 25
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 283 / _kBoardSize.width
    ..anchorYPercent = 88 / _kBoardSize.height
    ..leftPercent = 227 / _kBoardSize.width
    ..topPercent = 54 / _kBoardSize.height
    ..widthPercent = 110 / _kBoardSize.width
    ..heightPercent = 41 / _kBoardSize.height
    ..position = 12
    ..holdType = HoldType.pocket
    ..depth = 55
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 396 / _kBoardSize.width
    ..anchorYPercent = 88 / _kBoardSize.height
    ..leftPercent = 346 / _kBoardSize.width
    ..topPercent = 54 / _kBoardSize.height
    ..widthPercent = 99 / _kBoardSize.width
    ..heightPercent = 41 / _kBoardSize.height
    ..position = 13
    ..holdType = HoldType.pocket
    ..depth = 30
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 488 / _kBoardSize.width
    ..anchorYPercent = 88 / _kBoardSize.height
    ..leftPercent = 443 / _kBoardSize.width
    ..topPercent = 54 / _kBoardSize.height
    ..widthPercent = 95 / _kBoardSize.width
    ..heightPercent = 41 / _kBoardSize.height
    ..position = 14
    ..holdType = HoldType.pocket
    ..depth = 25
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 77 / _kBoardSize.width
    ..anchorYPercent = 140 / _kBoardSize.height
    ..leftPercent = 14 / _kBoardSize.width
    ..topPercent = 105 / _kBoardSize.height
    ..widthPercent = 114 / _kBoardSize.width
    ..heightPercent = 41 / _kBoardSize.height
    ..position = 15
    ..holdType = HoldType.pocket
    ..depth = 20
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 171 / _kBoardSize.width
    ..anchorYPercent = 140 / _kBoardSize.height
    ..leftPercent = 128 / _kBoardSize.width
    ..topPercent = 105 / _kBoardSize.height
    ..widthPercent = 88 / _kBoardSize.width
    ..heightPercent = 41 / _kBoardSize.height
    ..position = 16
    ..holdType = HoldType.pocket
    ..depth = 15
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 397 / _kBoardSize.width
    ..anchorYPercent = 140 / _kBoardSize.height
    ..leftPercent = 346 / _kBoardSize.width
    ..topPercent = 105 / _kBoardSize.height
    ..widthPercent = 97 / _kBoardSize.width
    ..heightPercent = 41 / _kBoardSize.height
    ..position = 17
    ..holdType = HoldType.pocket
    ..depth = 20
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 487 / _kBoardSize.width
    ..anchorYPercent = 140 / _kBoardSize.height
    ..leftPercent = 443 / _kBoardSize.width
    ..topPercent = 105 / _kBoardSize.height
    ..widthPercent = 97 / _kBoardSize.width
    ..heightPercent = 41 / _kBoardSize.height
    ..position = 18
    ..holdType = HoldType.pocket
    ..depth = 15
    ..supportedFingers = 5),
];

final grindstoneMk2 = Board((b) => b
  ..name = 'Tension climbing - Grindstone Mk2'
  ..id = 'grindstone_mk2'
  ..manufacturer = 'Tension climbing'
  ..model = 'Grindstone Mk2'
  ..imageAssetWidth = _kBoardSize.width
  ..imageAssetHeight = _kBoardSize.height
  ..imageAsset = 'assets/images/boards/grindstone_mk2.png'
  ..handToBoardHeightRatio = .74
  ..boardHolds.addAll(_boardHolds)
  ..defaultLeftGripHold = _boardHolds
      .singleWhere((boardHold) => boardHold.position == 15)
      .toBuilder()
  ..defaultRightGripHold = _boardHolds
      .singleWhere((boardHold) => boardHold.position == 17)
      .toBuilder());
