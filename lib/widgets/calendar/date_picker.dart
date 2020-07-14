import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/view_models/calendar.vm.dart';
import 'package:tenso_app/widgets/calendar/constants.dart';
import 'package:flutter/cupertino.dart';

class CalendarDatePicker extends StatelessWidget {
  CalendarDatePicker(
      {Key key,
      @required this.months,
      @required this.handleSelectedMonth,
      @required this.currentMonth})
      : super(key: key);

  final List<DateTime> months;
  final void Function(DateTime date) handleSelectedMonth;
  final DateTime currentMonth;

  @override
  Widget build(BuildContext context) {
    final DateTime isSelectedMonth =
        months.firstWhere((DateTime month) => isSameMonth(month, currentMonth));
    final int initialItem = months.indexOf(isSelectedMonth);

    return Container(
      padding: EdgeInsets.all(styles.Measurements.xs),
      child: Container(
        height: 150,
        child: CupertinoPicker(
          scrollController:
              FixedExtentScrollController(initialItem: initialItem),
          useMagnifier: false,
          magnification: 1,
          backgroundColor: styles.Colors.bgWhite,
          onSelectedItemChanged: (int index) {
            handleSelectedMonth(months[index]);
          },
          itemExtent: 40,
          children: <Widget>[
            ...months.map((DateTime month) {
              final String _month = kMonths[month.month];
              final String _year = month.year.toString();

              return Center(
                child: Text(
                  ' $_month $_year',
                  style: styles.Staatliches.lBlack,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
