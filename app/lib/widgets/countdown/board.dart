import 'package:flutter/cupertino.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';

class HangBoard extends StatefulWidget {
  HangBoard({
    Key key,
    @required this.handleBoardDimensions,
    @required this.setHandOffset,
    @required this.orientation,
    @required this.boardAspectRatio,
    @required this.boardAssetSrc,
  }) : super(key: key);

  final double boardAspectRatio;
  final String boardAssetSrc;
  final void Function(Size boardSize) handleBoardDimensions;
  final void Function(Grip grip, BoardHold boardHold) setHandOffset;
  final Orientation orientation;

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<HangBoard> {
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
  void didUpdateWidget(HangBoard oldWidget) {
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
      final Size _boardSize = Size(
          constraints.maxWidth, constraints.maxWidth / widget.boardAspectRatio);

      if (_shouldCheckDimensions == true) {
        _triggerPostFrameCallback(_boardSize);
      }
      return Stack(
        children: <Widget>[
          Container(
              child: Image.asset(
            widget.boardAssetSrc,
          )),
        ],
      );
    });
  }
}
