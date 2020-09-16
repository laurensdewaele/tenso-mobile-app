import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/models/completed_workout.model.dart';
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/section.dart';
import 'package:tenso_app/modules/completed_workout/logs_overview.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/keyboard_list_view.dart';
import 'package:tenso_app/widgets/top_navigation.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleBackNavigation() {
    Navigator.of(context).pop();
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
                      if (_completedWorkout.comments != null)
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
