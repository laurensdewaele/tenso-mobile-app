import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/inner_box_shadow.dart';

class WorkoutOverviewDeleteAction extends StatelessWidget {
  WorkoutOverviewDeleteAction({this.handleTap});

  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Stack(
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
      ),
    );
  }
}
