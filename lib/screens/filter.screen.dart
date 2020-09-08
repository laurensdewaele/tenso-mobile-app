import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';

class FilterWorkout {
  final String id;
  final String name;
  final Color labelColor;
  final int completedAmount;

  const FilterWorkout({
    @required this.id,
    @required this.name,
    @required this.labelColor,
    @required this.completedAmount,
  });
}

class FilterLabel {
  final Label label;
  final Color labelColor;
  final int completedAmount;

  const FilterLabel({
    @required this.label,
    @required this.labelColor,
    @required this.completedAmount,
  });
}

class FilterScreen extends StatelessWidget {
  FilterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
