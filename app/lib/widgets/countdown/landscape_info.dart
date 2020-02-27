import 'dart:ui';

import 'package:app/models/hold_type.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/styles/styles.dart' as styles;

class LandscapeInfo extends StatelessWidget {
  LandscapeInfo(
      {this.addedWeightText,
      this.leftGrip,
      this.leftGripBoardHold,
      this.rightGrip,
      this.rightGripBoardHold});

  final String addedWeightText;
  final Grip leftGrip;
  final BoardHold leftGripBoardHold;
  final Grip rightGrip;
  final BoardHold rightGripBoardHold;

  @override
  Widget build(BuildContext context) {
    final String leftGripName = leftGrip.description;
    String leftHoldInfo;
    if (leftGripBoardHold.holdType == HoldType.pocket ||
        leftGripBoardHold.holdType == HoldType.roundedPocket) {
      leftHoldInfo = leftGripBoardHold.pocketDepth.toString();
    } else {
      leftHoldInfo = leftGripBoardHold.holdType.toString();
    }

    final String rightGripName = rightGrip.description;
    String rightHoldInfo;
    if (rightGripBoardHold.holdType == HoldType.pocket ||
        rightGripBoardHold.holdType == HoldType.roundedPocket) {
      rightHoldInfo = rightGripBoardHold.pocketDepth.toString();
    } else {
      rightHoldInfo = rightGripBoardHold.holdType.toString();
    }

    return Container(
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            color: styles.Colors.darkGray,
            boxShadow: [styles.kBoxShadow]),
        padding: EdgeInsets.symmetric(
            vertical: styles.Measurements.xs,
            horizontal: styles.Measurements.m),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  leftGripName,
                  style: styles.Typography.countdownLandscapeInfo,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '$leftHoldInfo MM',
                  style: styles.Typography.countdownLandscapeInfo,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Text(
              addedWeightText,
              style: styles.Typography.countdownAddedWeight,
              textAlign: TextAlign.center,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  rightGripName,
                  style: styles.Typography.countdownLandscapeInfo,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '$rightHoldInfo MM',
                  style: styles.Typography.countdownLandscapeInfo,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ],
        ));
  }
}
