import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board_with_grips.dart';
import 'package:app/widgets/execution/indicator_tabs.dart';
import 'package:app/widgets/execution/landscape_info.dart';
import 'package:app/widgets/divider.dart';

class Landscape extends StatelessWidget {
  Landscape({
    Key key,
    @required this.primaryColor,
    @required this.holdLabel,
    @required this.board,
    @required this.leftGrip,
    @required this.leftGripBoardHold,
    @required this.rightGrip,
    @required this.rightGripBoardHold,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalHangsPerSet,
    @required this.currentHang,
    @required this.weightUnit,
    @required this.orientation,
    @required this.title,
    this.addedWeight,
  }) : super(key: key);

  final Color primaryColor;
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
  final WeightUnit weightUnit;
  final double addedWeight;
  final Orientation orientation;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              orientation: orientation,
              leftGripBoardHold: leftGripBoardHold,
              rightGripBoardHold: rightGripBoardHold,
              reportTotalHeight: (double h) {},
              board: board,
              rightGrip: rightGrip,
              leftGrip: leftGrip,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LandscapeInfo(
                addedWeight: addedWeight,
                weightUnit: weightUnit,
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
            if (totalSets > 1)
              Text(
                'set $currentSet / $totalSets',
                style: styles.Staatliches.mWhite,
              ),
            if (totalSets > 1)
              Divider(
                width: styles.Measurements.m,
              ),
            IndicatorTabs(
              count: totalHangsPerSet,
              active: currentHang,
              primaryColor: primaryColor,
            )
          ],
        )
      ],
    );
  }
}
