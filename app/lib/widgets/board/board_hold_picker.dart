import 'package:app/models/models.dart';
import 'package:app/services/toast.service.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board/board_drag_targets.dart';
import 'package:app/widgets/grip_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class BoardHoldPicker extends StatelessWidget {
  const BoardHoldPicker(
      {Key key,
      @required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.leftGrip,
      @required this.rightGrip,
      @required this.handleLeftGripBoardHoldChanged,
      @required this.handleRightGripBoardHoldChanged,
      @required this.boardImageAsset,
      @required this.boardImageAssetWidth,
      @required this.boardHolds,
      this.customBoardHoldImages,
      @required this.handToBoardHeightRatio,
      @required this.boardAspectRatio});

  final double boardAspectRatio;
  final double handToBoardHeightRatio;
  final String boardImageAsset;
  final double boardImageAssetWidth;

  final List<CustomBoardHoldImage> customBoardHoldImages;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final void Function(BoardHold boardHold) handleLeftGripBoardHoldChanged;
  final void Function(BoardHold boardHold) handleRightGripBoardHoldChanged;
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
          boardImageAsset: boardImageAsset,
          boardImageAssetWidth: boardImageAssetWidth,
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
      {Key key,
      @required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.boardSize,
      @required this.leftGrip,
      @required this.rightGrip,
      @required this.gripHeight,
      @required this.handleLeftGripBoardHoldChanged,
      @required this.handleRightGripBoardHoldChanged,
      @required this.boardImageAsset,
      @required this.boardImageAssetWidth,
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
  final String boardImageAsset;
  final double boardImageAssetWidth;
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
        (oldWidget.rightGrip != widget.rightGrip) ||
        (oldWidget.boardImageAsset != widget.boardImageAsset)) {
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
    final double anchorX = grip.anchorXPercent * gripHeight * grip.aspectRatio;
    final double anchorY = grip.anchorYPercent * gripHeight;
    final double dy = position.dy - anchorY;
    final double dx = position.dx - anchorX;
    setState(() {
      if (grip.handType == HandType.leftHand) {
        _leftHandFeedbackOffset = Offset(-dx, -dy);
      } else {
        _rightHandFeedbackOffset = Offset(-dx, -dy);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails detail) {
    // This is here so it competes with the
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
            boardImageAssetWidth: widget.boardImageAssetWidth,
            boardSize: widget.boardSize,
            customBoardHoldImages: widget.customBoardHoldImages,
            boardImageAsset: widget.boardImageAsset,
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
