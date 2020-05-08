import 'package:app/models/custom_board_hold_image.dart';
import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/foundation.dart';

const int kRows = 4;
const int kColumns = 4;
const double kAspectRatio = 3;
const String kImageAsset = 'assets/images/custom_board/custom_board.png';
const double kSelectionBoxAspectRatio = 3.6;
const double kHorizontalSpacingPercent = _kSpacing / _measuredWidth;
const double kVerticalSpacingPercent = _kSpacing / _measuredHeight;

const double _kSpacing = styles.Measurements.xs;
const double _measuredWidth = 647;
const double _measuredHeight = _measuredWidth / kAspectRatio;

const double _widthPercent1 = (1 - (kHorizontalSpacingPercent * 5)) / kColumns;
const double _widthPercent2 = _widthPercent1 * 2 + kHorizontalSpacingPercent;
const double _widthPercent3 =
    _widthPercent1 * 3 + (kHorizontalSpacingPercent * 2);
const double _widthPercent4 =
    _widthPercent1 * 4 + (kHorizontalSpacingPercent * 3);

const double _leftPercentColumn1 = kHorizontalSpacingPercent;
const double _leftPercentColumn2 =
    _widthPercent1 + kHorizontalSpacingPercent * 2;
const double _leftPercentColumn3 =
    _widthPercent2 + kHorizontalSpacingPercent * 2;
const double _leftPercentColumn4 =
    _widthPercent3 + kHorizontalSpacingPercent * 2;

const double _bottomRowsTopPercent = (kVerticalSpacingPercent) +
    ((_widthPercent1 * _measuredWidth / kSelectionBoxAspectRatio) /
        _measuredHeight);

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

const double _onePixelHeightPercent = 0.005;
const double _onePixelWidthPercent = 0.002;

class CustomBoardHoldsAndImage {
  final List<BoardHold> boardHolds;
  final CustomBoardHoldImage image;

  const CustomBoardHoldsAndImage({
    @required this.boardHolds,
    @required this.image,
  });
}

class CustomBoardBuilder {
  CustomBoardBuilder() {
//    _board = Board((b) => b
//      ..id = Uuid().v4()
//      ..custom = true
//      ..model = ''
//      ..imageAsset = 'assets/images/custom_board/custom_board.png'
//      ..aspectRatio = 3
//      ..width = 2555
//      ..height = 850
//      ..handToBoardHeightRatio = 1.2
//      ..boardHolds = null
//      ..customBoardHoldImages = null
//      ..defaultLeftGripHold = null
//      ..defaultRightGripHold = null);
  }
  int _position = 1;
  Board _board;
  List<CustomBoardHoldImage> _images = [];
  List<CustomBoardHoldImage> get images => _images;
  List<BoardHold> _boardHolds = [];
  List<BoardHold> get boardHolds => _boardHolds;

