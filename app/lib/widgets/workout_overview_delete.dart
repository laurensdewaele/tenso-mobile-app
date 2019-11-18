import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/inner_box_shadow.dart';

class DeleteAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        Container(
            decoration: const BoxDecoration(
                color: styles.Colors.primary,
                borderRadius: BorderRadius.only(
                    topRight: styles.kAppBorderRadius,
                    bottomRight: styles.kAppBorderRadius)),
            child: Center(
                child: Text(
              'DELETE',
              style: styles.Typography.indicatorWhite,
            ))),
        InnerBoxShadow(position: InnerBoxShadowRadiusPosition.right),
      ],
    );
  }
}
