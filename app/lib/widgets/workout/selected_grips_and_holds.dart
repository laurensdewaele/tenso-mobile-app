import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board_with_grips.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/workout/board_hold_info.dart';

class SelectedGripsAndHolds extends StatelessWidget {
  SelectedGripsAndHolds({
    Key key,
    @required this.board,
    @required this.currentHold,
    @required this.holdCount,
    @required this.leftGrip,
    @required this.leftGripBoardHold,
    @required this.rightGrip,
    @required this.rightGripBoardHold,
  }) : super(key: key);

  final Board board;
  final int currentHold;
  final int holdCount;
  final Grip leftGrip;
  final BoardHold leftGripBoardHold;
  final Grip rightGrip;
  final BoardHold rightGripBoardHold;

  @override
  Widget build(BuildContext context) {
    final String _currentHoldString = (currentHold + 1).toString();
    final String _totalHoldsString = holdCount.toString();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double _boardHeight = constraints.maxWidth / board.aspectRatio;
        final gripHeight = _boardHeight * board.handToBoardHeightRatio;
        final _boardWithGripsHeight = _boardHeight + gripHeight;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hold $_currentHoldString / $_totalHoldsString',
              style: styles.Staatliches.xlBlack,
            ),
            Divider(height: styles.Measurements.l),
            Container(
              height: _boardWithGripsHeight,
              child: BoardWithGrips(
                board: board,
                leftGrip: leftGrip,
                leftGripBoardHold: leftGripBoardHold,
                orientation: MediaQuery.of(context).orientation,
                reportTotalHeight: (_) {},
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
