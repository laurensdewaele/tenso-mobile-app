import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/board/board_with_grips.dart';
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/execution/execution_indicator.dart';
import 'package:tenso_app/widgets/icons.dart' as icons;

class ExecutionPortrait extends StatelessWidget {
  const ExecutionPortrait({
    @required this.handleReadyTap,
    @required this.isVariableRestTimer,
    @required this.primaryColor,
    @required this.displaySeconds,
    @required this.holdLabel,
    @required this.board,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.weightSystem,
    @required this.addedWeight,
    @required this.title,
    @required this.totalReps,
    @required this.currentRep,
    @required this.currentSet,
    @required this.totalSets,
    @required this.currentGroup,
    @required this.totalGroups,
  });

  final VoidCallback handleReadyTap;
  final bool isVariableRestTimer;
  final Color primaryColor;
  final int displaySeconds;
  final String holdLabel;
  final Board board;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final WeightSystem weightSystem;
  final double addedWeight;
  final String title;
  final int totalReps;
  final int currentRep;
  final int currentSet;
  final int totalSets;
  final int currentGroup;
  final int totalGroups;

  @override
  Widget build(BuildContext context) {
    final String _addedWeight = addedWeight.toString();
    final String _addedWeightPrefix = addedWeight > 0 ? '+' : '';

    final Widget _topWidget = isVariableRestTimer
        ? Column(
            children: <Widget>[
              Button(
                  text: 'ready',
                  handleTap: handleReadyTap,
                  backgroundColor: styles.Colors.blue,
                  leadingIcon: icons.playIconWhiteL),
              GestureDetector(
                onTap: handleReadyTap,
                child: Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(color: styles.Colors.translucent),
                ),
              )
            ],
          )
        : Text(
            title,
            style: styles.Staatliches.mWhite,
          );

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _topWidget,
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    displaySeconds.toString(),
                    style: styles.Staatliches.countdownTimer,
                  ),
                ),
              ),
              Column(children: [
                Text(
                  holdLabel,
                  style: styles.Staatliches.mWhite,
                ),
                Divider(
                  height: styles.Measurements.xs,
                ),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final double _boardHeight =
                        constraints.maxWidth / board.aspectRatio;
                    final _gripHeight =
                        _boardHeight * board.handToBoardHeightRatio;
                    final _boardWithGripsHeight = _boardHeight + _gripHeight;
                    return Container(
                      height: _boardWithGripsHeight,
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          BoardWithGrips(
                            clipped: false,
                            withFixedHeight: false,
                            handToBoardHeightRatio:
                                board.handToBoardHeightRatio,
                            boardAspectRatio: board.aspectRatio,
                            boardImageAssetWidth: board.imageAssetWidth,
                            customBoardHoldImages:
                                board.customBoardHoldImages?.toList(),
                            boardImageAsset: board.imageAsset,
                            leftGripBoardHold: leftGripBoardHold,
                            rightGripBoardHold: rightGripBoardHold,
                            rightGrip: rightGrip,
                            leftGrip: leftGrip,
                          ),
                          if (addedWeight != null && addedWeight != 0.0)
                            Container(
                              height: _boardWithGripsHeight,
                              width: double.infinity,
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: styles.kBorderRadiusAll,
                                          color: styles.Colors.darkGray,
                                          boxShadow: [styles.kBoxShadow]),
                                      padding: EdgeInsets.symmetric(
                                          vertical: styles.Measurements.xs,
                                          horizontal: styles.Measurements.m),
                                      child: Text(
                                        '$_addedWeightPrefix $_addedWeight ${weightSystem.unit}',
                                        style: styles.Staatliches.xlWhite,
                                        textAlign: TextAlign.center,
                                      ))),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ]),
            ],
          ),
        ),
        Divider(
          height: styles.Measurements.m,
        ),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ExecutionIndicator(
                orientation: Orientation.portrait,
                currentRep: currentRep,
                totalReps: totalReps,
                currentSet: currentSet,
                totalSets: totalSets,
                currentGroup: currentGroup,
                totalGroups: totalGroups,
                primaryColor: primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
