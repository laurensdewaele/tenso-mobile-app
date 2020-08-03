import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/inner_box_shadow.dart';

class ViewAction extends StatelessWidget {
  ViewAction({this.handleTap});

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
              'view',
              style: styles.Staatliches.lWhite,
            ))),
        InnerBoxShadow(position: InnerBoxShadowRadiusPosition.left)
      ]),
    );
  }
}