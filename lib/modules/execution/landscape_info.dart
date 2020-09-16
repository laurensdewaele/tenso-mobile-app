import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class LandscapeInfo extends StatelessWidget {
  LandscapeInfo(
      {this.addedWeight,
      this.weightSystem,
      this.leftGrip,
      this.leftGripBoardHold,
      this.rightGrip,
      this.rightGripBoardHold});

  final double addedWeight;
  final WeightSystem weightSystem;
  final Grip leftGrip;
  final BoardHold leftGripBoardHold;
  final Grip rightGrip;
  final BoardHold rightGripBoardHold;

  @override
  Widget build(BuildContext context) {
    String leftGripDescription = leftGrip?.description;
    String leftHoldInfo;
    if (leftGripBoardHold != null) {
      final String holdType = leftGripBoardHold.holdType.toString();
      leftHoldInfo = holdType;

      if (leftGripBoardHold.holdType == HoldType.pocket ||
          leftGripBoardHold.holdType == HoldType.edge) {
        final String depth = leftGripBoardHold.depth?.toString();
        if (depth != null) {
          leftHoldInfo = '$holdType $depth MM';
        }
      }

      if (leftGripBoardHold.holdType == HoldType.sloper) {
        final String sloperDegrees =
            leftGripBoardHold.sloperDegrees?.toString();
        if (sloperDegrees != null) {
          leftHoldInfo = '$holdType $sloperDegrees °';
        }
      }
    }

    String rightGripDescription = rightGrip?.description;
    String rightHoldInfo;
    if (rightGripBoardHold != null) {
      final String holdType = rightGripBoardHold.holdType.toString();
      rightHoldInfo = holdType;

      if (rightGripBoardHold.holdType == HoldType.pocket ||
          rightGripBoardHold.holdType == HoldType.edge) {
        final String depth = rightGripBoardHold.depth?.toString();
        if (depth != null) {
          rightHoldInfo = '$holdType $depth MM';
        }
      }

      if (rightGripBoardHold.holdType == HoldType.sloper) {
        final String sloperDegrees =
            rightGripBoardHold.sloperDegrees?.toString();
        if (sloperDegrees != null) {
          rightHoldInfo = '$holdType $sloperDegrees °';
        }
      }
    }

    final String _addedWeightPrefix = addedWeight > 0 ? '+' : '';

    return Container(
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            color: styles.Colors.darkGrayTranslucent,
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
                if (leftGripDescription != null && leftHoldInfo != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            leftGripDescription,
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
                        '$_addedWeightPrefix $addedWeight ${weightSystem.unit}',
                        style: styles.Staatliches.xlWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (rightGripDescription != null && rightHoldInfo != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            rightGripDescription,
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
