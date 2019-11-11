import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';
import 'package:app/widgets/card.dart';
import 'package:app/styles/styles.dart' as styles;

class WorkoutOverviewExpanded extends StatelessWidget {
  const WorkoutOverviewExpanded(
      {@required this.workout, @required this.handleCollapse});

  final Workout workout;
  final VoidCallback handleCollapse;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleCollapse,
        child: Card(
            padding: EdgeInsets.all(styles.Spacings.m),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('hello', style: styles.Typography.title)
                  ],
                )
              ],
            )));
  }
}
