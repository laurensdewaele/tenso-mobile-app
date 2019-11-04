import 'package:app/styles/styles.dart';
import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Color gradientStartColor;
  final Color gradientStopColor;
  final Widget child;

  const Screen(
      {@required this.gradientStartColor,
      @required this.gradientStopColor,
      @required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: this.child,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [this.gradientStartColor, this.gradientStopColor])),
      padding: (EdgeInsets.all(Spacings.regular)),
    ));
  }
}
