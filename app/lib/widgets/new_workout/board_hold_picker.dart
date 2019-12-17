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
  Offset _leftHandOffset = Offset.zero;
  Offset _rightHandOffset = Offset.zero;
  Offset _leftHandFeedbackOffset = Offset.zero;
  Offset _rightHandFeedbackOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

  _onDragAccept(
      Size boardSize, Grip grip, double gripHeight, BoardHold boardHold) {
    final double imageDYHangAnchor = grip.dyRelativeHangAnchor * gripHeight;
    final double imageDXHangAnchor =
        grip.dxRelativeHangAnchor * grip.assetAspectRatio * gripHeight;
    final double holdDYHangAnchor =
        boardHold.dyRelativeHangAnchor * boardSize.height;
    final double holdDXHangAnchor =
        boardHold.dxRelativeHangAnchor * boardSize.width;

    setState(() {
      if (grip.handType == HandTypes.leftHand) {
        _leftHandOffset = Offset(holdDXHangAnchor - imageDXHangAnchor,
            holdDYHangAnchor - imageDYHangAnchor);
      } else {
        _rightHandOffset = Offset(holdDXHangAnchor - imageDXHangAnchor,
            holdDYHangAnchor - imageDYHangAnchor);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size _boardSize = Size(constraints.maxWidth,
            constraints.maxWidth / widget.board.aspectRatio);
        final double _gripHeight =
            _boardSize.height * widget.board.handToBoardHeightRatio;

        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(child: Image.asset(widget.board.assetSrc)),
            ...widget.board.boardHolds.map((BoardHold boardHold) {
              final Rect rect = Rect.fromLTWH(
                  boardHold.relativeRect.left * _boardSize.width,
                  boardHold.relativeRect.top * _boardSize.height,
                  boardHold.relativeRect.width * _boardSize.width,
                  boardHold.relativeRect.height * _boardSize.height);
              return Positioned.fromRect(
                  rect: rect,
                  child: DragTarget(
                    builder: (BuildContext context, List<Grip> candidateData,
                        List<dynamic> rejectedData) {
                      if (candidateData.length > 0) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: styles.Colors.difficultyBlue)),
                        );
                      }
                      if (rejectedData.length > 0) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: styles.Colors.primary)),
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: styles.Colors.black)),
                      );
                    },
                    onWillAccept: (Grip grip) {
                      if (grip.fingers.count > boardHold.maxAllowedFingers) {
                        return false;
                      } else {
                        return true;
                      }
                    },
                    onAccept: (data) {
                      _onDragAccept(_boardSize, data, _gripHeight, boardHold);
                    },
                    onLeave: (data) {},
                  ));
            }),
            if (widget.leftGrip != null)
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
                        color: styles.Colors.gray,
                      ),
                    ),
                    child: Container(
                      height: _gripHeight,
                      child: GripImage(
                        assetSrc: widget.leftGrip.assetSrc,
                        selected: false,
                        color: styles.Colors.gray,
                      ),
                    ),
                    childWhenDragging: Container(
                      height: _gripHeight,
                    ),
                  ),
                ),
              ),
            if (widget.rightGrip != null)
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
                        color: styles.Colors.gray,
                      ),
                    ),
                    child: Container(
                      height: _gripHeight,
                      child: GripImage(
                        assetSrc: widget.rightGrip.assetSrc,
                        selected: false,
                        color: styles.Colors.gray,
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
      },
    );
  }
}
