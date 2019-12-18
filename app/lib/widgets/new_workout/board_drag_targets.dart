import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/styles/styles.dart' as styles;

class BoardDragTargets extends StatefulWidget {
  BoardDragTargets(
      {Key key,
      this.handleBoardDimensions,
      this.board,
      this.setHandOffset})
      : super(key: key);

  final Board board;
  final Function(Size boardSize) handleBoardDimensions;
  final Function(Grip grip, BoardHold boardHold) setHandOffset;

  @override
  _BoardDragTargetsState createState() => _BoardDragTargetsState();
}

class _BoardDragTargetsState extends State<BoardDragTargets> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final Size _boardSize = Size(constraints.maxWidth,
          constraints.maxWidth / widget.board.aspectRatio);
      widget.handleBoardDimensions(_boardSize);
      return Stack(
        children: <Widget>[
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
                    widget.setHandOffset(data, boardHold);
                  },
                  onLeave: (data) {},
                ));
          }),
        ],
      );
    });
  }
}
