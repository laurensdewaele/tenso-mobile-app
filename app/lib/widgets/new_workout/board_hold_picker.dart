import 'package:app/models/grips.dart';
import 'package:app/widgets/grip_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/styles/styles.dart' as styles;

class BoardHoldPicker extends StatefulWidget {
  BoardHoldPicker(
      {Key key,
      @required this.board,
      @required this.handHold,
      @required this.grip})
      : super(key: key);

  final Board board;
  final HandHolds handHold;
  final Grip grip;

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
    print(position);
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
                      print(candidateData);
                      print(rejectedData);
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
                      print('onWillAccept');
                      print(grip.fingers.length > boardHold.maxAllowedFingers);
                      print(grip.fingers.length);
                      print(boardHold.maxAllowedFingers);
                      if (grip.fingers.length > boardHold.maxAllowedFingers) {
                        return false;
                      } else {
                        return true;
                      }
                    },
                    onAccept: (data) {
                      print('onAccept');
                    },
                    onLeave: (data) {
                      print('onLeave');
                    },
                  ));
            }),
            Listener(
              onPointerDown: _onPointerDown,
              child: Draggable(
                // TODO: Calculate feedback offset
                feedbackOffset: Offset(0, -60),
                data: widget.grip,
                feedback: Container(
                  height: _kGripImageHeight,
                  child: GripImage(
                    assetSrcL: widget.grip.assetSrcL,
                    assetSrcR: widget.grip.assetSrcR,
                    selected: false,
                    handHold: widget.handHold,
                    color: styles.Colors.lighestGray,
                  ),
                ),
                child: Container(
                  height: _kGripImageHeight,
                  child: GripImage(
                    assetSrcL: widget.grip.assetSrcL,
                    assetSrcR: widget.grip.assetSrcR,
                    selected: false,
                    handHold: widget.handHold,
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
