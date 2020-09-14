import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/view_models/stats/filter_state.vm.dart';
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/color_square.dart';
import 'package:tenso_app/widgets/divider.dart';

class FilterCompletedWorkoutsCard extends StatelessWidget {
  const FilterCompletedWorkoutsCard({
    Key key,
    @required this.workoutsWithCompletedAmount,
    @required this.handleSelectedWorkout,
    this.selectedWorkout,
  });

  final List<WorkoutWithCompletedAmount> workoutsWithCompletedAmount;
  final void Function(Workout workout) handleSelectedWorkout;
  final Workout selectedWorkout;

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: EdgeInsets.all(styles.Measurements.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'workout',
            style: styles.Staatliches.xlBlack,
          ),
          Divider(height: styles.Measurements.l),
          ...workoutsWithCompletedAmount
              .asMap()
              .map((int index, WorkoutWithCompletedAmount w) => MapEntry(
                  index,
                  GestureDetector(
                    onTap: () => handleSelectedWorkout(w.workout),
                    child: _CompletedWorkoutCard(
                      divider: workoutsWithCompletedAmount.length > 1 &&
                          index != workoutsWithCompletedAmount.length - 1,
                      labelColor: w.workout.labelColor,
                      completedAmount: w.completedAmount,
                      isSelected: selectedWorkout?.id == w.workout.id,
                      workoutName: w.workout.name,
                    ),
                  )))
              .values
              .toList(),
        ],
      ),
    );
  }
}

class _CompletedWorkoutCard extends StatelessWidget {
  const _CompletedWorkoutCard({
    Key key,
    @required this.isSelected,
    @required this.workoutName,
    @required this.labelColor,
    @required this.completedAmount,
    @required this.divider,
  });

  final bool isSelected;
  final bool divider;
  final String workoutName;
  final Color labelColor;
  final int completedAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(
              isSelected ? styles.Measurements.s - 1 : styles.Measurements.s),
          decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border: Border.all(
              color: isSelected ? styles.Colors.turquoise : styles.Colors.gray,
              width: isSelected ? 2 : 1,
            ),
            color: styles.Colors.bgWhite,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(workoutName,
                      style: styles.Staatliches.xlBlack,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              ColorSquare(
                color: labelColor,
                width: styles.Measurements.xxl,
                height: styles.Measurements.xxl,
                text: '${completedAmount.toString()}X',
              )
            ],
          ),
        ),
        if (divider == true) Divider(height: styles.Measurements.m)
      ],
    );
  }
}
