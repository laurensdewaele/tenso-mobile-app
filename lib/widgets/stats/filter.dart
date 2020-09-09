import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/icons.dart' as icons;

class Filter extends StatelessWidget {
  const Filter({
    @required this.handleTap,
    @required this.selectedFilter,
  });

  final VoidCallback handleTap;
  final Widget selectedFilter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Card(
        padding: EdgeInsets.symmetric(
          horizontal: styles.Measurements.xs,
          vertical: styles.Measurements.xs,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'filter',
              style: styles.Staatliches.mBlack,
            ),
            selectedFilter,
            icons.forwardIconBlackXl
          ],
        ),
      ),
    );
  }
}
