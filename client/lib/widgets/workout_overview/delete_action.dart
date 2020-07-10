import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/inner_box_shadow.dart';
import 'package:flutter/cupertino.dart';

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
