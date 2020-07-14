import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/board/hang_board.dart';
import 'package:tenso_app/widgets/grip_image.dart';

class BoardWithGrips extends StatelessWidget {
  BoardWithGrips(
      {Key key,
      @required this.boardAspectRatio,
      @required this.boardImageAsset,
      @required this.boardImageAssetWidth,
      @required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.handToBoardHeightRatio,
      @required this.leftGrip,
      @required this.rightGrip,
      @required this.customBoardHoldImages,
      @required this.withFixedHeight,
      @required this.clipped})
      : super(key: key);

  final bool clipped;
  final List<CustomBoardHoldImage> customBoardHoldImages;
  final String boardImageAsset;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final double boardImageAssetWidth;
  final double boardAspectRatio;
  final double handToBoardHeightRatio;
  final bool withFixedHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final Size _boardSize =
          Size(constraints.maxWidth, constraints.maxWidth / boardAspectRatio);
      final double _gripHeight = _boardSize.height * handToBoardHeightRatio;
      final _boardWithGripsHeight = _boardSize.height + _gripHeight;

      final Widget _content = _BoardWithGrips(
        clipped: clipped,
        boardImageAssetWidth: boardImageAssetWidth,
        customBoardHoldImages: customBoardHoldImages,
        boardSize: _boardSize,
        boardImageAsset: boardImageAsset,
        gripHeight: _gripHeight,
        leftGripBoardHold: leftGripBoardHold,
        rightGripBoardHold: rightGripBoardHold,
        rightGrip: rightGrip,
        leftGrip: leftGrip,
      );

      if (withFixedHeight == true) {
        return Container(height: _boardWithGripsHeight, child: _content);
      }

      return _content;
    });
  }
}

class _BoardWithGrips extends StatefulWidget {
  _BoardWithGrips(
      {Key key,
      @required this.boardImageAsset,
      @required this.boardImageAssetWidth,
      @required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.leftGrip,
      @required this.rightGrip,
      @required this.boardSize,
      @required this.gripHeight,
      @required this.customBoardHoldImages,
      @required this.clipped})
      : super(key: key);

  final bool clipped;
  final List<CustomBoardHoldImage> customBoardHoldImages;
  final Size boardSize;
  final double gripHeight;
  final String boardImageAsset;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final double boardImageAssetWidth;

  @override
  _BoardWithGripsState createState() => _BoardWithGripsState();
}

class _BoardWithGripsState extends State<_BoardWithGrips> {
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
    final double gripAnchorY = grip.anchorYPercent * widget.gripHeight;
    final double gripAnchorX =
        grip.anchorXPercent * grip.aspectRatio * widget.gripHeight;
    final double holdAnchorY =
        boardHold.anchorYPercent * widget.boardSize.height;
    final double holdAnchorX =
        boardHold.anchorXPercent * widget.boardSize.width;
    final Offset offset =
        Offset(holdAnchorX - gripAnchorX, holdAnchorY - gripAnchorY);

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
          overflow: widget.clipped ? Overflow.clip : Overflow.visible,
          children: <Widget>[
            HangBoard(
              boardImageAssetWidth: widget.boardImageAssetWidth,
              customBoardHoldImages: widget.customBoardHoldImages,
              boardSize: widget.boardSize,
              boardImageAsset: widget.boardImageAsset,
            ),
            if (widget.clipped == true)
              Container(
                height: widget.boardSize.height + styles.Measurements.s,
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
