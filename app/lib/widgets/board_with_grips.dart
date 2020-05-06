import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board.dart';
import 'package:app/widgets/grip_image.dart';
import 'package:flutter/cupertino.dart';

class BoardWithGrips extends StatefulWidget {
  BoardWithGrips(
      {Key key,
      @required this.board,
      @required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.leftGrip,
      @required this.rightGrip,
      @required this.reportTotalHeight,
      @required this.orientation})
      : super(key: key);

  final Orientation orientation;
  final Board board;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final void Function(double h) reportTotalHeight;

  @override
  _BoardWithGripsState createState() => _BoardWithGripsState();
}

class _BoardWithGripsState extends State<BoardWithGrips> {
  Size _boardSize;
  double _gripHeight;
  Offset _leftHandOffset;
  Offset _rightHandOffset;

  @override
  void didUpdateWidget(Widget oldWidget) {
    if (widget.leftGrip != null && widget.leftGripBoardHold != null) {
      _setHandOffset(widget.leftGrip, widget.leftGripBoardHold);
    }

    if (widget.rightGrip != null && widget.rightGripBoardHold != null) {
      _setHandOffset(widget.rightGrip, widget.rightGripBoardHold);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _handleBoardDimensions(Size boardSize) {
    final gripHeight = boardSize.height * widget.board.handToBoardHeightRatio;
    final totalHeight = boardSize.height + gripHeight;
    widget.reportTotalHeight(totalHeight);

    setState(() {
      _boardSize = boardSize;
      _gripHeight = gripHeight;
    });

    if (widget.leftGrip != null && widget.leftGripBoardHold != null) {
      _setHandOffset(widget.leftGrip, widget.leftGripBoardHold);
    }
    if (widget.rightGrip != null && widget.rightGripBoardHold != null) {
      _setHandOffset(widget.rightGrip, widget.rightGripBoardHold);
    }
  }

  _setHandOffset(Grip grip, BoardHold boardHold) {
    final double gripAnchorTop = grip.anchorTopPercent * _gripHeight;
    final double gripAnchorLeft =
        grip.anchorLeftPercent * grip.assetAspectRatio * _gripHeight;
    final double holdAnchorTop = boardHold.anchorTopPercent * _boardSize.height;
    final double holdAnchorLeft =
        boardHold.anchorLeftPercent * _boardSize.width;
    final Offset offset =
        Offset(holdAnchorLeft - gripAnchorLeft, holdAnchorTop - gripAnchorTop);

    if (grip.handType == HandType.leftHand) {
      setState(() {
        _leftHandOffset = offset;
      });
    } else {
      setState(() {
        _rightHandOffset = offset;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            HangBoard(
              boardAspectRatio: widget.board.aspectRatio,
              boardImageAsset: widget.board.imageAsset,
              handleBoardDimensions: _handleBoardDimensions,
              setHandOffset: _setHandOffset,
              orientation: widget.orientation,
            ),
            if (widget.leftGrip != null && _leftHandOffset != null)
              Positioned(
                left: _leftHandOffset.dx,
                top: _leftHandOffset.dy,
                child: Container(
                  height: _gripHeight,
                  child: GripImage(
                    imageAsset: widget.leftGrip.imageAsset,
                    selected: false,
                    color: styles.Colors.lighestGray,
                  ),
                ),
              ),
            if (widget.rightGrip != null && _rightHandOffset != null)
              Positioned(
                left: _rightHandOffset.dx,
                top: _rightHandOffset.dy,
                child: Container(
                  height: _gripHeight,
                  child: GripImage(
                    imageAsset: widget.rightGrip.imageAsset,
                    selected: false,
                    color: styles.Colors.lighestGray,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
