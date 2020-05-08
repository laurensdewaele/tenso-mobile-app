import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board_with_grips.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/workout/board_hold_info.dart';
import 'package:flutter/cupertino.dart';

class SelectedGripsAndHolds extends StatelessWidget {
  SelectedGripsAndHolds({
    Key key,
    @required this.board,
    @required this.currentHold,
    @required this.totalHolds,
    @required this.leftGrip,
    @required this.leftGripBoardHold,
    @required this.rightGrip,
    @required this.rightGripBoardHold,
  }) : super(key: key);

  final Board board;
  final int currentHold;
  final int totalHolds;
  final Grip leftGrip;
  final BoardHold leftGripBoardHold;
  final Grip rightGrip;
  final BoardHold rightGripBoardHold;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double _boardHeight = constraints.maxWidth / board.aspectRatio;
        final Size _boardSize = Size(constraints.maxWidth, _boardHeight);
        final _gripHeight = _boardHeight * board.handToBoardHeightRatio;
        final _boardWithGripsHeight = _boardHeight + _gripHeight;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hold $currentHold / $totalHolds',
              style: styles.Staatliches.xlBlack,
            ),
            Divider(height: styles.Measurements.l),
            Container(
              height: _boardWithGripsHeight,
              child: BoardWithGrips(
                customBoardHoldImages: board.customBoardHoldImages?.toList(),
                boardSize: _boardSize,
                boardImageAsset: board.imageAsset,
                gripHeight: _gripHeight,
                leftGrip: leftGrip,
                leftGripBoardHold: leftGripBoardHold,
                rightGrip: rightGrip,
                rightGripBoardHold: rightGripBoardHold,
              ),
            ),
            BoardHoldInfo(
              leftGripBoardHold: leftGripBoardHold,
              rightGripBoardHold: rightGripBoardHold,
              leftGrip: leftGrip,
              rightGrip: rightGrip,
            ),
            Divider(height: styles.Measurements.xxl),
          ],
        );
      },
    );
  }
}
