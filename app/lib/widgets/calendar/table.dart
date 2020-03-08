import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class CalendarTable extends StatelessWidget {
  CalendarTable(
      {Key key,
      @required this.selectedMonth,
      @required this.selectedDay,
      @required this.handleSelectedDay})
      : super(key: key);

  final DateTime selectedDay;
  final DateTime selectedMonth;
  final Function(DateTime day) handleSelectedDay;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        _tableHeaderRow(),
      ],
    );
  }
}

class _TableElementContainer extends StatelessWidget {
  _TableElementContainer({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: styles.Measurements.xl,
      child: Center(
        child: child,
      ),
    );
  }
}

// Not a class/widget because TableRow is not a widget!
TableRow _tableHeaderRow() {
  const abbreviatedDaysInWeek = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];
  return TableRow(
      children: abbreviatedDaysInWeek
          .map((String day) => _TableElementContainer(
                child: Text(
                  day,
                  style: styles.Lato.xsBlack,
                ),
              ))
          .toList());
}
