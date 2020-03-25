import 'package:app/models/workout.dart';

int calculateAverageHangTime(Workout workout) {
  final List<int> hangSeconds = workout.holds.map((w) => w.hangTime).toList();
  final double total = hangSeconds.fold(0, (a, b) => a + b);
  return total ~/ hangSeconds.length;
}
