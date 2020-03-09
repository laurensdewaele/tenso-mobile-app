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
                        child: _TableElement(
                          calendarTableDay: calendarTableDay,
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

// TODO: Refactor, it's ugly AF
class _TableElement extends StatelessWidget {
  _TableElement({Key key, this.calendarTableDay}) : super(key: key);

  final CalendarTableDay calendarTableDay;

  @override
  Widget build(BuildContext context) {
    final String day = calendarTableDay.day.toString();

    // Does not belong to this month
    if (calendarTableDay.belongsToSelectedMonth == false) {
      return Text(
        day,
        style: styles.Staatliches.xsLightGray,
      );
    } else {
      final double dimension = calendarTableDay.selected == true
          ? styles.Measurements.l + 5
          : styles.Measurements.l;

      return Container(
        height: dimension,
        width: dimension,
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border: calendarTableDay.selected == true
                ? Border.all(width: 1, color: styles.Colors.black)
                : null),
        child: Center(
          child: Container(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ...calendarTableDay.completedWorkoutColors
                        .asMap()
                        .map((int i, Color color) => MapEntry(
                            i,
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.only(
                                        topLeft: i == 0
                                            ? styles.kBorderRadius
                                            : Radius.zero,
                                        topRight: i == 0
                                            ? styles.kBorderRadius
                                            : Radius.zero,
                                        bottomLeft: i ==
                                                calendarTableDay
                                                        .completedWorkoutColors
                                                        .length -
                                                    1
                                            ? styles.kBorderRadius
                                            : Radius.zero,
                                        bottomRight: i ==
                                                calendarTableDay
                                                        .completedWorkoutColors
                                                        .length -
                                                    1
                                            ? styles.kBorderRadius
                                            : Radius.zero)),
                              ),
                            )))
                        .values
                        .toList()
                  ],
                ),
                Center(
                  child: Text(
                    day,
                    style: calendarTableDay.completedWorkoutColors.length > 0
                        ? styles.Staatliches.xsWhite
                        : styles.Staatliches.xsBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

//

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
