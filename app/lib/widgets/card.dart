import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class Card extends StatelessWidget {
  const Card({@required this.child, this.padding, this.border = false});

  final Widget child;
  // Padding is variable. Different for WorkoutOverview and NewWorkout.
  final EdgeInsets padding;
  final bool border;

  @override
  Widget build(BuildContext context) {
    final BoxDecoration _boxDecoration = border == true
        ? BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border: Border.all(color: styles.Colors.black),
            color: styles.Colors.bgWhite,
            boxShadow: [styles.kBoxShadow])
        : BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            color: styles.Colors.bgWhite,
            boxShadow: [styles.kBoxShadow]);

    return Container(
      decoration: _boxDecoration,
      padding: padding,
      child: child,
    );
  }
}
