import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/inner_box_shadow.dart';
import 'package:flutter/cupertino.dart';

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
