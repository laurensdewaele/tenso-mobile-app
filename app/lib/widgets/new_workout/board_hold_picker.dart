import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    Offset position = event.localPosition;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double boardImageWidth = constraints.maxWidth;
        final double boardImageHeight =
            boardImageWidth / widget.board.aspectRatio;
        final double _kGripImageHeight =
            boardImageHeight * widget.board.handToBoardHeightRatio;

        return Stack(
          children: <Widget>[
            Container(child: Image.asset(widget.board.assetSrc)),
            ...widget.board.boardHolds.map((BoardHold boardHold) {
              return Positioned.fromRect(
                  rect: Rect.fromLTWH(
                      boardHold.relativeRect.left * boardImageWidth,
                      boardHold.relativeRect.top * boardImageHeight,
                      boardHold.relativeRect.width * boardImageWidth,
                      boardHold.relativeRect.height * boardImageHeight),
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
                    onAccept: (data) {},
                    onLeave: (data) {},
                  ));
            }),
            Listener(
              onPointerDown: _onPointerDown,
              child: Draggable(
                // TODO: Calculate feedback offset
                feedbackOffset: Offset(0, -60),
                data: widget.leftGrip,
                feedback: Container(
                  height: _kGripImageHeight,
                  child: GripImage(
                    assetSrc: widget.leftGrip.assetSrc,
                    selected: false,
                    color: styles.Colors.lighestGray,
                  ),
                ),
                child: Container(
                  height: _kGripImageHeight,
                  child: GripImage(
                    assetSrc: widget.leftGrip.assetSrc,
                    selected: false,
                    color: styles.Colors.lighestGray,
                  ),
                ),
                childWhenDragging: Container(
                  height: _kGripImageHeight,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
