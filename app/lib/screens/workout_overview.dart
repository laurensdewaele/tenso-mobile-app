import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:app/data/interfaces.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/dividers.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/workout_overview_card.dart';

class WorkoutOverviewScreen extends StatefulWidget {
  WorkoutOverviewScreen({@required this.workouts});
  final List<Workout> workouts;

  void _handleAddWorkout() {
    print('Add workout!');
  }

  @override
  _WorkoutOverviewScreenState createState() => _WorkoutOverviewScreenState();
}

class _WorkoutOverviewScreenState extends State<WorkoutOverviewScreen> {
  int expandedHashCode;

  void _handleCollapse(int hashCode) {
    print('setting collapse on $hashCode');
    setState(() {
      expandedHashCode = null;
    });
  }

  void _handleExpand(int hashCode) {
    print('setting expand on $hashCode');
    setState(() {
      expandedHashCode = hashCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double viewHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final List<int> hashCodes =
        widget.workouts.map((workout) => workout.hashCode).toList();
    print(hashCodes);
    print('expanded hashcode: $expandedHashCode');
    return Screen(
        gradientStartColor: styles.Colors.bgGrayStart,
        gradientStopColor: styles.Colors.bgGrayStop,
        child: ListView.separated(
          itemCount: widget.workouts.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index < widget.workouts.length) {
              return WorkoutOverviewCard(
                  workout: widget.workouts[index],
                  handleCollapse: _handleCollapse,
                  handleExpand: _handleExpand,
                  expanded: expandedHashCode == widget.workouts[index].hashCode
                      ? true
                      : false);
            } else if (index == widget.workouts.length) {
              return Button(
                  text: 'Add workout', handleClick: widget._handleAddWorkout);
            } else {
              return SizedBox(height: viewHeight / 2 - styles.Measurements.m);
            }
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
