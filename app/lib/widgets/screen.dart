import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  const Screen(
      {@required this.gradientStartColor,
      @required this.gradientStopColor,
      @required this.child,
      this.padding});

  final Color gradientStartColor;
  final Color gradientStopColor;
  final Widget child;
  final EdgeInsets padding;

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
        padding: padding,
        child: this.child,
      )),
    );
  }
}
