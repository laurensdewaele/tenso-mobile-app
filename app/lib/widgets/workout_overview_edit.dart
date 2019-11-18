import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/inner_box_shadow.dart';

class EditAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(overflow: Overflow.clip, children: <Widget>[
      Container(
          decoration: const BoxDecoration(
              color: styles.Colors.difficultyBlue,
              borderRadius: BorderRadius.only(
                  topLeft: styles.kAppBorderRadius,
                  bottomLeft: styles.kAppBorderRadius)),
          child: Center(
              child: Text(
            'EDIT',
            style: styles.Typography.indicatorWhite,
          ))),
      InnerBoxShadow(position: InnerBoxShadowRadiusPosition.left)
    ]);
  }
}
