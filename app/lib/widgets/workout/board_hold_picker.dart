import 'package:app/models/models.dart';
import 'package:app/services/toast.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/grip_image.dart';
import 'package:app/widgets/workout/board_drag_targets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class BoardHoldPicker extends StatefulWidget {
  const BoardHoldPicker(
      {@required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.leftGrip,
      @required this.rightGrip,
      @required this.handleLeftGripBoardHoldChanged,
      @required this.handleRightGripBoardHoldChanged,
      @required this.handToBoardHeightRatio,
      @required this.aspectRatio,
      @required this.imageAsset,
      @required this.boardHolds,
      this.customBoardHoldImages});

  final List<CustomBoardHoldImage> customBoardHoldImages;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final void Function(BoardHold boardHold) handleLeftGripBoardHoldChanged;
  final void Function(BoardHold boardHold) handleRightGripBoardHoldChanged;
  final double handToBoardHeightRatio;
  final double aspectRatio;
  final String imageAsset;
  final List<BoardHold> boardHolds;

  @override
  _BoardHoldPickerState createState() => _BoardHoldPickerState();
}

class _BoardHoldPickerState extends State<BoardHoldPicker> {
  // We're setting the containerHeight via 'props' to BoardDragTargets
  // because we it needs the grip size to calculate it.
  // It needs to be in this Widget's Stack because
  // it needs to absorb the pointer events from switching the tabs.
  double _containerHeight;

  Widget _errorMessage;
  Size _boardSize;
  double _gripHeight;
  Offset _leftHandOffset;
  Offset _rightHandOffset;
  Offset _leftHandFeedbackOffset;
  Offset _rightHandFeedbackOffset;

  @override
  void didUpdateWidget(BoardHoldPicker oldWidget) {
    if (oldWidget.leftGrip != widget.leftGrip &&
        widget.leftGrip != null &&
        widget.leftGripBoardHold != null) {
      // This gives a small delay, but need it.
      // The error is acceptable in debug mode,
      // Release mode doesn't work :)
      // I haven't figured out yet how to not have delay here.
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _setHandOffset(widget.leftGrip, widget.leftGripBoardHold);
      });
    }

    if (oldWidget.rightGrip != widget.rightGrip &&
        widget.rightGrip != null &&
        widget.rightGripBoardHold != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _setHandOffset(widget.rightGrip, widget.rightGripBoardHold);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  void _handleBoardDimensions(Size boardSize) {
    setState(() {
      _boardSize = boardSize;
      _gripHeight = boardSize.height * widget.handToBoardHeightRatio;
      _containerHeight =
          boardSize.height + (boardSize.height * widget.handToBoardHeightRatio);
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
      widget.handleLeftGripBoardHoldChanged(boardHold);
    } else {
      setState(() {
        _rightHandOffset = offset;
      });
      widget.handleRightGripBoardHoldChanged(boardHold);
    }
  }

  void _setHandFeedbackOffset(
    PointerDownEvent event,
    Grip grip,
    double gripHeight,
  ) {
    Offset position = event.localPosition;
    final double anchorLeft =
        grip.anchorLeftPercent * gripHeight * grip.assetAspectRatio;
    final double anchorTop = grip.anchorTopPercent * gripHeight;
    final double dy = position.dy - anchorTop;
    final double dx = position.dx - anchorLeft;
    setState(() {
      if (grip.handType == HandType.leftHand) {
        _leftHandFeedbackOffset = Offset(-dx, -dy);
      } else {
        _rightHandFeedbackOffset = Offset(-dx, -dy);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails detail) {
    // This is just here so it competes with the
    // horizontalDragEnd from NewWorkout
  }

  void _onDragEnd(DraggableDetails details) {
    if (_errorMessage != null) {
      ToastService().add(_errorMessage);
    }
  }

  void _setErrorMessage(Widget errorMessage) {
    setState(() {
      _errorMessage = errorMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: _containerHeight,
            child: Container(),
          ),
          BoardDragTargets(
            customBoardHoldImages: widget.customBoardHoldImages,
            boardAspectRatio: widget.aspectRatio,
            boardImageAsset: widget.imageAsset,
            boardHolds: widget.boardHolds,
            activeBoardHolds: [
              widget.rightGripBoardHold,
              widget.leftGripBoardHold
            ],
            handleBoardDimensions: _handleBoardDimensions,
            setHandOffset: _setHandOffset,
            orientation: MediaQuery.of(context).orientation,
            setErrorMessage: _setErrorMessage,
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
                  onDragEnd: _onDragEnd,
                  feedbackOffset: _leftHandFeedbackOffset,
                  data: widget.leftGrip,
                  feedback: Container(
                    height: _gripHeight,
                    child: GripImage(
                      imageAsset: widget.leftGrip.imageAsset,
                      selected: false,
                      color: styles.Colors.lighestGray,
                    ),
                  ),
                  child: Container(
                    height: _gripHeight,
                    child: GripImage(
                      imageAsset: widget.leftGrip.imageAsset,
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
                  onDragEnd: _onDragEnd,
                  feedbackOffset: _rightHandFeedbackOffset,
                  data: widget.rightGrip,
                  feedback: Container(
                    height: _gripHeight,
                    child: GripImage(
                      imageAsset: widget.rightGrip.imageAsset,
                      selected: false,
                      color: styles.Colors.lighestGray,
                    ),
                  ),
                  child: Container(
                    height: _gripHeight,
                    child: GripImage(
                      imageAsset: widget.rightGrip.imageAsset,
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
      ),
    );
  }
}
