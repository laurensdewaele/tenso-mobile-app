import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

const double kStatsCardDimension = 140;

class StatsCard extends StatelessWidget {
  const StatsCard({
    @required this.handleTap,
    @required this.title,
    @required this.iconPath,
    @required this.disabled,
  });

  final VoidCallback handleTap;
  final String title;
  final String iconPath;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Stack(
        children: [
          Container(
            height: kStatsCardDimension,
            width: kStatsCardDimension,
            decoration: BoxDecoration(
                borderRadius: styles.kBorderRadiusAll,
                color: styles.Colors.bgWhite),
            child: Padding(
              padding: const EdgeInsets.all(styles.Measurements.xs),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        iconPath,
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  Divider(
                    height: styles.Measurements.xs,
                  ),
                  Center(
                    child: Text(
                      title,
                      style: styles.Staatliches.sBlack,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: kStatsCardDimension,
            width: kStatsCardDimension,
            decoration: BoxDecoration(
                color: disabled
                    ? styles.Colors.blackTranslucent
                    : styles.Colors.translucent,
                borderRadius: styles.kBorderRadiusAll),
          )
        ],
      ),
    );
  }
}
