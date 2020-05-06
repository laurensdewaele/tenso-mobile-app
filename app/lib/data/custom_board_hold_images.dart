import 'package:app/models/custom_board_hold_image.dart';
import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;

const int kCustomBoardRows = 4;
const int kCustomBoardColumns = 4;
const double kCustomBoardAspectRatio = 3;
const double kSelectionBoxAspectRatio = 3.6;
const double kCustomBoardSpacingPercent =
    _kCustomBoardSpacing / _measuredCustomBoardWidth;

const double _kCustomBoardSpacing = styles.Measurements.xs;
const double _measuredCustomBoardWidth = 647;

const double _widthPercent1 =
    (1 - (kCustomBoardSpacingPercent * 5)) / kCustomBoardColumns;
const double _widthPercent2 = _widthPercent1 * 2 + kCustomBoardSpacingPercent;
const double _widthPercent3 =
    _widthPercent1 * 3 + (kCustomBoardSpacingPercent * 2);
const double _widthPercent4 =
    _widthPercent1 * 4 + (kCustomBoardSpacingPercent * 3);

const double _leftPercentColumn1 = kCustomBoardSpacingPercent;
const double _leftPercentColumn2 =
    _widthPercent1 + kCustomBoardSpacingPercent * 2;
const double _leftPercentColumn3 =
    _widthPercent2 + kCustomBoardSpacingPercent * 2;
const double _leftPercentColumn4 =
    _widthPercent3 + kCustomBoardSpacingPercent * 2;

const double _bottomRowsTopPercent =
    (_widthPercent1 / kSelectionBoxAspectRatio) + kCustomBoardSpacingPercent;

// TODO: Do i really need to scale?
const double _pinchBlockJugScale = 1.08;
// This is the raw pinchBlock image height and the raw custom board image height.
const double _pinchBlockJugHeightPercent = 267 / 850;
const double _pinchBlockJugTopPercent =
    (_bottomRowsTopPercent - _pinchBlockJugHeightPercent) + 0.0135;
const double _sloperHeightPercent = _bottomRowsTopPercent;

const double _bottomRowsHeightPercent = (1 - _bottomRowsTopPercent);
const double _bottomRowsRowHeightPercent = _bottomRowsHeightPercent / 3;
const double _bottomRowsRowCenterHeightPercent =
    _bottomRowsRowHeightPercent / 2;
const double _topPercentRow2 =
    _bottomRowsTopPercent + _bottomRowsRowCenterHeightPercent;
const double _topPercentRow3 = _topPercentRow2 + _bottomRowsRowHeightPercent;
const double _topPercentRow4 = _topPercentRow3 + _bottomRowsRowHeightPercent;

const double _edgeHeightPercent = 60 / 850;
const double _edgeScale = 1.16;

const double _pocketHeightPercent = 112 / 850;
const double _pocketEdgeDifference =
    (_pocketHeightPercent - (_edgeHeightPercent * _edgeScale));

const Map<int, double> _widthPercents = {
  1: _widthPercent1,
  2: _widthPercent2,
  3: _widthPercent3,
  4: _widthPercent4
};

const Map<int, double> _leftPercents = {
  1: _leftPercentColumn1,
  2: _leftPercentColumn2,
  3: _leftPercentColumn3,
  4: _leftPercentColumn4
};

const Map<int, double> _topPercents = {
  2: _topPercentRow2,
  3: _topPercentRow3,
  4: _topPercentRow4
};

CustomBoardHoldImage getCustomBoardHoldImage(
    {int row, int column, int widthFactor, HoldType type}) {
  CustomBoardHoldImage _image;

  switch (type) {
    case HoldType.pinchBlock:
      _image = CustomBoardHoldImage((b) => b
        ..scale = _pinchBlockJugScale
        ..heightPercent = _pinchBlockJugHeightPercent
        ..widthPercent = _widthPercents[widthFactor]
        ..leftPercent = _leftPercents[column]
        ..topPercent = _pinchBlockJugTopPercent
        ..imageAsset =
            'assets/images/custom_board/pinch_block_$widthFactor.png');
      break;
    case HoldType.jug:
      _image = CustomBoardHoldImage((b) => b
        ..scale = _pinchBlockJugScale
        ..heightPercent = _pinchBlockJugHeightPercent
        ..widthPercent = _widthPercents[widthFactor]
        ..leftPercent = _leftPercents[column]
        ..topPercent = _pinchBlockJugTopPercent
        ..imageAsset = 'assets/images/custom_board/jug_$widthFactor.png');
      break;
    case HoldType.sloper:
      _image = CustomBoardHoldImage((b) => b
        ..scale = 1
        ..heightPercent = _sloperHeightPercent
        ..widthPercent = _widthPercents[widthFactor]
        ..leftPercent = _leftPercents[column]
        ..topPercent = 0
        ..imageAsset = 'assets/images/custom_board/sloper_$widthFactor.png');
      break;
    case HoldType.pocket:
      _image = CustomBoardHoldImage((b) => b
        ..scale = 1
        ..heightPercent = _pocketHeightPercent
        ..widthPercent = _widthPercents[widthFactor]
        ..leftPercent = _leftPercents[column]
        ..topPercent = _topPercents[row] - _pocketEdgeDifference
        ..imageAsset = 'assets/images/custom_board/pocket_$widthFactor.png');
      break;
    case HoldType.edge:
      _image = CustomBoardHoldImage((b) => b
        ..scale = _edgeScale
        ..heightPercent = _edgeHeightPercent
        ..widthPercent = _widthPercents[widthFactor]
        ..leftPercent = _leftPercents[column]
        ..topPercent = _topPercents[row]
        ..imageAsset = 'assets/images/custom_board/edge_$widthFactor.png');
      break;
  }
  return _image;
}
