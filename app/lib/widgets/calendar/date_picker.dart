import 'package:app/widgets/calendar/constants.dart';
import 'package:flutter/cupertino.dart';

import 'package:built_value/built_value.dart';

import 'package:app/styles/styles.dart' as styles;

class CalendarDatePickerMonth {
  CalendarDatePickerMonth({
    @required this.date,
    @required this.hasCompletedWorkouts,
    @required this.isSelectedMonth,
  });

  final DateTime date;
  final bool hasCompletedWorkouts;
  final bool isSelectedMonth;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CalendarDatePickerMonth &&
        date == other.date &&
        hasCompletedWorkouts == other.hasCompletedWorkouts &&
        isSelectedMonth == other.isSelectedMonth;
  }

  @override
  int get hashCode {
    return $jc($jc($jc(0, date.hashCode), hasCompletedWorkouts.hashCode),
        isSelectedMonth.hashCode);
  }
}

class CalendarDatePicker extends StatelessWidget {
  CalendarDatePicker(
      {Key key, @required this.months, @required this.handleSelectedMonth})
      : super(key: key);

  final List<CalendarDatePickerMonth> months;
  final void Function(DateTime date) handleSelectedMonth;

  @override
  Widget build(BuildContext context) {
    final CalendarDatePickerMonth isSelectedMonth =
        months.firstWhere((month) => month.isSelectedMonth == true);
    final int initialItem = months.indexOf(isSelectedMonth);

    return Container(
      height: 150,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: initialItem),
        useMagnifier: true,
        magnification: 1,
        backgroundColor: styles.Colors.bgWhite,
        onSelectedItemChanged: (int index) {
          handleSelectedMonth(months[index].date);
        },
        itemExtent: 40,
        children: <Widget>[
          ...months.map((CalendarDatePickerMonth month) {
            final String _month = kMonths[month.date.month];
            final String _year = month.date.year.toString();
            final bool _hasCompletedWorkouts = month.hasCompletedWorkouts;

            return Center(
              child: Text(
                '$_month $_year',
                style: _hasCompletedWorkouts == true
                    ? styles.Staatliches.xlBlack
                    : styles.Staatliches.xsLightGray,
              ),
            );
          })
        ],
      ),
    );
  }
}
