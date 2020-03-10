import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/inner_box_shadow.dart';

class WorkoutOverviewViewAction extends StatelessWidget {
  WorkoutOverviewViewAction({this.handleTap});

  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Stack(overflow: Overflow.clip, children: <Widget>[
        Container(
            decoration: const BoxDecoration(
                color: styles.Colors.gray,
                borderRadius: BorderRadius.only(
                    topLeft: styles.kBorderRadius,
                    bottomLeft: styles.kBorderRadius)),
            child: Center(
                child: Text(
              'VIEW',
              style: styles.Staatliches.lWhite,
            ))),
        InnerBoxShadow(position: InnerBoxShadowRadiusPosition.left)
      ]),
    );
  }
}
