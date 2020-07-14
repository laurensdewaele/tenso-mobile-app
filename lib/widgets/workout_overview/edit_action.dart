import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/inner_box_shadow.dart';

class EditAction extends StatelessWidget {
  const EditAction();

  @override
  Widget build(BuildContext context) {
    return Stack(overflow: Overflow.clip, children: <Widget>[
      Container(
          decoration: const BoxDecoration(
              color: styles.Colors.blue,
              borderRadius: BorderRadius.only(
                  topLeft: styles.kBorderRadius,
                  bottomLeft: styles.kBorderRadius)),
          child: Center(
              child: Text(
            'EDIT',
            style: styles.Staatliches.lWhite,
          ))),
      InnerBoxShadow(position: InnerBoxShadowRadiusPosition.left)
    ]);
  }
}
