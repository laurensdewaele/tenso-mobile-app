import 'package:app/widgets/new_workout/board_drag_targets.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_types.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/grip_image.dart';

class BoardHoldPicker extends StatefulWidget {
  BoardHoldPicker(
      {Key key,
      @required this.board,
      @required this.initialLeftGripBoardHold,
      @required this.initialRightGripBoardHold,
      @required this.handleLeftGripBoardHoldChanged,
      @required this.handleRightGripBoardHoldChanged,
      @required this.leftGrip,
      @required this.rightGrip})
      : super(key: key);

  final Board board;
  final BoardHold initialLeftGripBoardHold;
  final BoardHold initialRightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final Function(BoardHold boardHold) handleLeftGripBoardHoldChanged;
  final Function(BoardHold boardHold) handleRightGripBoardHoldChanged;

  @override
  _BoardHoldPickerState createState() => _BoardHoldPickerState();
}

class _BoardHoldPickerState extends State<BoardHoldPicker> {
  // We already calculate board size in the LayoutBuilder.
  // We're doing it here again with a addPostFrameCallback.
  // Because we cannot set state in the build method.
  // We're drawing the hands after the board has been rendered.
  // TODO: Find out
  // I hope it scales with on rotating the screen.
  double _containerHeight;
  Size _boardSize;
  double _gripHeight;
  Offset _leftHandOffset;
  Offset _rightHandOffset;
  Offset _leftHandFeedbackOffset;
  Offset _rightHandFeedbackOffset;
  BoardHold _leftGripBoardHold;
  BoardHold _rightGripBoardHold;

  @override
  void initState() {
    super.initState();
    _leftGripBoardHold = widget.initialLeftGripBoardHold;
    _rightGripBoardHold = widget.initialRightGripBoardHold;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(BoardHoldPicker oldWidget) {
    if (oldWidget.leftGrip != widget.leftGrip && widget.leftGrip != null) {
      _setHandOffset(widget.leftGrip, _leftGripBoardHold);
    }
    if (oldWidget.rightGrip != widget.rightGrip && widget.rightGrip != null) {
      _setHandOffset(widget.rightGrip, _rightGripBoardHold);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _handleBoardDimensions(Size size) {
    setState(() {
      _boardSize = size;
      _gripHeight = size.height * widget.board.handToBoardHeightRatio;
    });
    _setInitialHandOffset();
  }

  void _setInitialHandOffset() {
    _setHandOffset(widget.leftGrip, widget.initialLeftGripBoardHold);
    _setHandOffset(widget.rightGrip, widget.initialRightGripBoardHold);
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

    setState(() {
      if (grip.handType == HandTypes.leftHand) {
        _leftHandOffset = offset;
        _leftGripBoardHold = boardHold;
      } else {
        _rightHandOffset = offset;
        _rightGripBoardHold = boardHold;
      }
    });
  }

  void _setHandFeedbackOffset(
    PointerDownEvent event,
    Grip grip,
    double gripHeight,
  ) {
    Offset position = event.localPosition;
    final double dxHangAnchor =
        grip.dxRelativeHangAnchor * gripHeight * grip.assetAspectRatio;
    final double dyHangAnchor = grip.dyRelativeHangAnchor * gripHeight;
    final double dy = position.dy - dyHangAnchor;
    final double dx = position.dx - dxHangAnchor;
    setState(() {
      if (grip.handType == HandTypes.leftHand) {
        _leftHandFeedbackOffset = Offset(-dx, -dy);
      } else {
        _rightHandFeedbackOffset = Offset(-dx, -dy);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: _containerHeight,
          child: Container(),
        ),
        OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return BoardDragTargets(
              board: widget.board,
              handleBoardDimensions: _handleBoardDimensions,
              setHandOffset: _setHandOffset,
              orientation: orientation,
            );
          },
        ),
        if (widget.leftGrip != null && _leftHandOffset != null)
          Positioned(
            left: _leftHandOffset.dx,
            top: _leftHandOffset.dy,
            child: Listener(
              onPointerDown: (event) {
                _setHandFeedbackOffset(
                  event,
                  widget.leftGrip,
                  _gripHeight,
                );
              },
              child: Draggable(
                feedbackOffset: _leftHandFeedbackOffset,
                data: widget.leftGrip,
                feedback: Container(
                  height: _gripHeight,
                  child: GripImage(
                    assetSrc: widget.leftGrip.assetSrc,
                    selected: false,
                    color: styles.Colors.lighestGray,
                  ),
                ),
                child: Container(
                  height: _gripHeight,
                  child: GripImage(
                    assetSrc: widget.leftGrip.assetSrc,
                    selected: false,
                    color: styles.Colors.lighestGray,
                  ),
                ),
                childWhenDragging: Container(
                  height: _gripHeight,
                ),
              ),
            ),
          ),
        if (widget.rightGrip != null && _rightHandOffset != null)
          Positioned(
            left: _rightHandOffset.dx,
            top: _rightHandOffset.dy,
            child: Listener(
              onPointerDown: (event) {
                _setHandFeedbackOffset(
                  event,
                  widget.rightGrip,
                  _gripHeight,
                );
              },
              child: Draggable(
                feedbackOffset: _rightHandFeedbackOffset,
                data: widget.rightGrip,
                feedback: Container(
                  height: _gripHeight,
                  child: GripImage(
                    assetSrc: widget.rightGrip.assetSrc,
                    selected: false,
                    color: styles.Colors.lighestGray,
                  ),
                ),
                child: Container(
                  height: _gripHeight,
                  child: GripImage(
                    assetSrc: widget.rightGrip.assetSrc,
                    selected: false,
                    color: styles.Colors.lighestGray,
                  ),
                ),
                childWhenDragging: Container(
                  height: _gripHeight,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
