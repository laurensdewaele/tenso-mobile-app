import 'package:app/models/workout.dart';

double calculateAverageAddedWeight(Workout workout) {
  final List<double> weights = workout.holds.map((w) => w.addedWeight).toList();
  final double total = weights.fold(0, (a, b) => a + b);
  final double average = total / weights.length;
  return double.parse(average.toStringAsFixed(1));
}
