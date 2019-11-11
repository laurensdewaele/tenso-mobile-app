import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';
import 'package:app/widgets/card.dart';

class CardOverviewExpanded extends StatelessWidget {
  const CardOverviewExpanded({@required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Card(child: Text('$workout.title, expanded'));
  }
}
