import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board/board_with_grips.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/execution/indicator_tabs.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class ExecutionPortrait extends StatelessWidget {
  ExecutionPortrait({
    Key key,
    @required this.handleReadyTap,
    @required this.isStopwatch,
    @required this.primaryColor,
    @required this.seconds,
    @required this.holdLabel,
    @required this.board,
    @required this.leftGrip,
    @required this.leftGripBoardHold,
    @required this.rightGrip,
    @required this.rightGripBoardHold,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalHangsPerSet,
    @required this.currentHangPerSet,
    @required this.weightSystem,
    @required this.title,
    @required this.addedWeight,
  }) : super(key: key);

  final VoidCallback handleReadyTap;
  final bool isStopwatch;
  final Color primaryColor;
  final int seconds;
  final String holdLabel;
  final Board board;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final int totalSets;
  final int currentSet;
  final int totalHangsPerSet;
  final int currentHangPerSet;
  final WeightSystem weightSystem;
  final double addedWeight;
  final String title;

  @override
  Widget build(BuildContext context) {
    final String _currentSet = currentSet.toString();
    final String _totalSets = totalSets.toString();
    final String _titleText = title;
    final String _addedWeight = addedWeight.toString();
    final String _addedWeightPrefix = addedWeight > 0 ? '+' : '';

    final Widget _topWidget = isStopwatch
        ? Button(
            text: 'ready',
            handleTap: handleReadyTap,
            backgroundColor: styles.Colors.blue,
            leadingIcon: icons.playIconWhiteL)
        : Text(
            _titleText,
            style: styles.Staatliches.mWhite,
          );

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: 55,
          child: Center(child: _topWidget),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    seconds.toString(),
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
                  height: styles.Measurements.m,
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
          height: styles.Measurements.xxl,
        ),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (totalSets > 1)
                Text(
                  'set $_currentSet / $_totalSets',
                  style: styles.Staatliches.mWhite,
                ),
              if (totalSets > 1)
                Divider(
                  height: styles.Measurements.m,
                ),
              IndicatorTabs(
                count: totalHangsPerSet,
                active: currentHangPerSet,
                primaryColor: primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
