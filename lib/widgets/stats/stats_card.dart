import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

const double kStatsCardDimension = 120;

class StatsCard extends StatelessWidget {
  const StatsCard({
    @required this.handleTap,
    @required this.title,
    @required this.icon,
    @required this.disabled,
  });

  final VoidCallback handleTap;
  final String title;
  final String icon;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: kStatsCardDimension,
        height: kStatsCardDimension,
        decoration: BoxDecoration(
            color: disabled
                ? styles.Colors.blackTranslucent
                : styles.Colors.translucent),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: styles.kBorderRadiusAll,
              color: styles.Colors.bgWhite),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
