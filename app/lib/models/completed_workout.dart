import 'dart:convert';
import 'dart:ui';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/helpers/determine_difficulty_color.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/serializers.dart';

part 'completed_workout.g.dart';

abstract class CompletedWorkout
    implements Built<CompletedWorkout, CompletedWorkoutBuilder> {
  static Serializer<CompletedWorkout> get serializer =>
      _$completedWorkoutSerializer;

  Workout get workout;
  // Always save the date in UTC
  // Always display the date in local
  String get id;
  DateTime get completedDate;
  DateTime get completedLocalDate => completedDate.toLocal();
  int get perceivedExertion;
  Color get perceivedExertionColor => determineDifficultyColor(perceivedExertion);

  factory CompletedWorkout([void Function(CompletedWorkoutBuilder) updates]) =
      _$CompletedWorkout;
  CompletedWorkout._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(CompletedWorkout.serializer, this));
  }

  static CompletedWorkout fromJson(String jsonString) {
    return serializers.deserializeWith(
        CompletedWorkout.serializer, json.decode(jsonString));
  }
}
