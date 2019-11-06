import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart';

class Card extends StatelessWidget {
  const Card({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: kAppBorderRadius,
          color: AppColors.white,
          boxShadow: [kAppBoxShadow]),
      padding: EdgeInsets.all(AppSpacings.regular),
      child: child,
    );
  }
}
