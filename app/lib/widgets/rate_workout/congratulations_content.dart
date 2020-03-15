import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';

class CongratulationsContent extends StatelessWidget {
  CongratulationsContent(
      {Key key,
      @required this.handleRateWorkoutTap,
      @required this.orientation})
      : super(key: key);

  final VoidCallback handleRateWorkoutTap;
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    final Widget image = Center(
      child: Image.asset(
        'assets/images/fist.png',
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (orientation == Orientation.portrait)
          Expanded(
            child: image,
          ),
        if (orientation == Orientation.landscape) image,
        if (orientation == Orientation.portrait)
          Divider(
            height: styles.Measurements.m,
          ),
        if (orientation == Orientation.landscape)
          Divider(
            height: styles.Measurements.xxl,
          ),
        Text(
          'Congratulations!',
          style: styles.Staatliches.xlBlack,
        ),
        Divider(height: styles.Measurements.l),
        Text(
          'You’re one step closer to indestructible and indefatigable fingers!',
          textAlign: TextAlign.center,
          style: styles.Lato.sBlack,
        ),
        Divider(
          height: styles.Measurements.xxl,
        ),
        Button(
          backgroundColor: styles.Colors.turquoise,
          width: double.infinity,
          text: 'rate workout',
          handleTap: handleRateWorkoutTap,
        ),
      ],
    );
  }
}
