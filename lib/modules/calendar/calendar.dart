import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/calendar/calendar.vm.dart';
import 'package:tenso_app/modules/common/modal_popup.dart';
import 'package:tenso_app/modules/completed_workout/completed_workout.screen.dart';
import 'package:tenso_app/modules/completed_workout/completed_workouts_overview.dart';
import 'package:tenso_app/modules/completed_workout/edit_completed_workout.screen.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/widgets/calendar/date_picker.dart';
import 'package:tenso_app/widgets/calendar/header.dart';
import 'package:tenso_app/widgets/calendar/table.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarViewModel _viewModel;

  @override
  void initState() {
    _viewModel = CalendarViewModel();
    _viewModel.addListener(_viewModelListener);
    super.initState();
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _viewModel.removeListener(_viewModelListener);
    super.dispose();
  }

  void _handleSelectedMonthTap() async {
    await showAppModalPopup(
        context: context,
        content: CalendarDatePicker(
          months: _viewModel.calendarDatePickerMonths,
          currentMonth: _viewModel.selectedMonth,
          handleSelectedMonth: (DateTime month) =>
              _viewModel.setSelectedMonth(month),
        ));
  }

  void _handleEditTap(CompletedWorkout completedWorkout) {
    Navigator.of(context).pushNamed(Routes.editCompletedWorkoutScreen,
        arguments: EditCompletedWorkoutScreenArguments(
          completedWorkout: completedWorkout,
        ));
  }

  void _handleViewTap(CompletedWorkout completedWorkout) {
    Navigator.of(context).pushNamed(Routes.completedWorkoutScreen,
        arguments: CompletedWorkoutScreenArguments(
          completedWorkout: completedWorkout,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CalendarHeader(
          selectedMonth: _viewModel.selectedMonth,
          handleSelectMonthTap: _handleSelectedMonthTap,
        ),
        CalendarTable(
            handleSelectedDay: _viewModel.setSelectedDay,
            calendarTableDays: _viewModel.calendarTableDays,
            handlePreviousMonthSwipe: _viewModel.setPreviousMonth,
            handleNextMonthSwipe: _viewModel.setNextMonth),
        CompletedWorkoutsOverview(
            handleEditTap: _handleEditTap,
            handleViewTap: _handleViewTap,
            handleDeleteTap: _viewModel.deleteCompletedWorkout,
            handleCopyTap: _viewModel.copyCompletedWorkout,
            selectedDay: _viewModel.selectedDay,
            completedWorkoutList: _viewModel.completedWorkoutsForSelectedDay)
      ],
    );
  }
}
