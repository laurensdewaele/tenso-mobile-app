import 'dart:ui';

import 'package:tenso_app/models/models.dart';

const Size _kBoardSize = const Size(1110, 294);

final List<BoardHold> _boardHolds = [
  BoardHold((b) => b
    ..anchorXPercent = 125.5 / _kBoardSize.width
    ..anchorYPercent = 8 / _kBoardSize.height
    ..leftPercent = 0 / _kBoardSize.width
    ..topPercent = -21 / _kBoardSize.height
    ..widthPercent = 235 / _kBoardSize.width
    ..heightPercent = 42 / _kBoardSize.height
    ..position = 1
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 352 / _kBoardSize.width
    ..anchorYPercent = 4 / _kBoardSize.height
    ..leftPercent = 235 / _kBoardSize.width
    ..topPercent = -21 / _kBoardSize.height
    ..widthPercent = 221 / _kBoardSize.width
    ..heightPercent = 42 / _kBoardSize.height
    ..position = 2
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 554 / _kBoardSize.width
    ..anchorYPercent = 3 / _kBoardSize.height
    ..leftPercent = 456 / _kBoardSize.width
    ..topPercent = -21 / _kBoardSize.height
    ..widthPercent = 192 / _kBoardSize.width
    ..heightPercent = 42 / _kBoardSize.height
    ..position = 3
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 755 / _kBoardSize.width
    ..anchorYPercent = 2 / _kBoardSize.height
    ..leftPercent = 648 / _kBoardSize.width
    ..topPercent = -21 / _kBoardSize.height
    ..widthPercent = 232 / _kBoardSize.width
    ..heightPercent = 42 / _kBoardSize.height
    ..position = 4
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 991 / _kBoardSize.width
    ..anchorYPercent = 6 / _kBoardSize.height
    ..leftPercent = 880 / _kBoardSize.width
    ..topPercent = -21 / _kBoardSize.height
    ..widthPercent = 230 / _kBoardSize.width
    ..heightPercent = 42 / _kBoardSize.height
    ..position = 5
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 131 / _kBoardSize.width
    ..anchorYPercent = 85 / _kBoardSize.height
    ..leftPercent = 25 / _kBoardSize.width
    ..topPercent = 21 / _kBoardSize.height
    ..widthPercent = 210 / _kBoardSize.width
    ..heightPercent = 89 / _kBoardSize.height
    ..position = 6
    ..holdType = HoldType.pocket
    ..depth = 10
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 349 / _kBoardSize.width
    ..anchorYPercent = 81 / _kBoardSize.height
    ..leftPercent = 235 / _kBoardSize.width
    ..topPercent = 21 / _kBoardSize.height
    ..widthPercent = 210 / _kBoardSize.width
    ..heightPercent = 89 / _kBoardSize.height
    ..position = 7
    ..holdType = HoldType.pocket
    ..depth = 35
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 765 / _kBoardSize.width
    ..anchorYPercent = 76 / _kBoardSize.height
    ..leftPercent = 664 / _kBoardSize.width
    ..topPercent = 21 / _kBoardSize.height
    ..widthPercent = 210 / _kBoardSize.width
    ..heightPercent = 89 / _kBoardSize.height
    ..position = 8
    ..holdType = HoldType.pocket
    ..depth = 35
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 988 / _kBoardSize.width
    ..anchorYPercent = 87 / _kBoardSize.height
    ..leftPercent = 874 / _kBoardSize.width
    ..topPercent = 21 / _kBoardSize.height
    ..widthPercent = 210 / _kBoardSize.width
    ..heightPercent = 89 / _kBoardSize.height
    ..position = 9
    ..holdType = HoldType.pocket
    ..depth = 10
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 147 / _kBoardSize.width
    ..anchorYPercent = 175 / _kBoardSize.height
    ..leftPercent = 42 / _kBoardSize.width
    ..topPercent = 110 / _kBoardSize.height
    ..widthPercent = 201 / _kBoardSize.width
    ..heightPercent = 91 / _kBoardSize.height
    ..position = 10
    ..holdType = HoldType.pocket
    ..depth = 30
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 354 / _kBoardSize.width
    ..anchorYPercent = 174 / _kBoardSize.height
    ..leftPercent = 243 / _kBoardSize.width
    ..topPercent = 110 / _kBoardSize.height
    ..widthPercent = 202 / _kBoardSize.width
    ..heightPercent = 91 / _kBoardSize.height
    ..position = 11
    ..holdType = HoldType.pocket
    ..depth = 25
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 560 / _kBoardSize.width
    ..anchorYPercent = 165 / _kBoardSize.height
    ..leftPercent = 445 / _kBoardSize.width
    ..topPercent = 110 / _kBoardSize.height
    ..widthPercent = 219 / _kBoardSize.width
    ..heightPercent = 91 / _kBoardSize.height
    ..position = 12
    ..holdType = HoldType.pocket
    ..depth = 50
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 766 / _kBoardSize.width
    ..anchorYPercent = 171 / _kBoardSize.height
    ..leftPercent = 664 / _kBoardSize.width
    ..topPercent = 110 / _kBoardSize.height
    ..widthPercent = 210 / _kBoardSize.width
    ..heightPercent = 91 / _kBoardSize.height
    ..position = 13
    ..holdType = HoldType.pocket
    ..depth = 30
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 974 / _kBoardSize.width
    ..anchorYPercent = 172 / _kBoardSize.height
    ..leftPercent = 874 / _kBoardSize.width
    ..topPercent = 110 / _kBoardSize.height
    ..widthPercent = 193 / _kBoardSize.width
    ..heightPercent = 91 / _kBoardSize.height
    ..position = 14
    ..holdType = HoldType.pocket
    ..depth = 25
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 155 / _kBoardSize.width
    ..anchorYPercent = 265 / _kBoardSize.height
    ..leftPercent = 43 / _kBoardSize.width
    ..topPercent = 201 / _kBoardSize.height
    ..widthPercent = 200 / _kBoardSize.width
    ..heightPercent = 88 / _kBoardSize.height
    ..position = 15
    ..holdType = HoldType.pocket
    ..depth = 20
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 358 / _kBoardSize.width
    ..anchorYPercent = 264 / _kBoardSize.height
    ..leftPercent = 243 / _kBoardSize.width
    ..topPercent = 201 / _kBoardSize.height
    ..widthPercent = 202 / _kBoardSize.width
    ..heightPercent = 88 / _kBoardSize.height
    ..position = 16
    ..holdType = HoldType.pocket
    ..depth = 15
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 557 / _kBoardSize.width
    ..anchorYPercent = 263 / _kBoardSize.height
    ..leftPercent = 445 / _kBoardSize.width
    ..topPercent = 201 / _kBoardSize.height
    ..widthPercent = 219 / _kBoardSize.width
    ..heightPercent = 88 / _kBoardSize.height
    ..position = 17
    ..holdType = HoldType.pocket
    ..depth = 22
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 758 / _kBoardSize.width
    ..anchorYPercent = 259 / _kBoardSize.height
    ..leftPercent = 664 / _kBoardSize.width
    ..topPercent = 201 / _kBoardSize.height
    ..widthPercent = 210 / _kBoardSize.width
    ..heightPercent = 88 / _kBoardSize.height
    ..position = 18
    ..holdType = HoldType.pocket
    ..depth = 20
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 965 / _kBoardSize.width
    ..anchorYPercent = 264 / _kBoardSize.height
    ..leftPercent = 874 / _kBoardSize.width
    ..topPercent = 201 / _kBoardSize.height
    ..widthPercent = 193 / _kBoardSize.width
    ..heightPercent = 88 / _kBoardSize.height
    ..position = 19
    ..holdType = HoldType.pocket
    ..depth = 15
    ..supportedFingers = 5),
];

final grindstoneMk1 = Board((b) => b
  ..name = 'Tension climbing - Grindstone Mk1'
  ..id = 'grindstone_mk1'
  ..manufacturer = 'Tension climbing'
  ..model = 'Grindstone Mk1'
  ..imageAssetWidth = _kBoardSize.width
  ..imageAssetHeight = _kBoardSize.height
  ..imageAsset = 'assets/images/boards/grindstone_mk1.png'
  ..handToBoardHeightRatio = .9
  ..boardHolds.addAll(_boardHolds)
  ..defaultLeftGripHold = _boardHolds
      .singleWhere((boardHold) => boardHold.position == 15)
      .toBuilder()
  ..defaultRightGripHold = _boardHolds
      .singleWhere((boardHold) => boardHold.position == 18)
      .toBuilder());
