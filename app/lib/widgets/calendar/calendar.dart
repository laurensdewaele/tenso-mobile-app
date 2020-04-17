import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/workout.dart';
import 'package:app/state/completed_workouts_state.dart';
import 'package:app/state/workouts_state.dart';
import 'package:app/view_models/calendar_vm.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/widgets/calendar/completed_workouts_overview.dart';
import 'package:app/widgets/calendar/date_picker.dart';
import 'package:app/widgets/calendar/header.dart';
import 'package:app/widgets/calendar/table.dart';
import 'package:app/widgets/modal_popup.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarViewModel _viewModel;

  @override
  void initState() {
    _viewModel = CalendarViewModel(
        workoutsState: Provider.of<WorkoutsState>(context, listen: false),
        completedWorkoutsState:
            Provider.of<CompletedWorkoutsState>(context, listen: false));
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

  void _handleViewTap(Workout workout) {
    Navigator.of(context).pushNamed(Routes.workoutScreen,
        arguments: WorkoutScreenArguments(
            workout: workout,
            workoutType: WorkoutTypes.viewWorkout));
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
            handleViewTap: _handleViewTap,
            handleDeleteTap: _viewModel.deleteCompletedWorkout,
            handleCopyTap: _viewModel.copyCompletedWorkout,
            selectedDay: _viewModel.selectedDay,
            completedWorkoutsForSelectedDay:
                _viewModel.completedWorkoutsForSelectedDay)
      ],
    );
  }
}
