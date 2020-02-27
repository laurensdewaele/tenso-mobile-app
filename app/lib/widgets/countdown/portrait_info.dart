import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class PortraitInfo extends StatelessWidget {
  PortraitInfo({this.addedWeightText});

  final String addedWeightText;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            color: styles.Colors.darkGray,
            boxShadow: [styles.kBoxShadow]),
        padding: EdgeInsets.symmetric(
            vertical: styles.Measurements.xs,
            horizontal: styles.Measurements.m),
        child: Text(
          addedWeightText,
          style: styles.Typography.countdownAddedWeight,
          textAlign: TextAlign.center,
        ));
  }
}
