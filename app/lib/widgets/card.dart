import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class Card extends StatelessWidget {
  const Card({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: styles.kAppBorderRadius,
          color: styles.Colors.bgWhite,
          boxShadow: [styles.kAppBoxShadow]),
      padding: EdgeInsets.all(styles.Spacings.m),
      child: child,
    );
  }
}
