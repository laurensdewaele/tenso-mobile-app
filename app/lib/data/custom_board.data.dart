import 'package:app/styles/styles.dart' as styles;

const int kRows = 4;
const int kColumns = 4;
const double kAspectRatio = 3;
const String kImageAsset = 'assets/images/custom_board/custom_board.png';
const double kHandToBoardHeightRatio = .85;
const double kSelectionBoxAspectRatio = 3.6;
const double kHorizontalSpacingPercent = _kSpacing / _kMeasuredWidth;
const double kVerticalSpacingPercent = _kSpacing / _kMeasuredHeight;

const double _kSpacing = styles.Measurements.xs;
const double _kMeasuredWidth = 647;
const double _kMeasuredHeight = _kMeasuredWidth / kAspectRatio;

const double kWidthPercent1 = (1 - (kHorizontalSpacingPercent * 5)) / kColumns;
const double _kWidthPercent2 = kWidthPercent1 * 2 + kHorizontalSpacingPercent;
const double _kWidthPercent3 =
    kWidthPercent1 * 3 + (kHorizontalSpacingPercent * 2);
const double _kWidthPercent4 =
    kWidthPercent1 * 4 + (kHorizontalSpacingPercent * 3);

const double _kLeftPercentColumn1 = kHorizontalSpacingPercent;
const double _kLeftPercentColumn2 =
    kWidthPercent1 + kHorizontalSpacingPercent * 2;
const double _kLeftPercentColumn3 =
    _kWidthPercent2 + kHorizontalSpacingPercent * 2;
const double _kLeftPercentColumn4 =
    _kWidthPercent3 + kHorizontalSpacingPercent * 2;

const double _kBottomRowsTopPercent = (kVerticalSpacingPercent) +
    ((kWidthPercent1 * _kMeasuredWidth / kSelectionBoxAspectRatio) /
        _kMeasuredHeight);

const double kPinchBlockJugScale = 1.08;
// This is the raw pinchBlock image height and the raw custom board image height.
const double kPinchBlockJugHeightPercent = 267 / 850;
const double kPinchBlockJugTopPercent =
    _kBottomRowsTopPercent - kPinchBlockJugHeightPercent;
const double kSloperHeightPercent = _kBottomRowsTopPercent;

const double _kBottomRowsHeightPercent = (1 - _kBottomRowsTopPercent);
const double _kBottomRowsRowHeightPercent = _kBottomRowsHeightPercent / 3;
const double _kBottomRowsRowCenterHeightPercent =
    _kBottomRowsRowHeightPercent / 2;
const double _kTopPercentRow2 =
    _kBottomRowsTopPercent + _kBottomRowsRowCenterHeightPercent;
const double _kTopPercentRow3 = _kTopPercentRow2 + _kBottomRowsRowHeightPercent;
const double _kTopPercentRow4 = _kTopPercentRow3 + _kBottomRowsRowHeightPercent;

const double kEdgeHeightPercent = 60 / 850;
const double kEdgeScale = 1.16;

const double kPocketHeightPercent = 112 / 850;
const double kPocketEdgeDifference =
    (kPocketHeightPercent - (kEdgeHeightPercent * kEdgeScale));

const Map<int, double> kWidthPercents = {
  1: kWidthPercent1,
  2: _kWidthPercent2,
  3: _kWidthPercent3,
  4: _kWidthPercent4
};

const Map<int, double> kWidthPercentPocketFingers = {
  5: kWidthPercent1,
  4: kWidthPercent1 / 5 * 4,
  3: kWidthPercent1 / 5 * 3,
  2: kWidthPercent1 / 5 * 2,
  1: kWidthPercent1 / 5 * 1
};

const Map<int, double> kLeftPercents = {
  1: _kLeftPercentColumn1,
  2: _kLeftPercentColumn2,
  3: _kLeftPercentColumn3,
  4: _kLeftPercentColumn4
};

const Map<int, double> kTopPercents = {
  2: _kTopPercentRow2,
  3: _kTopPercentRow3,
  4: _kTopPercentRow4
};

const double kOnePixelHeightPercent = 0.005;
const double kOnePixelWidthPercent = 0.002;
