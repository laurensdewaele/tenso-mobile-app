import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board/board_with_grips.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/execution/indicator_tabs.dart';
import 'package:app/widgets/execution/landscape_info.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class ExecutionLandscape extends StatelessWidget {
  const ExecutionLandscape({
    @required this.displaySeconds,
    @required this.handleReadyTap,
    @required this.isVariableRestTimer,
    @required this.primaryColor,
    @required this.holdLabel,
    @required this.board,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.weightSystem,
    @required this.addedWeight,
    @required this.title,
    @required this.currentGroup,
    @required this.totalGroups,
  });

  final int displaySeconds;
  final VoidCallback handleReadyTap;
  final bool isVariableRestTimer;
  final Color primaryColor;
  final String holdLabel;
  final Board board;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final WeightSystem weightSystem;
  final double addedWeight;
  final String title;
  final int currentGroup;
  final int totalGroups;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Text(
                title,
                style: styles.Staatliches.mWhite,
              ),
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            Expanded(
                child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                BoardWithGrips(
                  clipped: false,
                  withFixedHeight: false,
                  handToBoardHeightRatio: board.handToBoardHeightRatio,
                  boardAspectRatio: board.aspectRatio,
                  boardImageAssetWidth: board.imageAssetWidth,
                  customBoardHoldImages: board.customBoardHoldImages?.toList(),
                  boardImageAsset: board.imageAsset,
                  leftGripBoardHold: leftGripBoardHold,
                  rightGripBoardHold: rightGripBoardHold,
                  rightGrip: rightGrip,
                  leftGrip: leftGrip,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: LandscapeInfo(
                    addedWeight: addedWeight,
                    weightSystem: weightSystem,
                    leftGrip: leftGrip,
                    leftGripBoardHold: leftGripBoardHold,
                    rightGrip: rightGrip,
                    rightGripBoardHold: rightGripBoardHold,
                  ),
                ),
              ],
            )),
            Divider(
              height: styles.Measurements.m,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Divider(
                  height: styles.Measurements.m,
                ),
                IndicatorTabs(
                  count: totalGroups,
                  active: currentGroup,
                  primaryColor: primaryColor,
                )
              ],
            )
          ],
        ),
        Center(
          child: AutoSizeText(
            displaySeconds.toString(),
            style: styles.Staatliches.countdownTimerTranslucent,
          ),
        ),
        if (isVariableRestTimer == true)
          Align(
            alignment: Alignment.topCenter,
            child: Button(
                width: styles.Measurements.xxl * 5,
                text: 'ready',
                handleTap: handleReadyTap,
                backgroundColor: styles.Colors.blue,
                leadingIcon: icons.playIconWhiteL),
          )
      ],
    );
  }
}
