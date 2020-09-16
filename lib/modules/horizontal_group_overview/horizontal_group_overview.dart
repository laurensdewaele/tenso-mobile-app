import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/workout/rep_set_header_info.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/board/board_with_grips.dart';

class HorizontalGroupOverview extends StatelessWidget {
  HorizontalGroupOverview(
      {Key key, @required this.groups, @required this.handleVisibleGroupIndex})
      : super(key: key);

  final List<Group> groups;
  final void Function(int visisbleBoard) handleVisibleGroupIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return _HorizontalGroupOverview(
          groups: groups,
          maxWidth: constraints.maxWidth,
          handleVisibleGroupIndex: handleVisibleGroupIndex,
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
      @required this.handleVisibleGroupIndex})
      : super(key: key);

  final List<Group> groups;
  final double maxWidth;
  final void Function(int visisbleBoard) handleVisibleGroupIndex;

  @override
  _HorizontalGroupOverviewState createState() =>
      _HorizontalGroupOverviewState();
}

class _HorizontalGroupOverviewState extends State<_HorizontalGroupOverview> {
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

    int _visibleGroupIndex;

    _tippingPoints.forEach((boardIndex, tippingPoint) {
      if (_visibleGroupIndex == null && _controller.offset < tippingPoint) {
        _visibleGroupIndex = boardIndex;
      }
    });

    widget.handleVisibleGroupIndex(_visibleGroupIndex);
  }

  double _calculateMaxBoardHeight() {
    double _maxHeight = 0;
    double _clippedHeight = styles.Measurements.s;
    double _padding = styles.Measurements.m * 2;

    widget.groups.forEach((Group group) {
      double _height = ((widget.maxWidth - _padding - kRepSetHeaderWidth) /
              group.board.aspectRatio) +
          _clippedHeight;
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
              .asMap()
              .map((int index, Group group) => MapEntry(
                    index,
                    Row(
                      children: <Widget>[
                        Container(
                          height: _calculateMaxBoardHeight(),
                          width: widget.maxWidth,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: styles.Measurements.m),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: BoardWithGrips(
                                        clipped: true,
                                        boardImageAssetWidth:
                                            group.board.imageAssetWidth,
                                        boardImageAsset: group.board.imageAsset,
                                        withFixedHeight: false,
                                        handToBoardHeightRatio:
                                            group.board.handToBoardHeightRatio,
                                        customBoardHoldImages: group
                                            .board.customBoardHoldImages
                                            ?.toList(),
                                        boardAspectRatio:
                                            group.board.aspectRatio,
                                        leftGripBoardHold:
                                            group.leftGripBoardHold,
                                        rightGripBoardHold:
                                            group.rightGripBoardHold,
                                        leftGrip: group.leftGrip,
                                        rightGrip: group.rightGrip,
                                      ),
                                    ),
                                  ),
                                  RepSetHeaderInfo(
                                    sets: group.sets,
                                    reps: group.reps,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (index != widget.groups.length - 1)
                          Container(
                            width: 1,
                            decoration:
                                BoxDecoration(color: styles.Colors.lightGray),
                          )
                      ],
                    ),
                  ))
              .values
              .toList()
        ],
      ),
    );
  }
}
