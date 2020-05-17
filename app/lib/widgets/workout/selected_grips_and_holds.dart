import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board/board_hold_info.dart';
import 'package:app/widgets/board/board_with_grips.dart';
import 'package:app/widgets/divider.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hold $currentHold / $totalHolds',
          style: styles.Staatliches.xlBlack,
        ),
        Divider(height: styles.Measurements.l),
        BoardWithGrips(
          withFixedHeight: true,
          boardImageAssetWidth: board.imageAssetWidth,
          customBoardHoldImages: board.customBoardHoldImages?.toList(),
          boardAspectRatio: board.aspectRatio,
          handToBoardHeightRatio: board.handToBoardHeightRatio,
          boardImageAsset: board.imageAsset,
          leftGrip: leftGrip,
          leftGripBoardHold: leftGripBoardHold,
          rightGrip: rightGrip,
          rightGripBoardHold: rightGripBoardHold,
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
  }
}
