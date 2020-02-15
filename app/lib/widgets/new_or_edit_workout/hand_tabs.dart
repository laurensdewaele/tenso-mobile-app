import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class HandTabs extends StatelessWidget {
  HandTabs(
      {Key key,
      this.primaryColor = styles.Colors.primary,
      this.textPrimaryColor = styles.Typography.textRed,
      this.handleLeftHandTap,
      this.handleRightHandTap,
      this.isLeftHandSelected,
      this.isRightHandSelected})
      : super(key: key);

  final TextStyle textPrimaryColor;
  final Color primaryColor;
  final bool isLeftHandSelected;
  final bool isRightHandSelected;
  final VoidCallback handleLeftHandTap;
  final VoidCallback handleRightHandTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: styles.Measurements.l,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: styles.kBorderRadiusAll),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: handleLeftHandTap,
              child: Container(
                decoration: BoxDecoration(
                    color: isLeftHandSelected
                        ? primaryColor
                        : styles.Colors.translucent),
                child: Center(
                    child: Text('Left',
                        style: isLeftHandSelected
                            ? styles.Typography.textBgWhite
                            : textPrimaryColor)),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: handleRightHandTap,
              child: Container(
                decoration: BoxDecoration(
                    color: isRightHandSelected
                        ? primaryColor
                        : styles.Colors.translucent),
                child: Center(
                    child: Text('Right',
                        style: isRightHandSelected
                            ? styles.Typography.textBgWhite
                            : textPrimaryColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
