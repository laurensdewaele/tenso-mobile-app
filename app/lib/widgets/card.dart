import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart';

class Card extends StatelessWidget {
  const Card({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0))),
      padding: EdgeInsets.all(AppSpacings.regular),
      child: child,
    );
  }
}
