import 'package:app/models/grips.dart';
import 'package:app/widgets/grip_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/styles/styles.dart' as styles;

final double _kGripHeight = 100;
final double _kGripWidth = 80;

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            Container(child: Image.asset(widget.board.assetSrc)),
            ...widget.board.boardHolds.map((BoardHold boardHold) {
              final double boardImageWidth = constraints.maxWidth;
              final double boardImageHeight =
                  boardImageWidth / boardHold.aspectRatio.aspectRatio;
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
            Draggable(
              data: widget.grip,
              feedback: Container(
                height: _kGripHeight,
                child: GripImage(
                  assetSrc: widget.grip.assetSrc,
                  selected: false,
                  imageWidth: _kGripWidth,
                  handHold: widget.handHold,
                  color: styles.Colors.lighestGray,
                ),
              ),
              child: Container(
                height: _kGripHeight,
                child: GripImage(
                  assetSrc: widget.grip.assetSrc,
                  selected: false,
                  imageWidth: _kGripWidth,
                  handHold: widget.handHold,
                  color: styles.Colors.lighestGray,
                ),
              ),
              childWhenDragging: Container(
                height: _kGripHeight,
              ),
            ),
          ],
        );
      },
    );
  }
}
