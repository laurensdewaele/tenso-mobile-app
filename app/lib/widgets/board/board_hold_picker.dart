import 'package:app/models/models.dart';
import 'package:app/services/toast.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board/board_drag_targets.dart';
import 'package:app/widgets/grip_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class BoardHoldPicker extends StatelessWidget {
  const BoardHoldPicker(
      {@required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.leftGrip,
      @required this.rightGrip,
      @required this.handleLeftGripBoardHoldChanged,
      @required this.handleRightGripBoardHoldChanged,
      @required this.imageAsset,
      @required this.boardHolds,
      this.customBoardHoldImages,
      @required this.boardImageAsset,
      @required this.handToBoardHeightRatio,
      @required this.boardAspectRatio});

  final double boardAspectRatio;
  final double handToBoardHeightRatio;
  final String boardImageAsset;

  final List<CustomBoardHoldImage> customBoardHoldImages;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final void Function(BoardHold boardHold) handleLeftGripBoardHoldChanged;
  final void Function(BoardHold boardHold) handleRightGripBoardHoldChanged;
  final String imageAsset;
  final List<BoardHold> boardHolds;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double _boardHeight = constraints.maxWidth / boardAspectRatio;
      final Size _boardSize = Size(constraints.maxWidth, _boardHeight);
      final _gripHeight = _boardHeight * handToBoardHeightRatio;
      final _boardWithGripsHeight = _boardHeight + _gripHeight;
      return Container(
        height: _boardWithGripsHeight,
        child: _BoardHoldPicker(
          gripHeight: _gripHeight,
          boardSize: _boardSize,
          imageAsset: boardImageAsset,
          boardHolds: boardHolds,
          customBoardHoldImages: customBoardHoldImages,
          rightGrip: rightGrip,
          leftGrip: leftGrip,
          leftGripBoardHold: leftGripBoardHold,
          rightGripBoardHold: rightGripBoardHold,
          handleLeftGripBoardHoldChanged: handleLeftGripBoardHoldChanged,
          handleRightGripBoardHoldChanged: handleRightGripBoardHoldChanged,
        ),
      );
    });
  }
}

class _BoardHoldPicker extends StatefulWidget {
  const _BoardHoldPicker(
      {@required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.boardSize,
      @required this.leftGrip,
      @required this.rightGrip,
      @required this.gripHeight,
      @required this.handleLeftGripBoardHoldChanged,
      @required this.handleRightGripBoardHoldChanged,
      @required this.imageAsset,
      @required this.boardHolds,
      this.customBoardHoldImages});

  final Size boardSize;
  final double gripHeight;
  final List<CustomBoardHoldImage> customBoardHoldImages;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final void Function(BoardHold boardHold) handleLeftGripBoardHoldChanged;
  final void Function(BoardHold boardHold) handleRightGripBoardHoldChanged;
  final String imageAsset;
  final List<BoardHold> boardHolds;

  @override
  _BoardHoldPickerState createState() => _BoardHoldPickerState();
}

class _BoardHoldPickerState extends State<_BoardHoldPicker> {
  Widget _errorMessage;
  Offset _leftHandOffset;
  Offset _rightHandOffset;
  Offset _leftHandFeedbackOffset;
  Offset _rightHandFeedbackOffset;

  @override
  void initState() {
    _checkAndSetHandOffsets();
    super.initState();
  }

  @override
  void didUpdateWidget(_BoardHoldPicker oldWidget) {
    if ((oldWidget.leftGrip != widget.leftGrip) ||
        (oldWidget.rightGrip != widget.rightGrip)) {
      _checkAndSetHandOffsets();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _checkAndSetHandOffsets() {
    if (widget.leftGrip != null && widget.leftGripBoardHold != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _setHandOffset(widget.leftGrip, widget.leftGripBoardHold);
      });
    }
    if (widget.rightGrip != null && widget.rightGripBoardHold != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _setHandOffset(widget.rightGrip, widget.rightGripBoardHold);
      });
    }
  }

  _setHandOffset(Grip grip, BoardHold boardHold) {
    final double gripAnchorTop = grip.anchorTopPercent * widget.gripHeight;
    final double gripAnchorLeft =
        grip.anchorLeftPercent * grip.assetAspectRatio * widget.gripHeight;
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
      // We cannot just let the parent update our state.
      // On dragSuccess we need to update our state as fast as possible,
      // Otherwise one will notice severe 'jank'.
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
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: <Widget>[
          BoardDragTargets(
            boardSize: widget.boardSize,
            customBoardHoldImages: widget.customBoardHoldImages,
            boardImageAsset: widget.imageAsset,
            boardHolds: widget.boardHolds,
            activeBoardHolds: [
              widget.rightGripBoardHold,
              widget.leftGripBoardHold
            ],
            handleSuccess: _setHandOffset,
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
                    widget.gripHeight,
                  );
                },
                child: Draggable(
                  onDragEnd: _onDragEnd,
                  feedbackOffset: _leftHandFeedbackOffset,
                  data: widget.leftGrip,
                  feedback: Container(
                    height: widget.gripHeight,
                    child: GripImage(
                      imageAsset: widget.leftGrip.imageAsset,
                      selected: false,
                      color: styles.Colors.lighestGray,
                    ),
                  ),
                  child: Container(
                    height: widget.gripHeight,
                    child: GripImage(
                      imageAsset: widget.leftGrip.imageAsset,
                      selected: false,
                      color: styles.Colors.lighestGray,
                    ),
                  ),
                  childWhenDragging: Container(
                    height: widget.gripHeight,
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
                    widget.gripHeight,
                  );
                },
                child: Draggable(
                  onDragEnd: _onDragEnd,
                  feedbackOffset: _rightHandFeedbackOffset,
                  data: widget.rightGrip,
                  feedback: Container(
                    height: widget.gripHeight,
                    child: GripImage(
                      imageAsset: widget.rightGrip.imageAsset,
                      selected: false,
                      color: styles.Colors.lighestGray,
                    ),
                  ),
                  child: Container(
                    height: widget.gripHeight,
                    child: GripImage(
                      imageAsset: widget.rightGrip.imageAsset,
                      selected: false,
                      color: styles.Colors.lighestGray,
                    ),
                  ),
                  childWhenDragging: Container(
                    height: widget.gripHeight,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
