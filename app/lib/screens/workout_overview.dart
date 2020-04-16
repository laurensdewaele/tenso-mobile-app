import 'package:flutter/cupertino.dart' hide Icon;

import 'package:provider/provider.dart';

import 'package:app/data/basic_workout.dart';
import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/workout.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout_overview_vm.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/widgets/bottom_menu_drawer.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/workout_overview/workout_overview_stack.dart';

class WorkoutOverviewScreen extends StatefulWidget {
  WorkoutOverviewScreen();

  @override
  _WorkoutOverviewScreenState createState() => _WorkoutOverviewScreenState();
}

class _WorkoutOverviewScreenState extends State<WorkoutOverviewScreen> {
  void _handleWorkoutAddTap() {
    Navigator.of(context).pushNamed(Routes.workoutScreen,
        arguments: WorkoutScreenArguments(
            workoutType: WorkoutTypes.newWorkout,
            workout: basicWorkout,
            weightUnit: Provider.of<AppState>(context, listen: false)
                .settings
                .weightUnit));
  }

  void _handleWorkoutEditTap(Workout workout) {
    Navigator.of(context).pushNamed(Routes.workoutScreen,
        arguments: WorkoutScreenArguments(
            workoutType: WorkoutTypes.editWorkout,
            workout: workout,
            weightUnit: Provider.of<AppState>(context, listen: false)
                .settings
                .weightUnit));
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double viewHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    WorkoutOverviewViewModel _viewModel =
        Provider.of<WorkoutOverviewViewModel>(context, listen: true);

    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: <Widget>[
          if (_viewModel.workoutList != null)
            _HomeScreen(
              child: ListView.separated(
                physics: ClampingScrollPhysics(),
                itemCount: _viewModel.workoutList.length + 2,
                itemBuilder: (BuildContext context, int index) {
                  if (index < _viewModel.workoutList.length) {
                    return WorkoutOverviewStack(
                      key: ValueKey(
                          'workout_overview_stack-${_viewModel.workoutList[index]}'),
                      workout: _viewModel.workoutList[index],
                      handleWorkoutDeleteTap: _viewModel.deleteWorkout,
                      handleWorkoutEditTap: _handleWorkoutEditTap,
                    );
                  } else if (index == _viewModel.workoutList.length) {
                    return _AddWorkoutButton(
                      handleTap: _handleWorkoutAddTap,
                    );
                  } else {
                    return Divider(
                        height: viewHeight / 2 - styles.Measurements.m);
                  }
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(height: styles.Measurements.m),
              ),
            ),
          if (_viewModel.workoutList == null)
            _HomeScreen(
                child: Column(
              children: <Widget>[
                _AddWorkoutButton(
                  handleTap: _handleWorkoutAddTap,
                ),
              ],
            )),
          BottomMenuDrawer(
            startOpen: _viewModel.startOpen,
          )
        ],
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  _HomeScreen({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Screen(
        padding: EdgeInsets.symmetric(
            horizontal: styles.Measurements.xs,
            vertical: styles.Measurements.m),
        gradientStartColor: styles.Colors.bgGrayStart,
        gradientStopColor: styles.Colors.bgGrayStop,
        child: child);
  }
}

class _AddWorkoutButton extends StatelessWidget {
  _AddWorkoutButton({Key key, this.handleTap}) : super(key: key);

  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return Button(
        text: 'Add workout',
        handleTap: handleTap,
        leadingIcon: icons.plusIconWhiteXl);
  }
}
