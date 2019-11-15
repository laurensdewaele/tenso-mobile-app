import 'package:flutter/material.dart';

import 'package:app/styles/styles.dart' as styles;

class Button extends StatelessWidget {
  const Button({@required this.text, @required this.handleClick});

  final String text;
  final VoidCallback handleClick;

  void _onClick() {
    handleClick();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onClick,
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: styles.kAppBorderRadiusAll,
                color: styles.Colors.primary,
                boxShadow: [styles.kAppBoxShadow]),
            padding: EdgeInsets.symmetric(
                vertical: styles.Measurements.xs,
                horizontal: styles.Measurements.m),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                  flex: 2,
                  child: Text(
                    text,
                    style: styles.Typography.button,
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                  flex: 1,
                  child: Icon(Icons.keyboard_arrow_right,
                      size: styles.Measurements.l, color: styles.Colors.white))
            ])));
  }
}
