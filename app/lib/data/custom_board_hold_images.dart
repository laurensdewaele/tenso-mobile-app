import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;

const int kCustomBoardRows = 4;
const int kCustomBoardColumns = 4;
const double kCustomBoardAspectRatio = 3;
const double kSelectionBoxAspectRatio = 3.6;

const double _customBoardPadding = styles.Measurements.xs;
const double _customBoardSpacing = styles.Measurements.xs;
const Size _measuredCustomBoardSize = Size(647, 647 / kCustomBoardAspectRatio);

final double _widthPercent1 = (_measuredCustomBoardSize.width -
        (_customBoardPadding * 2) -
        (_customBoardSpacing * 3)) /
    kCustomBoardColumns;
final double _widthPercent2 = _widthPercent1 * 2 + _customBoardSpacing;
final double _widthPercent3 = _widthPercent1 * 3 + _customBoardSpacing * 2;
final double _widthPercent4 = _widthPercent1 * 4 + _customBoardSpacing * 3;

final Size _selectionBoxSize = Size(
    _widthPercent1 * _measuredCustomBoardSize.width,
    _widthPercent1 * _measuredCustomBoardSize.width / kSelectionBoxAspectRatio);
final double _topRowBottomYPercent =
    (_customBoardPadding + _selectionBoxSize.height) /
        _measuredCustomBoardSize.height;

const double _pinchBlockJugScale = 1.08;
const double _pinchBlockJugHeightPercent = .316;
final double _sloperHeightPercent =
    (_customBoardPadding + _selectionBoxSize.height) /
        _measuredCustomBoardSize.height;

final CustomBoardHoldImage sloper1 = CustomBoardHoldImage((b) => b
  ..widthFactor = 1
  ..type = HoldType.sloper
  ..topYPercent = 0
  ..heightPercent = _sloperHeightPercent
  ..widthPercent = _widthPercent1
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/sloper_1.png');

final CustomBoardHoldImage sloper2 = CustomBoardHoldImage((b) => b
  ..widthFactor = 2
  ..type = HoldType.sloper
  ..topYPercent = 0
  ..heightPercent = _sloperHeightPercent
  ..widthPercent = _widthPercent2
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/sloper_2.png');

final CustomBoardHoldImage sloper3 = CustomBoardHoldImage((b) => b
  ..widthFactor = 3
  ..type = HoldType.sloper
  ..topYPercent = 0
  ..heightPercent = _sloperHeightPercent
  ..widthPercent = _widthPercent3
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/sloper_3.png');

final CustomBoardHoldImage sloper4 = CustomBoardHoldImage((b) => b
  ..widthFactor = 4
  ..type = HoldType.sloper
  ..topYPercent = 0
  ..heightPercent = _sloperHeightPercent
  ..widthPercent = _widthPercent4
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/sloper_4.png');

final CustomBoardHoldImage pinchBlock1 = CustomBoardHoldImage((b) => b
  ..widthFactor = 1
  ..type = HoldType.pinchBlock
  ..topYPercent = _topRowBottomYPercent - _pinchBlockJugHeightPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent1
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/pinch_block_1.png');

final CustomBoardHoldImage pinchBlock2 = CustomBoardHoldImage((b) => b
  ..widthFactor = 2
  ..type = HoldType.pinchBlock
  ..topYPercent = _topRowBottomYPercent - _pinchBlockJugHeightPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent2
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/pinch_block_2.png');

final CustomBoardHoldImage pinchBlock3 = CustomBoardHoldImage((b) => b
  ..widthFactor = 3
  ..type = HoldType.pinchBlock
  ..topYPercent = _topRowBottomYPercent - _pinchBlockJugHeightPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent3
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/pinch_block_3.png');

final CustomBoardHoldImage pinchBlock4 = CustomBoardHoldImage((b) => b
  ..widthFactor = 4
  ..type = HoldType.pinchBlock
  ..topYPercent = _topRowBottomYPercent - _pinchBlockJugHeightPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent4
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/pinch_block_4.png');

final CustomBoardHoldImage jug1 = CustomBoardHoldImage((b) => b
  ..widthFactor = 1
  ..type = HoldType.jug
  ..topYPercent = _topRowBottomYPercent - _pinchBlockJugHeightPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent1
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/jug_1.png');

final CustomBoardHoldImage jug2 = CustomBoardHoldImage((b) => b
  ..widthFactor = 2
  ..type = HoldType.jug
  ..topYPercent = _topRowBottomYPercent - _pinchBlockJugHeightPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent2
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/jug_2.png');

final CustomBoardHoldImage jug3 = CustomBoardHoldImage((b) => b
  ..widthFactor = 3
  ..type = HoldType.jug
  ..topYPercent = _topRowBottomYPercent - _pinchBlockJugHeightPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent3
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/jug_3.png');

final CustomBoardHoldImage jug4 = CustomBoardHoldImage((b) => b
  ..widthFactor = 4
  ..type = HoldType.jug
  ..topYPercent = _topRowBottomYPercent - _pinchBlockJugHeightPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent4
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/jug_4.png');
