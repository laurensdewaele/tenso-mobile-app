import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/calendar/constants.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/color_square.dart';
import 'package:tenso_app/modules/common/dialog.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/sliding_card.dart';
import 'package:tenso_app/modules/workout_overview/delete_action.dart';
import 'package:tenso_app/modules/workout_overview/edit_action.dart';
import 'package:tenso_app/modules/workout_overview/workout_long_press_dialog.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class CompletedWorkoutsOverview extends StatelessWidget {
  CompletedWorkoutsOverview({
    Key key,
    @required this.selectedDay,
    @required this.completedWorkoutList,
    @required this.handleDeleteTap,
    @required this.handleCopyTap,
    @required this.handleEditTap,
    @required this.handleViewTap,
  }) : super(key: key);

  final DateTime selectedDay;
  final List<CompletedWorkout> completedWorkoutList;
  final void Function(CompletedWorkout completedWorkout) handleDeleteTap;
  final void Function(CompletedWorkout completedWorkout) handleCopyTap;
  final void Function(CompletedWorkout completedWorkout) handleEditTap;
  final void Function(CompletedWorkout completedWorkout) handleViewTap;

  void _handleLongPress(
      BuildContext context, CompletedWorkout completedWorkout) async {
    await showAppDialog(
        smallWidth: true,
        context: context,
        content: WorkoutLongPressDialog(
          name: completedWorkout.workout.name,
          handleDeleteTap: () => handleDeleteTap(completedWorkout),
          handleEditTap: () => handleEditTap(completedWorkout),
          handleCopyTap: () => handleCopyTap(completedWorkout),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final String weekDay = kWeekDays[selectedDay.weekday];
    final String day = selectedDay.day.toString();
    final String month = kMonths[selectedDay.month];

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: styles.Measurements.xxl),
          Text(
            '$weekDay $day $month',
            style: styles.Staatliches.xlBlack,
          ),
          Divider(
            height: styles.Measurements.l,
          ),
          Column(
            key: ValueKey(completedWorkoutList.hashCode),
            children: <Widget>[
              ...completedWorkoutList
                  .asMap()
                  .map((int index, completedWorkout) => MapEntry(
                      index,
                      SlidingCard(
                        disabled: false,
                        key: ValueKey(completedWorkout.id),
                        border: true,
                        divider: completedWorkoutList.length > 1 &&
                            index != completedWorkoutList.length - 1,
                        dividerHeight: styles.Measurements.m,
                        leftAction: EditAction(),
                        handleLeftActionTap: () =>
                            handleEditTap(completedWorkout),
                        rightAction: DeleteAction(),
                        handleRightActionTap: () =>
                            handleDeleteTap(completedWorkout),
                        handleLongPress: () =>
                            _handleLongPress(context, completedWorkout),
                        content: _SlidingCardContent(
                          handleTap: () => handleViewTap(completedWorkout),
                          labelColor: completedWorkout.workout.label.color,
                          name: completedWorkout.workout.name,
                        ),
                      )))
                  .values
                  .toList(),
            ],
          ),
          if (completedWorkoutList.length == 0)
            Text('There are no completed workouts for this day.',
                style: styles.Lato.sBlack)
        ],
      ),
    );
  }
}

class _SlidingCardContent extends StatelessWidget {
  const _SlidingCardContent({
    @required this.name,
    @required this.labelColor,
    @required this.handleTap,
  });

  final String name;
  final Color labelColor;
  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleTap,
        child: Card(
            padding: EdgeInsets.all(styles.Measurements.s),
            child: Column(
              children: <Widget>[
                Stack(overflow: Overflow.clip, children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: styles.Measurements.xxl,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(name,
                                style: styles.Staatliches.xlBlack,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      ColorSquare(
                        color: labelColor,
                        width: styles.Measurements.xxl,
                        height: styles.Measurements.xxl,
                      )
                    ],
                  ),
                ]),
              ],
            )));
  }
}