  void addBoardHoldAndImage({
    @required int row,
    @required int column,
    @required int widthFactor,
    @required HoldType type,
    double sloperDegrees,
    double depth,
    int supportedFingers,
  }) {
    String _id = '${type.toString()}-w:$widthFactor-r:$row-c:$column';

    switch (type) {
      case HoldType.pinchBlock:
        _images.add(CustomBoardHoldImage((b) => b
          ..id = _id
          ..scale = _pinchBlockJugScale
          ..heightPercent = _pinchBlockJugHeightPercent
          ..widthPercent = _widthPercents[widthFactor]
          ..leftPercent = _leftPercents[column]
          ..topPercent = _pinchBlockJugTopPercent
          ..imageAsset =
              'assets/images/custom_board/pinch_block_$widthFactor.png'));
        List.generate(widthFactor, (i) {
          double _topLeftBorderRadius;
          double _topRightBorderRadius;
          double _bottomRightBorderRadius;
          double _bottomLeftBorderRadius;

          if (widthFactor == 1) {
            _topLeftBorderRadius = 5;
            _topRightBorderRadius = 5;
            _bottomRightBorderRadius = 5;
            _bottomLeftBorderRadius = 5;
          }

          if (widthFactor > 1) {
            if (i == 0) {
              _topLeftBorderRadius = 5;
              _topRightBorderRadius = 0;
              _bottomRightBorderRadius = 0;
              _bottomLeftBorderRadius = 5;
            } else if (i == widthFactor - 1) {
              _topLeftBorderRadius = 0;
              _topRightBorderRadius = 5;
              _bottomRightBorderRadius = 5;
              _bottomLeftBorderRadius = 0;
            } else {
              _topLeftBorderRadius = 0;
              _topRightBorderRadius = 0;
              _bottomRightBorderRadius = 0;
              _bottomLeftBorderRadius = 0;
            }
          }
          _boardHolds.add(BoardHold((b) => b
            ..borderRadiusAll = false
            ..topLeftBorderRadius = _topLeftBorderRadius
            ..topRightBorderRadius = _topRightBorderRadius
            ..bottomRightBorderRadius = _bottomRightBorderRadius
            ..bottomLeftBorderRadius = _bottomLeftBorderRadius
            ..customBoardHoldImageId = _id
            ..type = HoldType.pinchBlock
            ..topPercent = _pinchBlockJugTopPercent - _onePixelHeightPercent * 2
            ..leftPercent = _leftPercents[column + i] - _onePixelWidthPercent
            ..widthPercent = _widthPercents[1] + _onePixelWidthPercent * 2
            ..heightPercent =
                _pinchBlockJugHeightPercent + _onePixelHeightPercent
            ..position = _position
            ..anchorLeftPercent =
                _leftPercents[column + i] + _widthPercents[1] / 2
            ..anchorTopPercent =
                _pinchBlockJugTopPercent - _pinchBlockJugHeightPercent));

          _position++;
        });
        break;
      case HoldType.jug:
        _images.add(CustomBoardHoldImage((b) => b
          ..id = _id
          ..scale = _pinchBlockJugScale
          ..heightPercent = _pinchBlockJugHeightPercent
          ..widthPercent = _widthPercents[widthFactor]
          ..leftPercent = _leftPercents[column]
          ..topPercent = _pinchBlockJugTopPercent
          ..imageAsset = 'assets/images/custom_board/jug_$widthFactor.png'));
        List.generate(widthFactor, (i) {
          double _topLeftBorderRadius;
          double _topRightBorderRadius;
          double _bottomRightBorderRadius;
          double _bottomLeftBorderRadius;

          if (widthFactor == 1) {
            _topLeftBorderRadius = 25;
            _topRightBorderRadius = 25;
            _bottomRightBorderRadius = 5;
            _bottomLeftBorderRadius = 5;
          }

          if (widthFactor > 1) {
            if (i == 0) {
              _topLeftBorderRadius = 25;
              _topRightBorderRadius = 0;
              _bottomRightBorderRadius = 0;
              _bottomLeftBorderRadius = 5;
            } else if (i == widthFactor - 1) {
              _topLeftBorderRadius = 0;
              _topRightBorderRadius = 25;
              _bottomRightBorderRadius = 5;
              _bottomLeftBorderRadius = 0;
            } else {
              _topLeftBorderRadius = 0;
              _topRightBorderRadius = 0;
              _bottomRightBorderRadius = 0;
              _bottomLeftBorderRadius = 0;
            }
          }

          _boardHolds.add(BoardHold((b) => b
            ..borderRadiusAll = false
            ..topLeftBorderRadius = _topLeftBorderRadius
            ..topRightBorderRadius = _topRightBorderRadius
            ..bottomRightBorderRadius = _bottomRightBorderRadius
            ..bottomLeftBorderRadius = _bottomLeftBorderRadius
            ..type = HoldType.jug
            ..topPercent = _pinchBlockJugTopPercent - _onePixelHeightPercent * 2
            ..leftPercent = _leftPercents[column + i] - _onePixelWidthPercent
            ..widthPercent = _widthPercents[1] + _onePixelWidthPercent * 2
            ..heightPercent =
                _pinchBlockJugHeightPercent + _onePixelHeightPercent
            ..position = _position
            ..anchorLeftPercent =
                _leftPercents[column + i] + _widthPercents[1] / 2
            ..anchorTopPercent =
                _pinchBlockJugTopPercent - _pinchBlockJugHeightPercent));

          _position++;
        });
        break;
      case HoldType.sloper:
        _images.add(CustomBoardHoldImage((b) => b
          ..id = _id
          ..scale = 1
          ..heightPercent = _sloperHeightPercent
          ..widthPercent = _widthPercents[widthFactor]
          ..leftPercent = _leftPercents[column]
          ..topPercent = 0
          ..imageAsset = 'assets/images/custom_board/sloper_$widthFactor.png'));
        List.generate(widthFactor, (i) {
          double _topLeftBorderRadius;
          double _topRightBorderRadius;
          double _bottomRightBorderRadius;
          double _bottomLeftBorderRadius;

          if (widthFactor == 1) {
            _topLeftBorderRadius = 0;
            _topRightBorderRadius = 0;
            _bottomRightBorderRadius = 5;
            _bottomLeftBorderRadius = 5;
          }

          if (widthFactor > 1) {
            if (i == 0) {
              _topLeftBorderRadius = 0;
              _topRightBorderRadius = 0;
              _bottomRightBorderRadius = 0;
              _bottomLeftBorderRadius = 5;
            } else if (i == widthFactor - 1) {
              _topLeftBorderRadius = 0;
              _topRightBorderRadius = 0;
              _bottomRightBorderRadius = 5;
              _bottomLeftBorderRadius = 0;
            } else {
              _topLeftBorderRadius = 0;
              _topRightBorderRadius = 0;
              _bottomRightBorderRadius = 0;
              _bottomLeftBorderRadius = 0;
            }
          }

          _boardHolds.add(BoardHold((b) => b
            ..borderRadiusAll = false
            ..topLeftBorderRadius = _topLeftBorderRadius
            ..topRightBorderRadius = _topRightBorderRadius
            ..bottomRightBorderRadius = _bottomRightBorderRadius
            ..bottomLeftBorderRadius = _bottomLeftBorderRadius
            ..type = HoldType.sloper
            ..topPercent = 0 - _onePixelHeightPercent
            ..leftPercent = _leftPercents[column + i] - _onePixelWidthPercent
            ..widthPercent = _widthPercents[1] + _onePixelWidthPercent * 2
            ..heightPercent = _sloperHeightPercent + _onePixelHeightPercent * 2
            ..sloperDegrees = sloperDegrees
            ..position = _position
            ..anchorLeftPercent =
                _leftPercents[column + i] + _widthPercents[1] / 2
            ..anchorTopPercent = 0));

          _position++;
        });
        break;
      case HoldType.pocket:
        _images.add(CustomBoardHoldImage((b) => b
          ..id = _id
          ..scale = 1
          ..heightPercent = _pocketHeightPercent
          ..widthPercent = _widthPercents[widthFactor]
          ..leftPercent = _leftPercents[column]
          ..topPercent = _topPercents[row] - _pocketEdgeDifference
          ..imageAsset = 'assets/images/custom_board/pocket_$widthFactor.png'));
        List.generate(widthFactor, (i) {
          double _topLeftBorderRadius;
          double _topRightBorderRadius;
          double _bottomRightBorderRadius;
          double _bottomLeftBorderRadius;

          if (widthFactor == 1) {
            _topLeftBorderRadius = 25;
            _topRightBorderRadius = 25;
            _bottomRightBorderRadius = 25;
            _bottomLeftBorderRadius = 25;
          }

          if (widthFactor > 1) {
            if (i == 0) {
              _topLeftBorderRadius = 25;
              _topRightBorderRadius = 0;
              _bottomRightBorderRadius = 0;
              _bottomLeftBorderRadius = 25;
            } else if (i == widthFactor - 1) {
              _topLeftBorderRadius = 0;
              _topRightBorderRadius = 25;
              _bottomRightBorderRadius = 25;
              _bottomLeftBorderRadius = 0;
            } else {
              _topLeftBorderRadius = 0;
              _topRightBorderRadius = 0;
              _bottomRightBorderRadius = 0;
              _bottomLeftBorderRadius = 0;
            }
          }

          _boardHolds.add(BoardHold((b) => b
            ..borderRadiusAll = false
            ..topLeftBorderRadius = _topLeftBorderRadius
            ..topRightBorderRadius = _topRightBorderRadius
            ..bottomRightBorderRadius = _bottomRightBorderRadius
            ..bottomLeftBorderRadius = _bottomLeftBorderRadius
            ..type = HoldType.pocket
            ..topPercent = _topPercents[row] -
                _pocketEdgeDifference -
                _onePixelHeightPercent
            ..leftPercent = _leftPercents[column + i] - _onePixelWidthPercent
            ..widthPercent = _widthPercents[1] + _onePixelWidthPercent * 2
            ..heightPercent = _pocketHeightPercent + _onePixelHeightPercent * 2
            ..depth = depth
            ..supportedFingers = supportedFingers
            ..position = _position
            ..anchorLeftPercent =
                _leftPercents[column + i] + _widthPercents[1] / 2
            ..anchorTopPercent = _topPercents[row] + _pocketHeightPercent));

          _position++;
        });
        break;
      case HoldType.edge:
        _images.add(CustomBoardHoldImage((b) => b
          ..id = _id
          ..scale = _edgeScale
          ..heightPercent = _edgeHeightPercent
          ..widthPercent = _widthPercents[widthFactor]
          ..leftPercent = _leftPercents[column]
          ..topPercent = _topPercents[row]
          ..imageAsset = 'assets/images/custom_board/edge_$widthFactor.png'));
        List.generate(widthFactor, (i) {
          double _topLeftBorderRadius;
          double _topRightBorderRadius;
          double _bottomRightBorderRadius;
          double _bottomLeftBorderRadius;

          if (widthFactor == 1) {
            _topLeftBorderRadius = 5;
            _topRightBorderRadius = 5;
            _bottomRightBorderRadius = 5;
            _bottomLeftBorderRadius = 5;
          }

          if (widthFactor > 1) {
            if (i == 0) {
              _topLeftBorderRadius = 5;
              _topRightBorderRadius = 0;
              _bottomRightBorderRadius = 0;
              _bottomLeftBorderRadius = 5;
            } else if (i == widthFactor - 1) {
              _topLeftBorderRadius = 0;
              _topRightBorderRadius = 5;
              _bottomRightBorderRadius = 5;
              _bottomLeftBorderRadius = 0;
            } else {
              _topLeftBorderRadius = 0;
              _topRightBorderRadius = 0;
              _bottomRightBorderRadius = 0;
              _bottomLeftBorderRadius = 0;
            }
          }

          _boardHolds.add(BoardHold((b) => b
            ..borderRadiusAll = false
            ..topLeftBorderRadius = _topLeftBorderRadius
            ..topRightBorderRadius = _topRightBorderRadius
            ..bottomRightBorderRadius = _bottomRightBorderRadius
            ..bottomLeftBorderRadius = _bottomLeftBorderRadius
            ..type = HoldType.edge
            ..topPercent = _topPercents[row] - _onePixelHeightPercent
            ..leftPercent = _leftPercents[column + i] - _onePixelWidthPercent
            ..widthPercent = _widthPercents[1] + _onePixelWidthPercent * 2
            ..heightPercent = _edgeHeightPercent + _onePixelHeightPercent * 2
            ..depth = depth
            ..position = _position
            ..anchorLeftPercent =
                _leftPercents[column + i] + _widthPercents[1] / 2
            ..anchorTopPercent = _topPercents[row]));

          _position++;
        });
        break;
    }
  }
}
