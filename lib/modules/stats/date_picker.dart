import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/calendar/constants.dart';

class StatsDatePicker extends StatelessWidget {
  StatsDatePicker(
      {Key key,
      @required this.dates,
      @required this.handleSelectedDate,
      @required this.initialDate})
      : super(key: key);

  final List<DateTime> dates;
  final void Function(DateTime date) handleSelectedDate;
  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    final int initialItem = dates.indexOf(initialDate);

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
            handleSelectedDate(dates[index]);
          },
          itemExtent: 40,
          children: <Widget>[
            ...dates.map((DateTime date) {
              final String _month = kMonths[date.month];
              final String _year = date.year.toString();

              return Center(
                child: Text(
                  '${date.day} $_month $_year',
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
