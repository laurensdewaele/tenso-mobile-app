import 'package:app/models/hold.dart';

int getTotalHangs(List<Hold> holds) {
  int total = 0;
  holds.forEach((hold) => {total += hold.repetitions});
  return total;
}
