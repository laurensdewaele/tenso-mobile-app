import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board/hang_board.dart';
import 'package:app/widgets/grip_image.dart';
import 'package:flutter/cupertino.dart';

class BoardWithGrips extends StatefulWidget {
  BoardWithGrips(
      {Key key,
      @required this.boardImageAsset,
      @required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.leftGrip,
      @required this.rightGrip,
      @required this.boardSize,
      @required this.gripHeight,
      @required this.customBoardHoldImages})
      : super(key: key);

  final List<CustomBoardHoldImage> customBoardHoldImages;
  final Size boardSize;
  final double gripHeight;
  final String boardImageAsset;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;

  @override
  _BoardWithGripsState createState() => _BoardWithGripsState();
}

class _BoardWithGripsState extends State<BoardWithGrips> {
  Offset _leftHandOffset;
  Offset _rightHandOffset;

  @override
  void initState() {
    super.initState();
    _checkAndSetHandOffsets();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    _checkAndSetHandOffsets();
    super.didUpdateWidget(oldWidget);
  }

  void _checkAndSetHandOffsets() {
    if (widget.leftGrip != null && widget.leftGripBoardHold != null) {
      _setHandOffset(widget.leftGrip, widget.leftGripBoardHold);
    }

    if (widget.rightGrip != null && widget.rightGripBoardHold != null) {
      _setHandOffset(widget.rightGrip, widget.rightGripBoardHold);
    }
  }

  void _setHandOffset(Grip grip, BoardHold boardHold) {
    final double gripAnchorTop = grip.anchorTopPercent * widget.gripHeight;
    final double gripAnchorLeft =
        grip.anchorLeftPercent * grip.aspectRatio * widget.gripHeight;
    final double holdAnchorTop =
        boardHold.anchorTopPercent * widget.boardSize.height;
    final double holdAnchorLeft =
        boardHold.anchorLeftPercent * widget.boardSize.width;
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
              customBoardHoldImages: widget.customBoardHoldImages,
              boardSize: widget.boardSize,
              boardImageAsset: widget.boardImageAsset,
            ),
            if (widget.leftGrip != null && _leftHandOffset != null)
              Positioned(
                left: _leftHandOffset.dx,
                top: _leftHandOffset.dy,
                child: Container(
                  height: widget.gripHeight,
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
                  height: widget.gripHeight,
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
