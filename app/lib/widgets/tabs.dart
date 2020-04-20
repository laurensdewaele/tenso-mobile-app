import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class Tabs extends StatelessWidget {
  Tabs(
      {Key key,
      this.primaryColor = styles.Colors.primary,
      this.textPrimaryColor = styles.Lato.xsPrimary,
      @required this.leftText,
      @required this.rightText,
      @required this.handleLeftTap,
      @required this.handleRightTap,
      @required this.isLeftSelected,
      @required this.isRightSelected})
      : super(key: key);

  final TextStyle textPrimaryColor;
  final Color primaryColor;
  final String leftText;
  final String rightText;
  final bool isLeftSelected;
  final bool isRightSelected;
  final VoidCallback handleLeftTap;
  final VoidCallback handleRightTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: styles.Measurements.l,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: styles.kBorderRadiusAll),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: handleLeftTap,
              child: Container(
                decoration: BoxDecoration(
                    color: isLeftSelected
                        ? primaryColor
                        : styles.Colors.translucent),
                child: Center(
                    child: Baseline(
                  baseline: 14,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(leftText,
                      style: isLeftSelected
                          ? styles.Lato.xsWhite
                          : textPrimaryColor),
                )),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: handleRightTap,
              child: Container(
                decoration: BoxDecoration(
                    color: isRightSelected
                        ? primaryColor
                        : styles.Colors.translucent),
                child: Center(
                    child: Baseline(
                  baseline: 14,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(rightText,
                      style: isRightSelected
                          ? styles.Lato.xsWhite
                          : textPrimaryColor),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
