import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class Divider extends StatelessWidget {
  Divider({this.height = styles.Measurements.m});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
