import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

class LandscapeInfo extends StatelessWidget {
  LandscapeInfo(
      {this.addedWeight,
      this.weightUnit,
      this.leftGrip,
      this.leftGripBoardHold,
      this.rightGrip,
      this.rightGripBoardHold});

  final double addedWeight;
  final WeightSystem weightUnit;
  final Grip leftGrip;
  final BoardHold leftGripBoardHold;
  final Grip rightGrip;
  final BoardHold rightGripBoardHold;

  @override
  Widget build(BuildContext context) {
    String leftGripName;
    String leftHoldInfo;
    if (leftGrip != null && leftGripBoardHold != null) {
      leftGripName = leftGrip.description;
      if (leftGripBoardHold.holdType == HoldType.pocket) {
        final String depth = leftGripBoardHold.depth.toString();
        leftHoldInfo = '$depth MM';
      } else {
        leftHoldInfo = leftGripBoardHold.holdType.toString();
      }
    }

    String rightGripName;
    String rightHoldInfo;
    if (rightGrip != null && rightGripBoardHold != null) {
      rightGripName = rightGrip.description;
      if (rightGripBoardHold.holdType == HoldType.pocket) {
        final String depth = rightGripBoardHold.depth.toString();
        rightHoldInfo = '$depth MM';
      } else {
        rightHoldInfo = rightGripBoardHold.holdType.toString();
      }
    }

    final String _addedWeightPrefix = addedWeight > 0 ? '+' : '';

    return Container(
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            color: styles.Colors.darkGray,
            boxShadow: [styles.kBoxShadow]),
        padding: EdgeInsets.symmetric(
            vertical: styles.Measurements.xs,
            horizontal: styles.Measurements.m),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              fit: StackFit.loose,
              children: <Widget>[
                if (leftGripName != null && leftHoldInfo != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            leftGripName,
                            style: styles.Staatliches.lWhite,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            leftHoldInfo,
                            style: styles.Staatliches.lWhite,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (addedWeight != null && addedWeight != 0.0)
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        '$_addedWeightPrefix $addedWeight ${weightUnit.unit}',
                        style: styles.Staatliches.xlWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (rightGripName != null && rightHoldInfo != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            rightGripName,
                            style: styles.Staatliches.lWhite,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            rightHoldInfo,
                            style: styles.Staatliches.lWhite,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ));
  }
}
