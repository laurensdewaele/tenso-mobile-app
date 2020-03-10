import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/models/workout.dart';
import 'package:app/routes/routes.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout_vm.dart';
import 'package:app/widgets/bottom_menu_drawer.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/workout_overview/workout_overview_stack.dart';

class WorkoutOverviewScreen extends StatefulWidget {
  WorkoutOverviewScreen();

  @override
  _WorkoutOverviewScreenState createState() => _WorkoutOverviewScreenState();
}

class _WorkoutOverviewScreenState extends State<WorkoutOverviewScreen> {
  void _handleAddWorkout() {
    Provider.of<WorkoutViewModel>(context, listen: false)
        .setWorkoutType(WorkoutTypes.newWorkout);
    Navigator.of(context).pushNamed(Routes.workoutScreen);
  }

  void _handleDeleteTap(Workout workout) {
    Provider.of<AppState>(context, listen: false).deleteWorkout(workout);
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double viewHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final _appState = Provider.of<AppState>(context, listen: true);

    return Stack(
      children: <Widget>[
        if (_appState.workoutList != null)
          _HomeScreen(
            child: ListView.separated(
              physics: ClampingScrollPhysics(),
              itemCount: _appState.workoutList.length + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index < _appState.workoutList.length) {
                  return WorkoutOverviewStack(
                    key: ObjectKey(_appState.workoutList[index]),
                    workout: _appState.workoutList[index],
                    handleWorkoutDeleteTap: _handleDeleteTap,
                  );
                } else if (index == _appState.workoutList.length) {
                  return Button(
                      text: 'Add workout',
                      handleTap: _handleAddWorkout,
                      displayNextIcon: true);
                } else {
                  return Divider(
                      height: viewHeight / 2 - styles.Measurements.m);
                }
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: styles.Measurements.m),
            ),
          ),
        if (_appState.workoutList == null)
          _HomeScreen(
              child: Column(
            children: <Widget>[
              Button(
                  text: 'Add workout',
                  handleTap: _handleAddWorkout,
                  displayNextIcon: true),
            ],
          )),
        BottomMenuDrawer()
      ],
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
