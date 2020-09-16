import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/icons.dart' as icons;
import 'package:tenso_app/styles/styles.dart' as styles;

class StatsDateCard extends StatelessWidget {
  const StatsDateCard({
    @required this.startDate,
    @required this.endDate,
    @required this.handleStartDateTap,
    @required this.handleEndDateTap,
  });

  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback handleStartDateTap;
  final VoidCallback handleEndDateTap;

  @override
  Widget build(BuildContext context) {
    final String _formattedStartDate =
        '${startDate.day}-${startDate.month}-${startDate.year}';
    final String _formattedEndDate =
        '${endDate.day}-${endDate.month}-${endDate.year}';

    return Card(
      padding: EdgeInsets.symmetric(
        horizontal: styles.Measurements.xs,
        vertical: styles.Measurements.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: handleStartDateTap,
              child: Container(
                decoration: BoxDecoration(color: styles.Colors.translucent),
                child: Row(
                  children: [
                    Text(
                      _formattedStartDate,
                      style: styles.Staatliches.mBlack,
                    ),
                    Divider(
                      width: styles.Measurements.s,
                    ),
                    icons.downCaretBlackL
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: handleEndDateTap,
              child: Container(
                decoration: BoxDecoration(color: styles.Colors.translucent),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    icons.downCaretBlackL,
                    Divider(
                      width: styles.Measurements.s,
                    ),
                    Text(
                      _formattedEndDate,
                      style: styles.Staatliches.mBlack,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
