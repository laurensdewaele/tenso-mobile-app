import 'package:flutter/cupertino.dart';

import 'package:app/functions/board_hold_grip_compatibility.dart';
import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/styles/styles.dart' as styles;

class BoardDragTargets extends StatefulWidget {
  BoardDragTargets({
    Key key,
    @required this.handleBoardDimensions,
    @required this.board,
    @required this.setHandOffset,
    @required this.orientation,
    @required this.setErrorMessage,
  }) : super(key: key);

  final Board board;
  final Function(Size boardSize) handleBoardDimensions;
  final Function(Grip grip, BoardHold boardHold) setHandOffset;
  final Orientation orientation;
  final Function(Widget errorMessage) setErrorMessage;

  @override
  _BoardDragTargetsState createState() => _BoardDragTargetsState();
}

class _BoardDragTargetsState extends State<BoardDragTargets> {
  bool _shouldCheckDimensions = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
              child: Image.asset(
            widget.board.assetSrc,
          )),
          ...widget.board.boardHolds.map((BoardHold boardHold) {
            final Rect rect = Rect.fromLTWH(
                boardHold.relativeLeft * _boardSize.width,
                boardHold.relativeTop * _boardSize.height,
                boardHold.relativeWidth * _boardSize.width,
                boardHold.relativeHeight * _boardSize.height);
            return Positioned.fromRect(
                rect: rect,
                child: DragTarget(
                  builder: (BuildContext context, List<Grip> candidateData,
                      List<dynamic> rejectedData) {
                    if (candidateData.length > 0) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: styles.kBorderRadiusAll,
                            border: Border.all(
                                width: 2, color: styles.Colors.green)),
                      );
                    }
                    if (rejectedData.length > 0) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: styles.kBorderRadiusAll,
                            border: Border.all(
                                width: 2, color: styles.Colors.primary)),
                      );
                    }
                    return Container();
                  },
                  onWillAccept: (Grip grip) {
                    final Widget errorMessage =
                        checkCompatibility(grip, boardHold);
                    if (errorMessage == null) {
                      return true;
                    } else {
                      widget.setErrorMessage(errorMessage);
                      return false;
                    }
                  },
                  onAccept: (data) {
                    widget.setErrorMessage(null);
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
