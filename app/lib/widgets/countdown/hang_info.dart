import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_type.dart';
import 'package:app/models/unit.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/grip_image.dart';
import 'package:app/widgets/countdown/portrait_info.dart';
import 'package:app/widgets/countdown/hang_info_board.dart';

// TODO: SO much repetition with BoardHoldPicker
class HangInfo extends StatefulWidget {
  HangInfo({
    Key key,
    this.holdLabel,
    @required this.board,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.reportTotalHangInfoContainerHeight,
    @required this.orientation,
    @required this.addedWeight,
    @required this.unit,
  }) : super(key: key);

  final Orientation orientation;
  final String holdLabel;
  final Board board;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final Function(double h) reportTotalHangInfoContainerHeight;
  final double addedWeight;
  final Unit unit;

  @override
  _HangInfoState createState() => _HangInfoState();
}

class _HangInfoState extends State<HangInfo> {
  double _boardContainerHeight;
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
    final holdLabelHeight = 45;
    final boardContainerHeight = boardSize.height +
        (boardSize.height * widget.board.handToBoardHeightRatio);

    setState(() {
      _boardSize = boardSize;
      _gripHeight = gripHeight;
      _boardContainerHeight = boardContainerHeight;
    });

    if (widget.orientation == Orientation.portrait) {
      widget.reportTotalHangInfoContainerHeight(
          boardContainerHeight + holdLabelHeight);
    } else {
      // TODO: Set right
      widget.reportTotalHangInfoContainerHeight(boardContainerHeight);
    }

    if (widget.leftGrip != null && widget.leftGripBoardHold != null) {
      _setHandOffset(widget.leftGrip, widget.leftGripBoardHold);
    }
    if (widget.rightGrip != null && widget.rightGripBoardHold != null) {
      _setHandOffset(widget.rightGrip, widget.rightGripBoardHold);
    }
  }

  _setHandOffset(Grip grip, BoardHold boardHold) {
    final double gripDYHangAnchor = grip.dyRelativeHangAnchor * _gripHeight;
    final double gripDXHangAnchor =
        grip.dxRelativeHangAnchor * grip.assetAspectRatio * _gripHeight;
    final double holdDYHangAnchor =
        boardHold.dyRelativeHangAnchor * _boardSize.height;
    final double holdDXHangAnchor =
        boardHold.dxRelativeHangAnchor * _boardSize.width;
    final Offset offset = Offset(holdDXHangAnchor - gripDXHangAnchor,
        holdDYHangAnchor - gripDYHangAnchor);

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
    final String _unitText = widget.unit == Unit.metric ? 'kg' : 'lb';
    final String _addedWeight = widget.addedWeight.toString();

    return Column(
      children: <Widget>[
        if (widget.holdLabel != null &&
            widget.orientation == Orientation.portrait)
          Text(
            widget.holdLabel,
            style: styles.Typography.countdownLabel,
          ),
        if (widget.holdLabel != null &&
            widget.orientation == Orientation.portrait)
          Divider(
            height: styles.Measurements.m,
          ),
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            if (widget.orientation == Orientation.portrait)
              Container(
                width: double.infinity,
                height: _boardContainerHeight,
                child: Container(),
              ),
            HangInfoBoard(
              boardAspectRatio: widget.board.aspectRatio,
              boardAssetSrc: widget.board.assetSrc,
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
                    assetSrc: widget.leftGrip.assetSrc,
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
                    assetSrc: widget.rightGrip.assetSrc,
                    selected: false,
                    color: styles.Colors.lighestGray,
                  ),
                ),
              ),
            if (widget.addedWeight > 0.0 &&
                widget.orientation == Orientation.portrait)
              Container(
                height: _boardContainerHeight,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PortraitInfo(
                    addedWeightText: '+ $_addedWeight $_unitText',
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
