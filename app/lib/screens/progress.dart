import 'package:flutter/cupertino.dart';

import 'package:charts_flutter/flutter.dart';

import 'package:app/data/completed_workout.dart';
import 'package:app/models/completed_workout.dart';
import 'package:app/styles/styles.dart' as styles;

final List<CompletedWorkout> _completedWorkouts = generateCompletedWorkouts(40);
final List<Series<CompletedWorkout, DateTime>> _mappedData = [
  Series<CompletedWorkout, DateTime>(
    id: 'Felt diff',
    colorFn: (CompletedWorkout ca, _) => Color.black,
    domainFn: (CompletedWorkout ca, _) => ca.completedDate,
    measureFn: (CompletedWorkout ca, _) => ca.feltDifficulty,
    data: _completedWorkouts,
  ),
];

class ProgressScreen extends StatefulWidget {
  ProgressScreen({Key key}) : super(key: key);

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: styles.Colors.bgGrayStop),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 1,
            child: TimeSeriesChart(
              _mappedData,
              animate: true,
              dateTimeFactory: const LocalDateTimeFactory(),
            ),
          ),
        ],
      ),
    );
  }
}
