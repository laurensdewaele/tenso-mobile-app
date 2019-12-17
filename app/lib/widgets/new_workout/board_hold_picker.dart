import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_types.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/grip_image.dart';

final GlobalKey _kBoardContainerKey = GlobalKey();

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
  Size _boardSizeForCalc = Size.zero;
  double _gripHeightForCalc;
  Offset _leftHandOffset = Offset.zero;
  Offset _rightHandOffset = Offset.zero;
  Offset _leftHandFeedbackOffset = Offset.zero;
  Offset _rightHandFeedbackOffset = Offset.zero;
  BoardHold _leftGripBoardHold;
  BoardHold _rightGripBoardHold;

  @override
  void initState() {
    super.initState();
    _leftGripBoardHold = widget.initialLeftGripBoardHold;
    _rightGripBoardHold = widget.initialRightGripBoardHold;
    WidgetsBinding.instance.addPostFrameCallback(_afterBoardPaint);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(BoardHoldPicker oldWidget) {
    if (oldWidget.leftGrip != widget.leftGrip && widget.leftGrip != null) {
      _setHandOffset(_boardSizeForCalc, widget.leftGrip, _gripHeightForCalc,
          _leftGripBoardHold);
    }
    if (oldWidget.rightGrip != widget.rightGrip && widget.rightGrip != null) {
      _setHandOffset(_boardSizeForCalc, widget.rightGrip, _gripHeightForCalc,
          _rightGripBoardHold);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _afterBoardPaint(Duration timeStamp) {
    final RenderBox container =
        _kBoardContainerKey.currentContext.findRenderObject();
    setState(() {
      _boardSizeForCalc = Size(container.size.width,
          container.size.width / widget.board.aspectRatio);
      _gripHeightForCalc =
          _boardSizeForCalc.height * widget.board.handToBoardHeightRatio;
    });
    _setInitialHandOffset();
  }

  void _setInitialHandOffset() {
    _setHandOffset(_boardSizeForCalc, widget.leftGrip, _gripHeightForCalc,
        widget.initialLeftGripBoardHold);
    _setHandOffset(_boardSizeForCalc, widget.rightGrip, _gripHeightForCalc,
        widget.initialRightGripBoardHold);
  }

  _setHandOffset(
      Size boardSize, Grip grip, double gripHeight, BoardHold boardHold) {
    print('method ----');
    print(boardSize);
    print(gripHeight);
    final double gripDYHangAnchor = grip.dyRelativeHangAnchor * gripHeight;
    final double gripDXHangAnchor =
        grip.dxRelativeHangAnchor * grip.assetAspectRatio * gripHeight;
    final double holdDYHangAnchor =
        boardHold.dyRelativeHangAnchor * boardSize.height;
    final double holdDXHangAnchor =
        boardHold.dxRelativeHangAnchor * boardSize.width;
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size _boardSize = Size(constraints.maxWidth,
            constraints.maxWidth / widget.board.aspectRatio);
        final double _gripHeight =
            _boardSize.height * widget.board.handToBoardHeightRatio;
        // We need an empty container,
        // otherwise the hitbox of the draggable hands are clipped when positioned low.
        final double _containerHeight = _boardSize.height + _gripHeight;
        print('---build');
        print(_boardSize);
        print(_gripHeight);

        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              key: _kBoardContainerKey,
              width: double.infinity,
              height: _containerHeight,
              child: Container(),
            ),
            Container(
                child: Image.asset(
              widget.board.assetSrc,
            )),
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
                      _setHandOffset(_boardSize, data, _gripHeight, boardHold);
                    },
                    onLeave: (data) {},
                  ));
            }),
            if (widget.leftGrip != null && _leftHandOffset != Offset.zero)
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
            if (widget.rightGrip != null && _rightHandOffset != Offset.zero)
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
      },
    );
  }
}
