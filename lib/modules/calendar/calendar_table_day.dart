import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class CalendarTableDay {
  CalendarTableDay(
      {@required this.selected,
      @required this.day,
      @required this.belongsToSelectedMonth,
      @required this.completedWorkoutColors});

  final DateTime day;
  final bool belongsToSelectedMonth;
  final bool selected;
  final List<Color> completedWorkoutColors;
}

class CalendarTable extends StatelessWidget {
  CalendarTable(
      {Key key,
      @required this.handleSelectedDay,
      @required this.calendarTableDays,
      @required this.handleNextMonthSwipe,
      @required this.handlePreviousMonthSwipe})
      : super(key: key);

  final void Function(DateTime day) handleSelectedDay;
  final List<CalendarTableDay> calendarTableDays;
  final VoidCallback handlePreviousMonthSwipe;
  final VoidCallback handleNextMonthSwipe;

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity > 0) {
      handlePreviousMonthSwipe();
    } else {
      handleNextMonthSwipe();
    }
  }

  @override
  Widget build(BuildContext context) {
    final int rows = calendarTableDays.length ~/ 7;
    final List<int> rowList = List.generate(rows, (i) => i);

    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Table(
        children: [
          _tableHeaderRow(),
          ...rowList.map((int rowNo) => TableRow(children: [
                ...calendarTableDays
                    .getRange(rowNo * 7, rowNo * 7 + 7)
                    .map((calendarTableDay) => _TableElementContainer(
                          child: _TableElement(
                            calendarTableDay: calendarTableDay,
                            handleSelectedDay: handleSelectedDay,
                          ),
                        ))
              ])),
          // Ghost row in order to not let UI shift place
          if (rows < 6)
            TableRow(
                children: List.generate(7, (i) => i)
                    .map((i) => Container(
                          height: styles.Measurements.xl,
                        ))
                    .toList()),
          // Ghost row in order to not let UI shift place
          if (rows < 5)
            TableRow(
                children: List.generate(7, (i) => i)
                    .map((i) => Container(
                          height: styles.Measurements.xl,
                        ))
                    .toList())
        ],
      ),
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

class _TableElement extends StatelessWidget {
  _TableElement({Key key, this.calendarTableDay, this.handleSelectedDay})
      : super(key: key);

  final CalendarTableDay calendarTableDay;
  final void Function(DateTime date) handleSelectedDay;

  @override
  Widget build(BuildContext context) {
    final String day = calendarTableDay.day.day.toString();

    if (calendarTableDay.belongsToSelectedMonth == false) {
      return Text(
        day,
        style: styles.Staatliches.xsLightGray,
      );
    } else {
      final double dimension = calendarTableDay.selected == true
          ? styles.Measurements.xl
          : styles.Measurements.l;

      return GestureDetector(
        onTap: () {
          handleSelectedDay(calendarTableDay.day);
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: styles.Colors.translucent),
          child: Center(
            child: Container(
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
                      _CompletedWorkoutColors(
                        completedWorkoutColors:
                            calendarTableDay.completedWorkoutColors,
                      ),
                      Center(
                        child: Text(
                          day,
                          style:
                              calendarTableDay.completedWorkoutColors.length > 0
                                  ? styles.Staatliches.xsWhite
                                  : styles.Staatliches.xsBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}

class _CompletedWorkoutColors extends StatelessWidget {
  _CompletedWorkoutColors({Key key, this.completedWorkoutColors})
      : super(key: key);

  final List<Color> completedWorkoutColors;

  @override
  Widget build(BuildContext context) {
    final int amountOfColors = completedWorkoutColors.length;
    return Column(
      children: <Widget>[
        ...completedWorkoutColors
            .asMap()
            .map((int i, Color color) => MapEntry(
                i,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.only(
                            topLeft:
                                i == 0 ? styles.kBorderRadius : Radius.zero,
                            topRight:
                                i == 0 ? styles.kBorderRadius : Radius.zero,
                            bottomLeft: i == amountOfColors - 1
                                ? styles.kBorderRadius
                                : Radius.zero,
                            bottomRight: i == amountOfColors - 1
                                ? styles.kBorderRadius
                                : Radius.zero)),
                  ),
                )))
            .values
            .toList()
      ],
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
