import 'dart:ui';

import 'package:tenso_app/models/models.dart';

const Size _kBoardSize = const Size(1000, 414);

final List<BoardHold> _boardHolds = [
  BoardHold((b) => b
    ..anchorXPercent = 175 / _kBoardSize.width
    ..anchorYPercent = 81 / _kBoardSize.height
    ..leftPercent = 55 / _kBoardSize.width
    ..topPercent = 10 / _kBoardSize.height
    ..widthPercent = 226 / _kBoardSize.width
    ..heightPercent = 94 / _kBoardSize.height
    ..position = 1
    ..holdType = HoldType.pocket
    ..supportedFingers = 3
    ..depth = 28),
  BoardHold((b) => b
    ..anchorXPercent = 348 / _kBoardSize.width
    ..anchorYPercent = 87 / _kBoardSize.height
    ..leftPercent = 281 / _kBoardSize.width
    ..topPercent = 10 / _kBoardSize.height
    ..widthPercent = 122 / _kBoardSize.width
    ..heightPercent = 94 / _kBoardSize.height
    ..position = 2
    ..holdType = HoldType.pocket
    ..supportedFingers = 1
    ..depth = 28),
  BoardHold((b) => b
    ..anchorXPercent = 505 / _kBoardSize.width
    ..anchorYPercent = 85 / _kBoardSize.height
    ..leftPercent = 403 / _kBoardSize.width
    ..topPercent = 10 / _kBoardSize.height
    ..widthPercent = 189 / _kBoardSize.width
    ..heightPercent = 94 / _kBoardSize.height
    ..position = 3
    ..holdType = HoldType.pocket
    ..supportedFingers = 2
    ..depth = 28),
  BoardHold((b) => b
    ..anchorXPercent = 654 / _kBoardSize.width
    ..anchorYPercent = 88 / _kBoardSize.height
    ..leftPercent = 592 / _kBoardSize.width
    ..topPercent = 10 / _kBoardSize.height
    ..widthPercent = 123 / _kBoardSize.width
    ..heightPercent = 94 / _kBoardSize.height
    ..position = 4
    ..holdType = HoldType.pocket
    ..supportedFingers = 1
    ..depth = 28),
  BoardHold((b) => b
    ..anchorXPercent = 834 / _kBoardSize.width
    ..anchorYPercent = 83 / _kBoardSize.height
    ..leftPercent = 715 / _kBoardSize.width
    ..topPercent = 10 / _kBoardSize.height
    ..widthPercent = 232 / _kBoardSize.width
    ..heightPercent = 94 / _kBoardSize.height
    ..position = 5
    ..holdType = HoldType.pocket
    ..supportedFingers = 3
    ..depth = 28),
  BoardHold((b) => b
    ..anchorXPercent = 507 / _kBoardSize.width
    ..anchorYPercent = 184 / _kBoardSize.height
    ..leftPercent = 341 / _kBoardSize.width
    ..topPercent = 104 / _kBoardSize.height
    ..widthPercent = 324 / _kBoardSize.width
    ..heightPercent = 104 / _kBoardSize.height
    ..position = 6
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 223 / _kBoardSize.width
    ..anchorYPercent = 327 / _kBoardSize.height
    ..leftPercent = 55 / _kBoardSize.width
    ..topPercent = 235 / _kBoardSize.height
    ..widthPercent = 324 / _kBoardSize.width
    ..heightPercent = 113 / _kBoardSize.height
    ..position = 7
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 792 / _kBoardSize.width
    ..anchorYPercent = 328 / _kBoardSize.height
    ..leftPercent = 623 / _kBoardSize.width
    ..topPercent = 235 / _kBoardSize.height
    ..widthPercent = 324 / _kBoardSize.width
    ..heightPercent = 113 / _kBoardSize.height
    ..position = 8
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 181 / _kBoardSize.width
    ..anchorYPercent = 361 / _kBoardSize.height
    ..leftPercent = 0 / _kBoardSize.width
    ..topPercent = 348 / _kBoardSize.height
    ..widthPercent = 333 / _kBoardSize.width
    ..heightPercent = 63 / _kBoardSize.height
    ..position = 9
    ..holdType = HoldType.edge
    ..depth = 12
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 508 / _kBoardSize.width
    ..anchorYPercent = 361 / _kBoardSize.height
    ..leftPercent = 333 / _kBoardSize.width
    ..topPercent = 348 / _kBoardSize.height
    ..widthPercent = 333 / _kBoardSize.width
    ..heightPercent = 63 / _kBoardSize.height
    ..position = 10
    ..holdType = HoldType.edge
    ..depth = 12
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 833 / _kBoardSize.width
    ..anchorYPercent = 361 / _kBoardSize.height
    ..leftPercent = 666 / _kBoardSize.width
    ..topPercent = 348 / _kBoardSize.height
    ..widthPercent = 333 / _kBoardSize.width
    ..heightPercent = 63 / _kBoardSize.height
    ..position = 11
    ..holdType = HoldType.edge
    ..depth = 12
    ..supportedFingers = 5),
];

final awesomeWoodysCliffBoardMiniBack = Board((b) => b
  ..name = 'Awesome Woodys - cliff board mini (back)'
  ..id = 'awesome_woodys_mini_back'
  ..manufacturer = 'Awesome Woodys'
  ..model = 'cliff board mini'
  ..imageAssetWidth = _kBoardSize.width
  ..imageAssetHeight = _kBoardSize.height
  ..imageAsset = 'assets/images/boards/awesome_woodys_cliff_board_mini_back.png'
  ..handToBoardHeightRatio = .937
  ..boardHolds.addAll(_boardHolds)
  ..defaultLeftGripHold = _boardHolds
      .singleWhere((boardHold) => boardHold.position == 9)
      .toBuilder()
  ..defaultRightGripHold = _boardHolds
      .singleWhere((boardHold) => boardHold.position == 11)
      .toBuilder());