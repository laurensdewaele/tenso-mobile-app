import 'dart:math';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board/hang_board.dart';
import 'package:app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';

const double _kBoardWidthPercent = .8;

class BoardPicker extends StatelessWidget {
  BoardPicker(
      {Key key,
      @required this.boards,
      @required this.selectedBoard,
      @required this.handleBoardChanged,
      @required this.primaryColor})
      : super(key: key);

  final Color primaryColor;
  final List<Board> boards;
  final Board selectedBoard;
  final void Function(Board board) handleBoardChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double _containerWidth = constraints.maxWidth;

      return Container(
          child: _BoardPicker(
              containerWidth: _containerWidth,
              boards: boards,
              selectedBoard: selectedBoard,
              handleBoardChanged: handleBoardChanged,
              primaryColor: primaryColor));
    });
  }
}

class _BoardPicker extends StatefulWidget {
  _BoardPicker(
      {Key key,
      @required this.containerWidth,
      @required this.boards,
      @required this.selectedBoard,
      @required this.handleBoardChanged,
      @required this.primaryColor})
      : super(key: key);

  final double containerWidth;
  final Color primaryColor;
  final List<Board> boards;
  final Board selectedBoard;
  final void Function(Board board) handleBoardChanged;

  @override
  _BoardPickerState createState() => _BoardPickerState();
}

class _BoardPickerState extends State<_BoardPicker> {
  final ScrollController _scrollController = ScrollController();

  double _boardPickerHeight;
  double _centerContainerWidth;

  @override
  void initState() {
    super.initState();
    _setContainerHeight();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  void didUpdateWidget(_BoardPicker oldWidget) {
    if (oldWidget.boards != widget.boards ||
        oldWidget.containerWidth != widget.containerWidth) {
      _setContainerHeight();
    }
    if (oldWidget.selectedBoard != widget.selectedBoard) {
      _scrollToSelected();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _setContainerHeight() {
    final List<double> _aspectRatios =
        widget.boards.map((b) => b.aspectRatio).toList();
    final double _minAspectRatio = _aspectRatios.reduce(min);
    _boardPickerHeight = widget.containerWidth / _minAspectRatio;
    _centerContainerWidth =
        widget.containerWidth * (1 - _kBoardWidthPercent) / 2;
  }

  void _afterLayout(Duration timeStamp) {
    _scrollToSelected();
  }

  void _scrollToSelected() {
    final double _center = widget.containerWidth / 2;
    final int _index = widget.boards.indexOf(widget.selectedBoard);
    final double _boardWidth = _kBoardWidthPercent * widget.containerWidth;

    _scrollController.animateTo(
        _centerContainerWidth +
            ((_index + 1) * _boardWidth) -
            _boardWidth / 2 -
            _center,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          widget.selectedBoard.name,
          style: styles.Lato.sBlack,
          textAlign: TextAlign.center,
        ),
        Divider(height: styles.Measurements.m),
        Container(
          width: double.infinity,
          height: _boardPickerHeight,
          child: ListView(
            physics: ClampingScrollPhysics(),
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Divider(
                width: _centerContainerWidth,
              ),
              ...widget.boards.map((Board board) => AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    child: board == widget.selectedBoard
                        ? _SelectedHangBoard(
                            onTap: () => widget.handleBoardChanged(board),
                            boardImageAssetWidth: board.imageAssetWidth,
                            boardImageAsset: board.imageAsset,
                            customBoardHoldImages:
                                board.customBoardHoldImages?.toList(),
                            boardSize: Size(
                                widget.containerWidth * _kBoardWidthPercent,
                                widget.containerWidth *
                                    _kBoardWidthPercent /
                                    board.aspectRatio),
                          )
                        : _DeselectedHangBoard(
                            onTap: () => widget.handleBoardChanged(board),
                            boardImageAssetWidth: board.imageAssetWidth,
                            boardImageAsset: board.imageAsset,
                            customBoardHoldImages:
                                board.customBoardHoldImages?.toList(),
                            boardSize: Size(
                                widget.containerWidth * _kBoardWidthPercent,
                                widget.containerWidth *
                                    _kBoardWidthPercent /
                                    board.aspectRatio),
                          ),
                  )),
              Divider(
                width: _centerContainerWidth,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HangBoard extends StatelessWidget {
  const _HangBoard({
    @required this.boardImageAssetWidth,
    @required this.boardImageAsset,
    @required this.customBoardHoldImages,
    @required this.boardSize,
    @required this.onTap,
    @required this.selected,
  });

  final bool selected;
  final double boardImageAssetWidth;
  final String boardImageAsset;
  final List<CustomBoardHoldImage> customBoardHoldImages;
  final Size boardSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Transform.scale(
          scale: selected ? 1 : .9,
          child: Opacity(
            opacity: selected ? 1 : .9,
            child: HangBoard(
              boardImageAssetWidth: boardImageAssetWidth,
              boardImageAsset: boardImageAsset,
              customBoardHoldImages: customBoardHoldImages,
              boardSize: boardSize,
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedHangBoard extends StatelessWidget {
  const _SelectedHangBoard(
      {@required this.boardImageAssetWidth,
      @required this.boardImageAsset,
      @required this.customBoardHoldImages,
      @required this.boardSize,
      @required this.onTap});

  final double boardImageAssetWidth;
  final String boardImageAsset;
  final List<CustomBoardHoldImage> customBoardHoldImages;
  final Size boardSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: HangBoard(
          boardImageAssetWidth: boardImageAssetWidth,
          boardImageAsset: boardImageAsset,
          customBoardHoldImages: customBoardHoldImages,
          boardSize: boardSize,
        ),
      ),
    );
  }
}

class _DeselectedHangBoard extends StatelessWidget {
  const _DeselectedHangBoard(
      {@required this.boardImageAssetWidth,
      @required this.boardImageAsset,
      @required this.customBoardHoldImages,
      @required this.boardSize,
      @required this.onTap});

  final double boardImageAssetWidth;
  final String boardImageAsset;
  final List<CustomBoardHoldImage> customBoardHoldImages;
  final Size boardSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Transform.scale(
          scale: .9,
          child: Opacity(
            opacity: .9,
            child: HangBoard(
              boardImageAssetWidth: boardImageAssetWidth,
              boardImageAsset: boardImageAsset,
              customBoardHoldImages: customBoardHoldImages,
              boardSize: boardSize,
            ),
          ),
        ),
      ),
    );
  }
}
