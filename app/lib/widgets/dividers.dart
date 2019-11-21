import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

final Map<styles.MeasurementSizes, double> measurementsMap = {
  styles.MeasurementSizes.xs: styles.Measurements.xs,
  styles.MeasurementSizes.s: styles.Measurements.s,
  styles.MeasurementSizes.m: styles.Measurements.m,
  styles.MeasurementSizes.l: styles.Measurements.l,
  styles.MeasurementSizes.xl: styles.Measurements.xl,
  styles.MeasurementSizes.xxl: styles.Measurements.xxl,
};

class Divider extends StatelessWidget {
  Divider({this.size = styles.MeasurementSizes.m})
      : height = measurementsMap[size];

  final styles.MeasurementSizes size;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
