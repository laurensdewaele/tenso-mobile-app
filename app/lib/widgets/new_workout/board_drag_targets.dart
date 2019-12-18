import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/styles/styles.dart' as styles;

class BoardDragTargets extends StatefulWidget {
  BoardDragTargets(
      {Key key,
      @required this.handleBoardDimensions,
      @required this.board,
      @required this.setHandOffset,
      @required this.orientation,
      @required this.containerHeight})
      : super(key: key);

  final Board board;
  final Function(Size boardSize) handleBoardDimensions;
  final Function(Grip grip, BoardHold boardHold) setHandOffset;
  final Orientation orientation;
  // We're setting the containerHeight via 'props'
  // because we it needs the grip size to calculate it.
  // It needs to be in this Widget's Stack because
  // it needs to absorb the pointer events from switching the tabs.
  final double containerHeight;

  @override
  _BoardDragTargetsState createState() => _BoardDragTargetsState();
}

class _BoardDragTargetsState extends State<BoardDragTargets> {
  bool _shouldCheckDimensions = true;

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
  void didUpdateWidget(BoardDragTargets oldWidget) {
    if (oldWidget.orientation != widget.orientation) {
      setState(() {
        _shouldCheckDimensions = true;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  void _triggerPostFrameCallback(Size boardSize) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.handleBoardDimensions(boardSize);
      setState(() {
        _shouldCheckDimensions = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final Size _boardSize = Size(constraints.maxWidth,
          constraints.maxWidth / widget.board.aspectRatio);

      if (_shouldCheckDimensions == true) {
        _triggerPostFrameCallback(_boardSize);
      }
      return Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: widget.containerHeight,
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
