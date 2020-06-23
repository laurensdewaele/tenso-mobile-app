import 'package:app/models/models.dart';

final Workout emptyWorkout = Workout((b) => b
  ..restBetweenGroupsFixed = false
  ..restBetweenGroupsS = 180
  ..groups.addAll([])
  ..id = 'empty-workout'
  ..label = Label.yellow
  ..weightSystem = WeightSystem.metric
  ..name = '');
