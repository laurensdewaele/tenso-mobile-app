import 'package:app/models/completed_workout.model.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/workout.screen.dart';
import 'package:app/state/completed_workouts.state.dart';
import 'package:app/state/workouts.state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/workout.vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icon_button.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:app/widgets/workout_overview/workout_long_press_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' hide Icon;

class CompletedWorkoutScreenArguments {
  final CompletedWorkout completedWorkout;

  const CompletedWorkoutScreenArguments({
    @required this.completedWorkout,
  });
}

class CompletedWorkoutScreen extends StatefulWidget {
  CompletedWorkoutScreen({Key key}) : super(key: key);

  @override
  _CompletedWorkoutScreenState createState() => _CompletedWorkoutScreenState();
}

class _CompletedWorkoutScreenState extends State<CompletedWorkoutScreen> {
  CompletedWorkout _completedWorkout;
  CompletedWorkoutsState _completedWorkoutsState;
  WorkoutsState _workoutsState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_completedWorkout == null) {
      final CompletedWorkoutScreenArguments routeArguments =
          ModalRoute.of(context).settings.arguments;
      _completedWorkout = routeArguments.completedWorkout;
    }
  }

  @override
  void initState() {
    _completedWorkoutsState = CompletedWorkoutsState();
    _workoutsState = WorkoutsState();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleBackNavigation() {
    Navigator.of(context).pop();
  }

  void _handleDeleteTap() {
    _completedWorkoutsState.deleteCompletedWorkout(_completedWorkout);
    Navigator.of(context).pop();
  }

  void _handleViewParamsTap() {
    Navigator.of(context).pushNamed(Routes.workoutScreen,
        arguments: WorkoutScreenArguments(
            workout: _completedWorkout.workout,
            workoutAction: WorkoutActions.viewWorkout));
  }

  void _handleCopyTap() {
    _workoutsState.copyWorkout(_completedWorkout.workout);
    Navigator.of(context).pushNamed(Routes.workoutOverviewScreen);
  }

  void _launchActions() async {
    await showAppDialog(
        smallWidth: true,
        context: context,
        content: WorkoutLongPressDialog(
          onCompletedWorkoutScreen: true,
          name: _completedWorkout.workout.name,
          handleDeleteTap: () => _handleDeleteTap(),
          handleViewTap: () => _handleViewParamsTap(),
          handleCopyTap: () => _handleCopyTap(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      handleBackNavigation: _handleBackNavigation,
      child: KeyboardListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              TopNavigation(
                handleBackNavigation: _handleBackNavigation,
                title: _completedWorkout.workout.name,
                dark: true,
              ),
              Divider(height: styles.Measurements.xxl),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
                child: Card(
                  padding: const EdgeInsets.only(
                    left: styles.Measurements.m,
                    right: styles.Measurements.m,
                    top: styles.Measurements.m,
                    bottom: styles.Measurements.l,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Divider(
                        height: styles.Measurements.xs,
                      ),
                      Section(
                        title: 'stats',
                        children: <Widget>[],
                      ),
                      Section(
                        title: 'comments',
                        children: <Widget>[],
                      ),
                      Section(
                        title: 'overview',
                        children: <Widget>[],
                      ),
                      Row(
                        children: [
                          Text(
                            'actions',
                            style: styles.Staatliches.xlBlack,
                          ),
                          IconButton(
                              handleTap: _launchActions,
                              icon: icons.downCaretBlack)
                        ],
                      ),
                      Divider(
                        height: styles.Measurements.l,
                      ),
                      Center(
                        child: Button(
                          backgroundColor: styles.Colors.gray,
                          text: 'back',
                          handleTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: styles.Measurements.xxl)
            ],
          )
        ],
      ),
    );
  }
}
