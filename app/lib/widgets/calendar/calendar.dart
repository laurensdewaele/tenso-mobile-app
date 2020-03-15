import 'package:flutter/cupertino.dart';

import 'package:app/models/completed_workout.dart';
import 'package:app/view_models/calendar_vm.dart';
import 'package:app/widgets/calendar/completed_workouts_overview.dart';
import 'package:app/widgets/calendar/date_picker.dart';
import 'package:app/widgets/calendar/header.dart';
import 'package:app/widgets/calendar/table.dart';
import 'package:app/widgets/modal_popup.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleSelectedMonthTap() async {
    final CalendarViewModel _calendarViewModel =
        Provider.of<CalendarViewModel>(context, listen: false);
    await showAppModalPopup(
        context: context,
        content: CalendarDatePicker(
          months: _calendarViewModel.calendarDatePickerMonths,
          currentMonth: _calendarViewModel.selectedMonth,
          handleSelectedMonth: (DateTime month) =>
              _calendarViewModel.setSelectedMonth(month),
        ));
  }

  void _handleDeleteTap(CompletedWorkout completedWorkout) {
    final CalendarViewModel _calendarViewModel =
        Provider.of<CalendarViewModel>(context, listen: false);
    _calendarViewModel.deleteCompletedWorkout(completedWorkout);
  }

  @override
  Widget build(BuildContext context) {
    final CalendarViewModel _calendarViewModel =
        Provider.of<CalendarViewModel>(context, listen: true);

    return Column(
      children: <Widget>[
        CalendarHeader(
          selectedMonth: _calendarViewModel.selectedMonth,
          handleSelectMonthTap: _handleSelectedMonthTap,
        ),
        CalendarTable(
            handleSelectedDay: _calendarViewModel.setSelectedDay,
            calendarTableDays: _calendarViewModel.calendarTableDays,
            handlePreviousMonthSwipe: _calendarViewModel.setPreviousMonth,
            handleNextMonthSwipe: _calendarViewModel.setNextMonth),
        CompletedWorkoutsOverview(
            handleDeleteTap: _handleDeleteTap,
            selectedDay: _calendarViewModel.selectedDay,
            completedWorkoutsForSelectedDay:
                _calendarViewModel.completedWorkoutsForSelectedDay)
      ],
    );
  }
}
