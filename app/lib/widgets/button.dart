import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/icon.dart';

class Button extends StatelessWidget {
  const Button(
      {@required this.text,
      @required this.handleTap,
      this.displayIcon = true,
      this.backgroundColor = styles.Colors.primary,
      this.textStyle = styles.Typography.buttonWhite,
      this.width = double.infinity});

  final Color backgroundColor;
  final TextStyle textStyle;
  final String text;
  final VoidCallback handleTap;
  final bool displayIcon;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleTap,
        child: Container(
            width: width,
            decoration: BoxDecoration(
                borderRadius: styles.kBorderRadiusAll,
                color: backgroundColor,
                boxShadow: [styles.kBoxShadow]),
            padding: EdgeInsets.symmetric(
                vertical: styles.Measurements.xs,
                horizontal: styles.Measurements.m),
            child: displayIcon
                ? _ButtonIconRow(text: text)
                : Text(
                    text,
                    style: textStyle,
                    textAlign: TextAlign.center,
                  )));
  }
}

class _ButtonIconRow extends StatelessWidget {
  const _ButtonIconRow({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: Text(
          text,
          style: styles.Typography.buttonWhite,
          textAlign: TextAlign.center,
        )),
        Align(
          alignment: Alignment.centerRight,
          child: Icon(
              iconData: CupertinoIcons.forward,
              size: styles.Measurements.l,
              color: styles.Colors.white),
        )
      ],
    );
  }
}

class TextButton extends StatelessWidget {
  const TextButton({@required this.text, @required this.handleTap});

  final String text;
  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleTap,
        child: Container(
            decoration: BoxDecoration(color: styles.Colors.translucent),
            width: double.infinity,
            child: Text(
              text,
              style: styles.Typography.buttonBlack,
              textAlign: TextAlign.center,
            )));
  }
}
