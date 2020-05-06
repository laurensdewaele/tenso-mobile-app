import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;

const int kCustomBoardRows = 4;
const int kCustomBoardColumns = 4;
const double kCustomBoardAspectRatio = 3;
const double kSelectionBoxAspectRatio = 3.6;
const double kCustomBoardPadding = styles.Measurements.xs;
const double kCustomBoardSpacing = styles.Measurements.xs;

const Size _measuredCustomBoardSize = Size(647, 647 / kCustomBoardAspectRatio);

final double _widthPercent1 = ((_measuredCustomBoardSize.width -
            (kCustomBoardPadding * 2) -
            (kCustomBoardSpacing * 3)) /
        kCustomBoardColumns) /
    _measuredCustomBoardSize.width;

final double _widthPercent2 =
    _widthPercent1 * 2 + (kCustomBoardSpacing / _measuredCustomBoardSize.width);
final double _widthPercent3 = _widthPercent1 * 3 +
    ((kCustomBoardSpacing * 2) / _measuredCustomBoardSize.width);
final double _widthPercent4 = _widthPercent1 * 4 +
    ((kCustomBoardSpacing * 3)) / _measuredCustomBoardSize.width;

final Size _selectionBoxSize = Size(
    _widthPercent1 * _measuredCustomBoardSize.width,
    _widthPercent1 * _measuredCustomBoardSize.width / kSelectionBoxAspectRatio);
final double _topRowBottomYPercent =
    (kCustomBoardPadding + _selectionBoxSize.height) /
        _measuredCustomBoardSize.height;

const double _pinchBlockJugScale = 1.08;
// This is the raw pinchBlock image height and the raw custom board image height.
// Not accounted for added shadows by Figma.
const double _pinchBlockJugHeightPercent = 267 / 850;
final double _pinchBlockJugTopYPercent =
    (_topRowBottomYPercent - _pinchBlockJugHeightPercent) + 0.0135;
final double _sloperHeightPercent =
    (kCustomBoardPadding + _selectionBoxSize.height) /
        _measuredCustomBoardSize.height;

final double _x1Percent =
    (kCustomBoardPadding / _measuredCustomBoardSize.width);
final double _x2Percent =
    ((kCustomBoardPadding + _selectionBoxSize.width + kCustomBoardSpacing) /
        _measuredCustomBoardSize.width);
final double _x3Percent = ((kCustomBoardPadding +
        _selectionBoxSize.width * 2 +
        kCustomBoardSpacing * 2) /
    _measuredCustomBoardSize.width);
final double _x4Percent = ((_measuredCustomBoardSize.width -
        kCustomBoardPadding -
        _selectionBoxSize.width) /
    _measuredCustomBoardSize.width);
final List<double> _leftXPercent = [
  _x1Percent,
  _x2Percent,
  _x3Percent,
  _x4Percent,
];

