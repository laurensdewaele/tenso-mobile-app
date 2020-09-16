import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/board/board_hold_info.dart';
import 'package:tenso_app/modules/board/board_with_grips.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class SelectedGripsAndHolds extends StatelessWidget {
  SelectedGripsAndHolds({
    Key key,
    @required this.board,
    @required this.leftGrip,
    @required this.leftGripBoardHold,
    @required this.rightGrip,
    @required this.rightGripBoardHold,
  }) : super(key: key);

  final Board board;
  final Grip leftGrip;
  final BoardHold leftGripBoardHold;
  final Grip rightGrip;
  final BoardHold rightGripBoardHold;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(height: styles.Measurements.l),
        BoardWithGrips(
          clipped: false,
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
