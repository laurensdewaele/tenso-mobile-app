import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/inner_box_shadow.dart';

class WorkoutOverviewEditAction extends StatelessWidget {
  WorkoutOverviewEditAction({this.handleTap});

  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Stack(overflow: Overflow.clip, children: <Widget>[
        Container(
            decoration: const BoxDecoration(
                color: styles.Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: styles.kBorderRadius,
                    bottomLeft: styles.kBorderRadius)),
            child: Center(
                child: Text(
              'EDIT',
              style: styles.Typography.indicatorWhite,
            ))),
        InnerBoxShadow(position: InnerBoxShadowRadiusPosition.left)
      ]),
    );
  }
}
