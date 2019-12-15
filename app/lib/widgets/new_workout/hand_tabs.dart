import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

enum HandTabTypes { leftHand, rightHand }

class HandTabs extends StatelessWidget {
  HandTabs(
      {Key key,
      this.handleLeftHandTap,
      this.handleRightHandTap,
      this.isLeftHandSelected,
      this.isRightHandSelected})
      : super(key: key);

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
          border: Border.all(color: styles.Colors.primary),
          borderRadius: styles.kBorderRadiusAll),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: handleLeftHandTap,
              child: Container(
                decoration: BoxDecoration(
                    color: isLeftHandSelected
                        ? styles.Colors.primary
                        : styles.Colors.translucent),
                child: Center(
                    child: Text('Left',
                        style: isLeftHandSelected
                            ? styles.Typography.textBgWhite
                            : styles.Typography.textPrimary)),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: handleRightHandTap,
              child: Container(
                decoration: BoxDecoration(
                    color: isRightHandSelected
                        ? styles.Colors.primary
                        : styles.Colors.translucent),
                child: Center(
                    child: Text('Right',
                        style: isRightHandSelected
                            ? styles.Typography.textBgWhite
                            : styles.Typography.textPrimary)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