final CustomBoardHoldImage sloper1 = CustomBoardHoldImage((b) => b
  ..widthFactor = 1
  ..type = HoldType.sloper
  ..topYPercent = [0, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _sloperHeightPercent
  ..widthPercent = _widthPercent1
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/sloper_1.png');

final CustomBoardHoldImage sloper2 = CustomBoardHoldImage((b) => b
  ..widthFactor = 2
  ..type = HoldType.sloper
  ..topYPercent = [0, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _sloperHeightPercent
  ..widthPercent = _widthPercent2
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/sloper_2.png');

final CustomBoardHoldImage sloper3 = CustomBoardHoldImage((b) => b
  ..widthFactor = 3
  ..type = HoldType.sloper
  ..topYPercent = [0, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _sloperHeightPercent
  ..widthPercent = _widthPercent3
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/sloper_3.png');

final CustomBoardHoldImage sloper4 = CustomBoardHoldImage((b) => b
  ..widthFactor = 4
  ..type = HoldType.sloper
  ..topYPercent = [0, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _sloperHeightPercent
  ..widthPercent = _widthPercent4
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/sloper_4.png');

final CustomBoardHoldImage pinchBlock1 = CustomBoardHoldImage((b) => b
  ..widthFactor = 1
  ..type = HoldType.pinchBlock
  ..topYPercent = [_pinchBlockJugTopYPercent, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent1
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/pinch_block_1.png');

final CustomBoardHoldImage pinchBlock2 = CustomBoardHoldImage((b) => b
  ..widthFactor = 2
  ..type = HoldType.pinchBlock
  ..topYPercent = [_pinchBlockJugTopYPercent, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent2
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/pinch_block_2.png');

final CustomBoardHoldImage pinchBlock3 = CustomBoardHoldImage((b) => b
  ..widthFactor = 3
  ..type = HoldType.pinchBlock
  ..topYPercent = [_pinchBlockJugTopYPercent, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent3
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/pinch_block_3.png');

final CustomBoardHoldImage pinchBlock4 = CustomBoardHoldImage((b) => b
  ..widthFactor = 4
  ..type = HoldType.pinchBlock
  ..topYPercent = [_pinchBlockJugTopYPercent, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent4
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/pinch_block_4.png');

final CustomBoardHoldImage jug1 = CustomBoardHoldImage((b) => b
  ..widthFactor = 1
  ..type = HoldType.jug
  ..topYPercent = [_pinchBlockJugTopYPercent, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent1
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/jug_1.png');

final CustomBoardHoldImage jug2 = CustomBoardHoldImage((b) => b
  ..widthFactor = 2
  ..type = HoldType.jug
  ..topYPercent = [_pinchBlockJugTopYPercent, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent2
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/jug_2.png');

final CustomBoardHoldImage jug3 = CustomBoardHoldImage((b) => b
  ..widthFactor = 3
  ..type = HoldType.jug
  ..topYPercent = [_pinchBlockJugTopYPercent, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent3
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/jug_3.png');

final CustomBoardHoldImage jug4 = CustomBoardHoldImage((b) => b
  ..widthFactor = 4
  ..type = HoldType.jug
  ..topYPercent = [_pinchBlockJugTopYPercent, null, null, null]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pinchBlockJugHeightPercent
  ..widthPercent = _widthPercent4
  ..scale = _pinchBlockJugScale
  ..imageAsset = 'assets/images/custom_board/jug_4.png');

final double _bottomRowHeightPercent = (1 - _topRowBottomYPercent);
final double _bottomRowSectionHeightPercent = _bottomRowHeightPercent / 3;
final double _bottomRowSectionCenterHeightPercent =
    _bottomRowSectionHeightPercent / 2;
final double _bottomRowTopY1Percent =
    _topRowBottomYPercent + _bottomRowSectionCenterHeightPercent;
final double _bottomRowTopY2Percent =
    _bottomRowTopY1Percent + _bottomRowSectionHeightPercent;
final double _bottomRowTopY3Percent =
    _bottomRowTopY2Percent + _bottomRowSectionHeightPercent;

final double _edgeHeightPercent = 60 / 850;
final double _edgeScale = 1.16;

final CustomBoardHoldImage edge1 = CustomBoardHoldImage((b) => b
  ..widthFactor = 1
  ..type = HoldType.edge
  ..topYPercent = [
    null,
    _bottomRowTopY1Percent,
    _bottomRowTopY2Percent,
    _bottomRowTopY3Percent
  ]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _edgeHeightPercent
  ..widthPercent = _widthPercent1
  ..scale = _edgeScale
  ..imageAsset = 'assets/images/custom_board/edge_1.png');

final CustomBoardHoldImage edge2 = CustomBoardHoldImage((b) => b
  ..widthFactor = 2
  ..type = HoldType.edge
  ..topYPercent = [
    null,
    _bottomRowTopY1Percent,
    _bottomRowTopY2Percent,
    _bottomRowTopY3Percent
  ]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _edgeHeightPercent
  ..widthPercent = _widthPercent2
  ..scale = _edgeScale
  ..imageAsset = 'assets/images/custom_board/edge_2.png');

final CustomBoardHoldImage edge3 = CustomBoardHoldImage((b) => b
  ..widthFactor = 3
  ..type = HoldType.edge
  ..topYPercent = [
    null,
    _bottomRowTopY1Percent,
    _bottomRowTopY2Percent,
    _bottomRowTopY3Percent
  ]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _edgeHeightPercent
  ..widthPercent = _widthPercent3
  ..scale = _edgeScale
  ..imageAsset = 'assets/images/custom_board/edge_3.png');

final CustomBoardHoldImage edge4 = CustomBoardHoldImage((b) => b
  ..widthFactor = 4
  ..type = HoldType.edge
  ..topYPercent = [
    null,
    _bottomRowTopY1Percent,
    _bottomRowTopY2Percent,
    _bottomRowTopY3Percent
  ]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _edgeHeightPercent
  ..widthPercent = _widthPercent4
  ..scale = _edgeScale
  ..imageAsset = 'assets/images/custom_board/edge_4.png');

final _pocketHeightPercent = 112 / 850;
final _pocketEdgeDifference =
    (_pocketHeightPercent - (_edgeHeightPercent * _edgeScale));

final CustomBoardHoldImage pocket1 = CustomBoardHoldImage((b) => b
  ..widthFactor = 1
  ..type = HoldType.pocket
  ..topYPercent = [
    null,
    _bottomRowTopY1Percent - _pocketEdgeDifference,
    _bottomRowTopY2Percent - _pocketEdgeDifference,
    _bottomRowTopY3Percent - _pocketEdgeDifference
  ]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pocketHeightPercent
  ..widthPercent = _widthPercent1
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/pocket_1.png');

final CustomBoardHoldImage pocket2 = CustomBoardHoldImage((b) => b
  ..widthFactor = 2
  ..type = HoldType.pocket
  ..topYPercent = [
    null,
    _bottomRowTopY1Percent - _pocketEdgeDifference,
    _bottomRowTopY2Percent - _pocketEdgeDifference,
    _bottomRowTopY3Percent - _pocketEdgeDifference
  ]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pocketHeightPercent
  ..widthPercent = _widthPercent2
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/pocket_2.png');

final CustomBoardHoldImage pocket3 = CustomBoardHoldImage((b) => b
  ..widthFactor = 3
  ..type = HoldType.pocket
  ..topYPercent = [
    null,
    _bottomRowTopY1Percent - _pocketEdgeDifference,
    _bottomRowTopY2Percent - _pocketEdgeDifference,
    _bottomRowTopY3Percent - _pocketEdgeDifference
  ]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pocketHeightPercent
  ..widthPercent = _widthPercent3
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/pocket_3.png');

final CustomBoardHoldImage pocket4 = CustomBoardHoldImage((b) => b
  ..widthFactor = 4
  ..type = HoldType.pocket
  ..topYPercent = [
    null,
    _bottomRowTopY1Percent - _pocketEdgeDifference,
    _bottomRowTopY2Percent - _pocketEdgeDifference,
    _bottomRowTopY3Percent - _pocketEdgeDifference
  ]
  ..leftXPercent = _leftXPercent
  ..heightPercent = _pocketHeightPercent
  ..widthPercent = _widthPercent4
  ..scale = 1
  ..imageAsset = 'assets/images/custom_board/pocket_4.png');
