import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board/board_with_grips.dart';
import 'package:flutter/cupertino.dart';

class HorizontalGroupOverview extends StatelessWidget {
  HorizontalGroupOverview(
      {Key key, @required this.groups, @required this.reportVisibleBoardIndex})
      : super(key: key);

  final List<Group> groups;
  final void Function(int visisbleBoard) reportVisibleBoardIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return _HorizontalGroupOverview(
          groups: groups,
          maxWidth: constraints.maxWidth,
          reportVisibleBoardIndex: reportVisibleBoardIndex,
        );
      },
    );
  }
}

class _HorizontalGroupOverview extends StatefulWidget {
  _HorizontalGroupOverview(
      {Key key,
      @required this.groups,
      @required this.maxWidth,
      @required this.reportVisibleBoardIndex})
      : super(key: key);

  final List<Group> groups;
  final double maxWidth;
  final void Function(int visisbleBoard) reportVisibleBoardIndex;

  @override
  __HorizontalGroupOverviewState createState() =>
      __HorizontalGroupOverviewState();
}

class __HorizontalGroupOverviewState extends State<_HorizontalGroupOverview> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double _calculateTippingPoint(boardIndex) {
      double _point =
          (widget.maxWidth * (boardIndex + 1) - widget.maxWidth / 2);
      if (_point < 0) return 0;
      return _point;
    }

    final Map<int, double> _tippingPoints = widget.groups.asMap().map(
        (int boardIndex, Group group) =>
            MapEntry(boardIndex, _calculateTippingPoint(boardIndex)));

    int _visibleBoardIndex;

    _tippingPoints.forEach((boardIndex, tippingPoint) {
      if (_visibleBoardIndex == null && _controller.offset < tippingPoint) {
        _visibleBoardIndex = boardIndex;
      }
    });

    widget.reportVisibleBoardIndex(_visibleBoardIndex);
  }

  double _calculateMaxBoardHeight() {
    double _maxHeight = 0;
    double _clippedHeight = styles.Measurements.s;

    widget.groups.forEach((Group group) {
      double _height =
          (widget.maxWidth / group.board.aspectRatio) + _clippedHeight;
      if (_height > _maxHeight) {
        _maxHeight = _height;
      }
    });
    return _maxHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _calculateMaxBoardHeight(),
      child: ListView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          ...widget.groups
              .map((Group group) => Container(
                    height: _calculateMaxBoardHeight(),
                    width: widget.maxWidth,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: styles.Measurements.m),
                        child: BoardWithGrips(
                          clipped: true,
                          boardImageAssetWidth: group.board.imageAssetWidth,
                          boardImageAsset: group.board.imageAsset,
                          withFixedHeight: false,
                          handToBoardHeightRatio:
                              group.board.handToBoardHeightRatio,
                          customBoardHoldImages:
                              group.board.customBoardHoldImages?.toList(),
                          boardAspectRatio: group.board.aspectRatio,
                          leftGripBoardHold: group.leftGripBoardHold,
                          rightGripBoardHold: group.rightGripBoardHold,
                          leftGrip: group.leftGrip,
                          rightGrip: group.rightGrip,
                        ),
                      ),
                    ),
                  ))
              .toList()
        ],
      ),
    );
  }
}
