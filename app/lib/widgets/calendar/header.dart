import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/widgets/calendar/constants.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/icon_button.dart';
import 'package:app/styles/styles.dart' as styles;

class CalendarHeader extends StatelessWidget {
  CalendarHeader({Key key, this.selectedMonth, this.handleSelectMonthTap});

  final DateTime selectedMonth;
  final VoidCallback handleSelectMonthTap;

  @override
  Widget build(BuildContext context) {
    final String month = months[selectedMonth.month];
    final String year = selectedMonth.year.toString();

    return GestureDetector(
      onTap: handleSelectMonthTap,
      child: Row(
        children: [
          Text(
            '$month $year',
            style: styles.Staatliches.xlBlack,
          ),
          IconButton(
              handleTap: () {},
              icon: Icon(
                iconData: IconData(0xf3d0,
                    fontFamily: 'CupertinoIcons',
                    fontPackage: 'cupertino_icons'),
                color: styles.Colors.black,
              ))
        ],
      ),
    );
  }
}
