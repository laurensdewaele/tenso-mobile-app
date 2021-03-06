import 'dart:ui';

import 'package:tenso_app/models/models.dart';

const Size _kBoardSize = const Size(1026, 374);

final List<BoardHold> _boardHolds = [
  BoardHold((b) => b
    ..anchorXPercent = 63 / _kBoardSize.width
    ..anchorYPercent = 90 / _kBoardSize.height
    ..leftPercent = 0 / _kBoardSize.width
    ..topPercent = 64 / _kBoardSize.height
    ..widthPercent = 122 / _kBoardSize.width
    ..heightPercent = 54 / _kBoardSize.height
    ..position = 1
    ..holdType = HoldType.jug
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 214 / _kBoardSize.width
    ..anchorYPercent = 107 / _kBoardSize.height
    ..leftPercent = 120 / _kBoardSize.width
    ..topPercent = 51 / _kBoardSize.height
    ..widthPercent = 164 / _kBoardSize.width
    ..heightPercent = 90 / _kBoardSize.height
    ..position = 2
    ..holdType = HoldType.sloper
    ..sloperDegrees = 45),
  BoardHold((b) => b
    ..anchorXPercent = 367 / _kBoardSize.width
    ..anchorYPercent = 78 / _kBoardSize.height
    ..leftPercent = 284 / _kBoardSize.width
    ..topPercent = 29 / _kBoardSize.height
    ..widthPercent = 155 / _kBoardSize.width
    ..heightPercent = 89 / _kBoardSize.height
    ..position = 3
    ..holdType = HoldType.sloper
    ..sloperDegrees = 30),
  BoardHold((b) => b
    ..anchorXPercent = 515 / _kBoardSize.width
    ..anchorYPercent = 4 / _kBoardSize.height
    ..leftPercent = 439 / _kBoardSize.width
    ..topPercent = 2 / _kBoardSize.height
    ..widthPercent = 149 / _kBoardSize.width
    ..heightPercent = 67 / _kBoardSize.height
    ..position = 4
    ..holdType = HoldType.jug),
  BoardHold((b) => b
    ..anchorXPercent = 662 / _kBoardSize.width
    ..anchorYPercent = 78 / _kBoardSize.height
    ..leftPercent = 588 / _kBoardSize.width
    ..topPercent = 29 / _kBoardSize.height
    ..widthPercent = 145 / _kBoardSize.width
    ..heightPercent = 89 / _kBoardSize.height
    ..position = 5
    ..holdType = HoldType.sloper
    ..sloperDegrees = 30),
  BoardHold((b) => b
    ..anchorXPercent = 810 / _kBoardSize.width
    ..anchorYPercent = 108 / _kBoardSize.height
    ..leftPercent = 733 / _kBoardSize.width
    ..topPercent = 46 / _kBoardSize.height
    ..widthPercent = 164 / _kBoardSize.width
    ..heightPercent = 90 / _kBoardSize.height
    ..position = 6
    ..holdType = HoldType.sloper
    ..sloperDegrees = 45),
  BoardHold((b) => b
    ..anchorXPercent = 953 / _kBoardSize.width
    ..anchorYPercent = 93 / _kBoardSize.height
    ..leftPercent = 897 / _kBoardSize.width
    ..topPercent = 69 / _kBoardSize.height
    ..widthPercent = 129 / _kBoardSize.width
    ..heightPercent = 63 / _kBoardSize.height
    ..position = 7
    ..holdType = HoldType.jug),
  BoardHold((b) => b
    ..anchorXPercent = 73 / _kBoardSize.width
    ..anchorYPercent = 169 / _kBoardSize.height
    ..leftPercent = 0 / _kBoardSize.width
    ..topPercent = 118 / _kBoardSize.height
    ..widthPercent = 122 / _kBoardSize.width
    ..heightPercent = 57 / _kBoardSize.height
    ..position = 8
    ..holdType = HoldType.pocket
    ..depth = 30
    ..supportedFingers = 3),
  BoardHold((b) => b
    ..anchorXPercent = 517 / _kBoardSize.width
    ..anchorYPercent = 115 / _kBoardSize.height
    ..leftPercent = 439 / _kBoardSize.width
    ..topPercent = 69 / _kBoardSize.height
    ..widthPercent = 144 / _kBoardSize.width
    ..heightPercent = 54 / _kBoardSize.height
    ..position = 9
    ..holdType = HoldType.pocket
    ..depth = 50
    ..supportedFingers = 3),
  BoardHold((b) => b
    ..anchorXPercent = 952 / _kBoardSize.width
    ..anchorYPercent = 176 / _kBoardSize.height
    ..leftPercent = 904 / _kBoardSize.width
    ..topPercent = 130 / _kBoardSize.height
    ..widthPercent = 122 / _kBoardSize.width
    ..heightPercent = 52 / _kBoardSize.height
    ..position = 10
    ..holdType = HoldType.pocket
    ..depth = 30
    ..supportedFingers = 3),
  BoardHold((b) => b
    ..anchorXPercent = 126 / _kBoardSize.width
    ..anchorYPercent = 224 / _kBoardSize.height
    ..leftPercent = 42 / _kBoardSize.width
    ..topPercent = 175 / _kBoardSize.height
    ..widthPercent = 146 / _kBoardSize.width
    ..heightPercent = 65 / _kBoardSize.height
    ..position = 11
    ..holdType = HoldType.pocket
    ..depth = 25
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 257 / _kBoardSize.width
    ..anchorYPercent = 196 / _kBoardSize.height
    ..leftPercent = 188 / _kBoardSize.width
    ..topPercent = 147 / _kBoardSize.height
    ..widthPercent = 125 / _kBoardSize.width
    ..heightPercent = 65 / _kBoardSize.height
    ..position = 12
    ..holdType = HoldType.pocket
    ..depth = 19
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 381 / _kBoardSize.width
    ..anchorYPercent = 183 / _kBoardSize.height
    ..leftPercent = 313 / _kBoardSize.width
    ..topPercent = 132 / _kBoardSize.height
    ..widthPercent = 131 / _kBoardSize.width
    ..heightPercent = 65 / _kBoardSize.height
    ..position = 13
    ..holdType = HoldType.pocket
    ..depth = 36
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 515 / _kBoardSize.width
    ..anchorYPercent = 186 / _kBoardSize.height
    ..leftPercent = 444 / _kBoardSize.width
    ..topPercent = 143 / _kBoardSize.height
    ..widthPercent = 134 / _kBoardSize.width
    ..heightPercent = 54 / _kBoardSize.height
    ..position = 14
    ..holdType = HoldType.pocket
    ..depth = 37
    ..supportedFingers = 3),
  BoardHold((b) => b
    ..anchorXPercent = 653 / _kBoardSize.width
    ..anchorYPercent = 186 / _kBoardSize.height
    ..leftPercent = 588 / _kBoardSize.width
    ..topPercent = 132 / _kBoardSize.height
    ..widthPercent = 127 / _kBoardSize.width
    ..heightPercent = 70 / _kBoardSize.height
    ..position = 15
    ..holdType = HoldType.pocket
    ..depth = 36
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 772 / _kBoardSize.width
    ..anchorYPercent = 200 / _kBoardSize.height
    ..leftPercent = 715 / _kBoardSize.width
    ..topPercent = 149 / _kBoardSize.height
    ..widthPercent = 117 / _kBoardSize.width
    ..heightPercent = 65 / _kBoardSize.height
    ..position = 16
    ..holdType = HoldType.pocket
    ..depth = 19
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 899 / _kBoardSize.width
    ..anchorYPercent = 228 / _kBoardSize.height
    ..leftPercent = 832 / _kBoardSize.width
    ..topPercent = 182 / _kBoardSize.height
    ..widthPercent = 159 / _kBoardSize.width
    ..heightPercent = 61 / _kBoardSize.height
    ..position = 17
    ..holdType = HoldType.pocket
    ..depth = 25
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 160 / _kBoardSize.width
    ..anchorYPercent = 277 / _kBoardSize.height
    ..leftPercent = 65 / _kBoardSize.width
    ..topPercent = 240 / _kBoardSize.height
    ..widthPercent = 146 / _kBoardSize.width
    ..heightPercent = 48 / _kBoardSize.height
    ..position = 18
    ..holdType = HoldType.pocket
    ..depth = 15
    ..supportedFingers = 3),
  BoardHold((b) => b
    ..anchorXPercent = 280 / _kBoardSize.width
    ..anchorYPercent = 258 / _kBoardSize.height
    ..leftPercent = 211 / _kBoardSize.width
    ..topPercent = 218 / _kBoardSize.height
    ..widthPercent = 114 / _kBoardSize.width
    ..heightPercent = 48 / _kBoardSize.height
    ..position = 19
    ..holdType = HoldType.pocket
    ..depth = 35
    ..supportedFingers = 3),
  BoardHold((b) => b
    ..anchorXPercent = 393 / _kBoardSize.width
    ..anchorYPercent = 244 / _kBoardSize.height
    ..leftPercent = 325 / _kBoardSize.width
    ..topPercent = 208 / _kBoardSize.height
    ..widthPercent = 125 / _kBoardSize.width
    ..heightPercent = 48 / _kBoardSize.height
    ..position = 20
    ..holdType = HoldType.pocket
    ..depth = 17
    ..supportedFingers = 3),
  BoardHold((b) => b
    ..anchorXPercent = 516 / _kBoardSize.width
    ..anchorYPercent = 252 / _kBoardSize.height
    ..leftPercent = 450 / _kBoardSize.width
    ..topPercent = 208 / _kBoardSize.height
    ..widthPercent = 133 / _kBoardSize.width
    ..heightPercent = 52 / _kBoardSize.height
    ..position = 21
    ..holdType = HoldType.pocket
    ..depth = 28
    ..supportedFingers = 2),
  BoardHold((b) => b
    ..anchorXPercent = 636 / _kBoardSize.width
    ..anchorYPercent = 247 / _kBoardSize.height
    ..leftPercent = 583 / _kBoardSize.width
    ..topPercent = 208 / _kBoardSize.height
    ..widthPercent = 111 / _kBoardSize.width
    ..heightPercent = 56 / _kBoardSize.height
    ..position = 22
    ..holdType = HoldType.pocket
    ..depth = 17
    ..supportedFingers = 3),
  BoardHold((b) => b
    ..anchorXPercent = 748 / _kBoardSize.width
    ..anchorYPercent = 262 / _kBoardSize.height
    ..leftPercent = 694 / _kBoardSize.width
    ..topPercent = 223 / _kBoardSize.height
    ..widthPercent = 109 / _kBoardSize.width
    ..heightPercent = 56 / _kBoardSize.height
    ..position = 23
    ..holdType = HoldType.pocket
    ..depth = 35
    ..supportedFingers = 3),
  BoardHold((b) => b
    ..anchorXPercent = 863 / _kBoardSize.width
    ..anchorYPercent = 283 / _kBoardSize.height
    ..leftPercent = 803 / _kBoardSize.width
    ..topPercent = 242 / _kBoardSize.height
    ..widthPercent = 114 / _kBoardSize.width
    ..heightPercent = 53 / _kBoardSize.height
    ..position = 24
    ..holdType = HoldType.pocket
    ..depth = 15
    ..supportedFingers = 3),
  BoardHold((b) => b
    ..anchorXPercent = 230 / _kBoardSize.width
    ..anchorYPercent = 328 / _kBoardSize.height
    ..leftPercent = 131 / _kBoardSize.width
    ..topPercent = 288 / _kBoardSize.height
    ..widthPercent = 163 / _kBoardSize.width
    ..heightPercent = 59 / _kBoardSize.height
    ..position = 25
    ..holdType = HoldType.pocket
    ..depth = 14
    ..supportedFingers = 5),
  BoardHold((b) => b
    ..anchorXPercent = 344 / _kBoardSize.width
    ..anchorYPercent = 310 / _kBoardSize.height
    ..leftPercent = 294 / _kBoardSize.width
    ..topPercent = 270 / _kBoardSize.height
    ..widthPercent = 81 / _kBoardSize.width
    ..heightPercent = 59 / _kBoardSize.height
    ..position = 26
    ..holdType = HoldType.pocket
    ..depth = 30
    ..supportedFingers = 2),
  BoardHold((b) => b
    ..anchorXPercent = 422 / _kBoardSize.width
    ..anchorYPercent = 300 / _kBoardSize.height
    ..leftPercent = 375 / _kBoardSize.width
    ..topPercent = 261 / _kBoardSize.height
    ..widthPercent = 82 / _kBoardSize.width
    ..heightPercent = 59 / _kBoardSize.height
    ..position = 27
    ..holdType = HoldType.pocket
    ..depth = 14
    ..supportedFingers = 2),
  BoardHold((b) => b
    ..anchorXPercent = 514 / _kBoardSize.width
    ..anchorYPercent = 313 / _kBoardSize.height
    ..leftPercent = 457 / _kBoardSize.width
    ..topPercent = 273 / _kBoardSize.height
    ..widthPercent = 113 / _kBoardSize.width
    ..heightPercent = 54 / _kBoardSize.height
    ..position = 28
    ..holdType = HoldType.pocket
    ..depth = 32
    ..supportedFingers = 2),
  BoardHold((b) => b
    ..anchorXPercent = 607 / _kBoardSize.width
    ..anchorYPercent = 302 / _kBoardSize.height
    ..leftPercent = 568 / _kBoardSize.width
    ..topPercent = 264 / _kBoardSize.height
    ..widthPercent = 81 / _kBoardSize.width
    ..heightPercent = 51 / _kBoardSize.height
    ..position = 29
    ..holdType = HoldType.pocket
    ..depth = 14
    ..supportedFingers = 2),
  BoardHold((b) => b
    ..anchorXPercent = 686 / _kBoardSize.width
    ..anchorYPercent = 312 / _kBoardSize.height
    ..leftPercent = 649 / _kBoardSize.width
    ..topPercent = 278 / _kBoardSize.height
    ..widthPercent = 84 / _kBoardSize.width
    ..heightPercent = 49 / _kBoardSize.height
    ..position = 30
    ..holdType = HoldType.pocket
    ..depth = 30
    ..supportedFingers = 2),
  BoardHold((b) => b
    ..anchorXPercent = 799 / _kBoardSize.width
    ..anchorYPercent = 333 / _kBoardSize.height
    ..leftPercent = 733 / _kBoardSize.width
    ..topPercent = 295 / _kBoardSize.height
    ..widthPercent = 138 / _kBoardSize.width
    ..heightPercent = 55 / _kBoardSize.height
    ..position = 31
    ..holdType = HoldType.pocket
    ..depth = 14
    ..supportedFingers = 5),
];

final metoliusSimulator3D = Board((b) => b
  ..name = 'Metolius - Simulator 3D'
  ..id = 'metolius_simulator_3D'
  ..manufacturer = 'Metolius'
  ..model = 'Simulator 3D'
  ..imageAssetWidth = _kBoardSize.width
  ..imageAssetHeight = _kBoardSize.height
  ..imageAsset = 'assets/images/boards/metolius_simulator_3D.png'
  ..handToBoardHeightRatio = .7
  ..boardHolds.addAll(_boardHolds)
  ..defaultLeftGripHold = _boardHolds
      .singleWhere((boardHold) => boardHold.position == 11)
      .toBuilder()
  ..defaultRightGripHold = _boardHolds
      .singleWhere((boardHold) => boardHold.position == 17)
      .toBuilder());
