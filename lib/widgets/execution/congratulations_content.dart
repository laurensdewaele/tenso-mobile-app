import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/icons.dart' as icons;

class CongratulationsContent extends StatelessWidget {
  CongratulationsContent({
    Key key,
    @required this.handleRateWorkoutTap,
    @required this.handleAdjustHangsTap,
  }) : super(key: key);

  final VoidCallback handleRateWorkoutTap;
  final VoidCallback handleAdjustHangsTap;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      final _isPortrait = orientation == Orientation.portrait;
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_isPortrait == true)
            Expanded(
              child: Image.asset(
                'assets/images/fist.png',
              ),
            ),
          if (_isPortrait == true)
            Divider(
              height: styles.Measurements.m,
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
          if (_isPortrait == false)
            Expanded(
              child: Container(),
            ),
          if (_isPortrait == true)
            Divider(
              height: styles.Measurements.xxl,
            ),
          Button(
            smallText: true,
            text: 'adjust hangs',
            handleTap: handleAdjustHangsTap,
            displayBackground: true,
            backgroundColor: styles.Colors.blue,
            leadingIcon: icons.editIconWhiteXl,
            leadingIconTextCentered: true,
          ),
          Divider(
            height: styles.Measurements.m,
          ),
          Button(
            smallText: true,
            text: 'complete workout',
            handleTap: handleRateWorkoutTap,
            displayBackground: true,
            backgroundColor: styles.Colors.turquoise,
            leadingIcon: icons.editIconWhiteXl,
            leadingIconTextCentered: true,
          ),
        ],
      );
    });
  }
}
