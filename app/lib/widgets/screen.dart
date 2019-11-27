import 'package:flutter/material.dart';

import 'package:app/styles/styles.dart' as styles;

class Screen extends StatelessWidget {
  const Screen(
      {@required this.gradientStartColor,
      @required this.gradientStopColor,
      @required this.child});

  final Color gradientStartColor;
  final Color gradientStopColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [this.gradientStartColor, this.gradientStopColor]),
      ),
      child: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [this.gradientStartColor, this.gradientStopColor]),
        ),
        padding: EdgeInsets.all(styles.Measurements.m),
        child: this.child,
      )),
    );
  }
}
