import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class Divider extends StatelessWidget {
  const Divider();

  final double height = styles.Measurements.m;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class SectionDivider extends StatelessWidget {
  const SectionDivider();

  final double height = styles.Measurements.l;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
