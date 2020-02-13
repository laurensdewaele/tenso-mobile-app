import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Divider, Card;
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import 'package:app/models/menu_item.dart';
import 'package:app/models/workout.dart';
import 'package:app/routes/routes.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/new_or_edit_workout_vm.dart';
import 'package:app/widgets/bottom_menu_drawer.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/workout_overview/workout_overview_stack.dart';

class WorkoutOverviewScreen extends StatefulWidget {
  WorkoutOverviewScreen({@required this.workouts});
  final List<Workout> workouts;

  @override
  _WorkoutOverviewScreenState createState() => _WorkoutOverviewScreenState();
}

class _WorkoutOverviewScreenState extends State<WorkoutOverviewScreen> {
  void _handleAddWorkout() {
    Provider.of<NewOrEditWorkoutViewModel>(context, listen: false)
        .setWorkoutType(isNewWorkout: true);
    Navigator.of(context).pushNamed(Routes.newWorkoutScreen);
  }

  void _handleDeleteTap(Workout workout) {
    // TODO: Delete from source.
    if (widget.workouts.contains(workout)) {
      setState(() {
        widget.workouts.remove(workout);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double viewHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;

    return Stack(
      children: <Widget>[
        Screen(
            padding: EdgeInsets.symmetric(
                horizontal: styles.Measurements.xs,
                vertical: styles.Measurements.m),
            gradientStartColor: styles.Colors.bgGrayStart,
            gradientStopColor: styles.Colors.bgGrayStop,
            child: ListView.separated(
              physics: ClampingScrollPhysics(),
              itemCount: widget.workouts.length + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index < widget.workouts.length) {
                  return WorkoutOverviewStack(
                    key: ObjectKey(widget.workouts[index]),
                    workout: widget.workouts[index],
                    handleDeleteTap: _handleDeleteTap,
                  );
                } else if (index == widget.workouts.length) {
                  return Button(
                      text: 'Add workout', handleTap: _handleAddWorkout);
                } else {
                  return Divider(
                      height: viewHeight / 2 - styles.Measurements.m);
                }
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: styles.Measurements.m),
            )),
        BottomMenuDrawer(
          menuItems: [
            MenuItem((b) => b
              ..name = 'settings'
              ..route = Routes.settingsScreen),
            MenuItem((b) => b
              ..name = 'progress'
              ..route = Routes.progressScreen),
          ],
        )
      ],
    );
  }
}
