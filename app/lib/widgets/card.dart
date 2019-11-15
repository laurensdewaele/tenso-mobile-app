import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class Card extends StatelessWidget {
  const Card({@required this.child, this.padding});

  final Widget child;
  // Padding is variable. Different for WorkoutOverview and NewWorkout.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: styles.kAppBorderRadiusAll,
          color: styles.Colors.bgWhite,
          boxShadow: [styles.kAppBoxShadow]),
      padding: padding,
      child: child,
    );
  }
}
