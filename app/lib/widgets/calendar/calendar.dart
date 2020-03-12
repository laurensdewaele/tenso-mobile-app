import 'package:flutter/cupertino.dart';

import 'package:app/models/completed_workout.dart';
import 'package:app/models/completed_workouts.dart';
import 'package:app/view_models/calendar_vm.dart';
import 'package:app/widgets/calendar/completed_workouts_overview.dart';
import 'package:app/widgets/calendar/date_picker.dart';
import 'package:app/widgets/calendar/header.dart';
import 'package:app/widgets/calendar/table.dart';
import 'package:app/widgets/modal_popup.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key, this.completedWorkouts}) : super(key: key);

  final CompletedWorkouts completedWorkouts;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarViewModel _calendarViewModel;

  @override
  void initState() {
    super.initState();
    _calendarViewModel =
        CalendarViewModel(completedWorkouts: widget.completedWorkouts);
    _calendarViewModel.addListener(_rebuild);
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    _calendarViewModel.removeListener(_rebuild);
    _calendarViewModel.dispose();
    super.dispose();
  }

  void _handleSelectedMonthTap() async {
    await showAppModalPopup(
        context: context,
        content: CalendarDatePicker(
          months: _calendarViewModel.datePickerMonths,
          handleSelectedMonth: (DateTime month) =>
              _calendarViewModel.setSelectedMonth(month),
        ));
  }

  void _handleDeleteTap(CompletedWorkout completedWorkout) {}

  @override
  Widget build(BuildContext context) {
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
