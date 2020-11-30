import 'dart:ui';

import 'package:tenso_app/models/models.dart';

const Size _kBoardSize = const Size(1000, 627);

final List<BoardHold> _boardHolds = [
  BoardHold((b) => b
    ..anchorXPercent = 167 / _kBoardSize.width
    ..anchorYPercent = 3 / _kBoardSize.height
    ..leftPercent = 0 / _kBoardSize.width
    ..topPercent = -21 / _kBoardSize.height
    ..widthPercent = 333 / _kBoardSize.width
    ..heightPercent = 80 / _kBoardSize.height
    ..position = 1
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
];

final zlagboardPro = Board((b) => b
  ..name = 'Zlagboard - Pro'
  ..id = 'zlagboard_pro'
  ..manufacturer = 'Zlagboard'
  ..model = 'Pro'
  ..imageAssetWidth = _kBoardSize.width
  ..imageAssetHeight = _kBoardSize.height
  ..imageAsset = 'assets/images/boards/zlagboard_pro.png'
  ..handToBoardHeightRatio = 0.9
  ..boardHolds.addAll(_boardHolds)
  ..defaultLeftGripHold = _boardHolds
      .singleWhere((boardHold) => boardHold.position == 15)
      .toBuilder()
  ..defaultRightGripHold = _boardHolds
      .singleWhere((boardHold) => boardHold.position == 21)
      .toBuilder());
