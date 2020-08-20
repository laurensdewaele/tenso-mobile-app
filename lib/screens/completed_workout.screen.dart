import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/models/completed_workout.model.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/screens/edit_completed_workout.screen.dart';
import 'package:tenso_app/state/completed_workouts.state.dart';
import 'package:tenso_app/state/workouts.state.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/completed_workout/logs_overview.dart';
import 'package:tenso_app/widgets/completed_workout/stats.dart';
import 'package:tenso_app/widgets/dialog.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/icon_button.dart';
import 'package:tenso_app/widgets/icons.dart' as icons;
import 'package:tenso_app/widgets/keyboard_list_view.dart';
import 'package:tenso_app/widgets/screen.dart';
import 'package:tenso_app/widgets/section.dart';
import 'package:tenso_app/widgets/top_navigation.dart';
import 'package:tenso_app/widgets/workout_overview/workout_long_press_dialog.dart';

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

  void _handleEditTap() {
    Navigator.of(context).pushNamed(Routes.editCompletedWorkoutScreen,
        arguments: EditCompletedWorkoutScreenArguments(
          completedWorkout: _completedWorkout,
        ));
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
          name: _completedWorkout.workout.name,
          handleDeleteTap: () => _handleDeleteTap(),
          handleEditTap: () => _handleEditTap(),
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
                        children: <Widget>[
                          Stats(
                            completedWorkout: _completedWorkout,
                          )
                        ],
                      ),
                      if (_completedWorkout.comments != null &&
                          _completedWorkout.comments != '')
                        Section(
                          title: 'comments',
                          children: <Widget>[
                            Text(
                              _completedWorkout.comments,
                              textAlign: TextAlign.center,
                              style: styles.Lato.xsGray,
                            )
                          ],
                        ),
                      GestureDetector(
                        onHorizontalDragEnd: (_) {},
                        behavior: HitTestBehavior.opaque,
                        child: Section(
                          title: 'overview',
                          children: <Widget>[
                            LogsOverview(
                              weightUnit:
                                  _completedWorkout.workout.weightSystem.unit,
                              groups: _completedWorkout.workout.groups.toList(),
                              logs: _completedWorkout.history.sequenceTimerLogs
                                  .toList(),
                            )
                          ],
                        ),
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
                          handleTap: () {
                            Navigator.of(context).pop();
                          },
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
