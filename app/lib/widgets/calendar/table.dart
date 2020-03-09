import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class CalendarTableDay {
  CalendarTableDay(
      {@required this.selected,
      @required this.day,
      @required this.belongsToSelectedMonth,
      @required this.completedWorkoutColors});

  final int day;
  final bool belongsToSelectedMonth;
  final bool selected;
  final List<Color> completedWorkoutColors;
}

class CalendarTable extends StatelessWidget {
  CalendarTable(
      {Key key,
      @required this.handleSelectedDay,
      @required this.calendarTableDays})
      : super(key: key);

  final Function(DateTime day) handleSelectedDay;
  final List<CalendarTableDay> calendarTableDays;

  @override
  Widget build(BuildContext context) {
    final int rows = calendarTableDays.length ~/ 7;
    final List<int> rowList = List.generate(rows, (i) => i);

    return Table(
      children: [
        _tableHeaderRow(),
        ...rowList.map((int rowNo) => TableRow(children: [
              ...calendarTableDays
                  .getRange(rowNo * 7, rowNo * 7 + 7)
                  .map((calendarTableDay) => _TableElementContainer(
                        child: Text(
                          calendarTableDay.day.toString(),
                          style: calendarTableDay.belongsToSelectedMonth
                              ? styles.Staatliches.xsBlack
                              : styles.Staatliches.xsLightGray,
                        ),
                      ))
            ])),
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
