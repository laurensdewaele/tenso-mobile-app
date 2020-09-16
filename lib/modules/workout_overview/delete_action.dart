import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/inner_box_shadow.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class DeleteAction extends StatelessWidget {
  const DeleteAction();

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        Container(
            decoration: const BoxDecoration(
                color: styles.Colors.primary,
                borderRadius: BorderRadius.only(
                    topRight: styles.kBorderRadius,
                    bottomRight: styles.kBorderRadius)),
            child: Center(
                child: Text(
              'DELETE',
              style: styles.Staatliches.lWhite,
            ))),
        InnerBoxShadow(position: InnerBoxShadowRadiusPosition.right),
      ],
    );
  }
}
