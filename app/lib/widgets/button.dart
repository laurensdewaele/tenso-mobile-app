import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icon.dart';
import 'package:flutter/cupertino.dart' hide Icon;

class Button extends StatelessWidget {
  const Button({
    @required this.text,
    @required this.handleTap,
    this.backgroundColor = styles.Colors.primary,
    this.leadingIcon,
    this.leadingIconTextCentered = false,
    this.displayBackground = true,
    this.width = double.infinity,
    this.height = styles.kStandardButtonHeight,
    this.small = false,
  });

  final Color backgroundColor;
  final String text;
  final VoidCallback handleTap;
  final double width;
  final double height;
  final Icon leadingIcon;
  final bool leadingIconTextCentered;
  final bool displayBackground;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final bool _hasIcon = leadingIcon != null ? true : false;
    final Color _iconColor =
        displayBackground == true ? styles.Colors.white : styles.Colors.black;
    final TextStyle _textStyle = displayBackground == true
        ? styles.Staatliches.xlWhite
        : styles.Staatliches.xlBlack;
    final BoxDecoration _boxDecoration = displayBackground == true
        ? BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            color: backgroundColor,
            boxShadow: [styles.kBoxShadow])
        : BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            color: styles.Colors.translucent,
          );

    final iconRow = leadingIconTextCentered == true
        ? _ButtonIconCenteredText(
            text: text,
            textStyle: _textStyle,
            leadingIcon: leadingIcon,
            iconColor: _iconColor,
          )
        : _ButtonIconRow(
            text: text,
            textStyle: _textStyle,
            leadingIcon: leadingIcon,
            iconColor: _iconColor,
          );

    return Transform.scale(
      scale: small ? 0.8 : 1,
      child: GestureDetector(
          onTap: handleTap,
          child: Container(
              width: width,
              height: height,
              decoration: _boxDecoration,
              child: _hasIcon
                  ? iconRow
                  : Center(
                      child: Text(
                        text,
                        style: _textStyle,
                        textAlign: TextAlign.center,
                      ),
                    ))),
    );
  }
}

class _ButtonIconRow extends StatelessWidget {
  const _ButtonIconRow(
      {@required this.text,
      @required this.leadingIcon,
      @required this.textStyle,
      @required this.iconColor});

  final String text;
  final TextStyle textStyle;
  final Icon leadingIcon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        leadingIcon,
        Divider(width: styles.Measurements.m),
        Text(
          text,
          style: textStyle,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class _ButtonIconCenteredText extends StatelessWidget {
  const _ButtonIconCenteredText(
      {Key key,
      @required this.text,
      @required this.leadingIcon,
      @required this.textStyle,
      @required this.iconColor})
      : super(key: key);

  final String text;
  final TextStyle textStyle;
  final Icon leadingIcon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: styles.Measurements.m,
              ),
              child: leadingIcon,
            )),
        Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
