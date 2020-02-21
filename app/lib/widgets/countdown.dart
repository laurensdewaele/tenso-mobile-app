import 'package:flutter/cupertino.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/unit.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/indicator_tabs.dart';

class Countdown extends StatelessWidget {
  Countdown({
    Key key,
    @required this.animatedBackgroundHeightFactor,
    @required this.primaryColor,
    @required this.title,
    @required this.remainingSeconds,
    @required this.holdLabel,
    @required this.board,
    this.leftGrip,
    this.leftGripBoardHold,
    this.rightGrip,
    this.rightGripBoardHold,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalHangsPerSet,
    @required this.currentHang,
    @required this.unit,
    this.addedWeight,
  }) : super(key: key);

  final double animatedBackgroundHeightFactor;
  final Color primaryColor;
  final String title;
  final int remainingSeconds;
  final String holdLabel;
  final Board board;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final int totalSets;
  final int currentSet;
  final int totalHangsPerSet;
  final int currentHang;
  final Unit unit;
  final double addedWeight;

  @override
  Widget build(BuildContext context) {
    final String unitText = unit == Unit.metric ? 'kg' : 'pounds';
    final String addedWeightText = '+ $addedWeight $unitText';

    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(color: styles.Colors.black),
      ),
      FractionallySizedBox(
          heightFactor: animatedBackgroundHeightFactor,
          child: Container(
            decoration: BoxDecoration(color: primaryColor),
          )),
      SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Divider(
              height: styles.Measurements.m,
            ),
            Text(
              title,
              style: styles.Typography.topNavigationTitleWhite,
            ),
            Divider(
              height: styles.Measurements.xxl,
            ),
            Expanded(child: OrientationBuilder(
              builder: (context, orientation) {
                final List<Widget> children = [
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        remainingSeconds.toString(),
                        style: styles.Typography.countdownTimer,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: styles.Colors.orange),
                    ),
                  ),
                ];
                if (orientation == Orientation.portrait) {
                  return Column(
                      mainAxisSize: MainAxisSize.max, children: children);
                } else {
                  return Row(
                      mainAxisSize: MainAxisSize.max, children: children);
                }
              },
            )),
            if (addedWeight != null)
              Divider(
                height: styles.Measurements.m,
              ),
            if (addedWeight != null)
              Text(
                addedWeightText,
                style: styles.Typography.countdownAddedWeight,
              ),
            Divider(
              height: styles.Measurements.xxl,
            ),
            if (totalSets > 1)
              Text(
                'set $currentSet / $totalSets',
                style: styles.Typography.topNavigationTitleWhite,
              ),
            if (totalSets > 1)
              Divider(
                height: styles.Measurements.m,
              ),
            IndicatorTabs(
              count: totalHangsPerSet,
              active: currentHang,
              primaryColor: primaryColor,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
          ],
        ),
      )
    ]);
  }
}
