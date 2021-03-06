import 'dart:convert';
import 'dart:ui';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/models/serializers.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

part 'completed_workout.model.g.dart';

abstract class CompletedWorkout
    implements Built<CompletedWorkout, CompletedWorkoutBuilder> {
  static Serializer<CompletedWorkout> get serializer =>
      _$completedWorkoutSerializer;

  String get id;

  History get history;

  Workout get workout;
  // Always save the date in UTC
  // Always display the date in local
  DateTime get completedDate;
  DateTime get completedLocalDate => completedDate.toLocal();

  int get perceivedExertion;
  Color get perceivedExertionColor =>
      _determineExertionColor(perceivedExertion);
  @nullable
  double get bodyWeight;
  @nullable
  double get temperature;
  TempUnit get tempUnit;
  @nullable
  double get humidity;
  @nullable
  String get comments;

  int get averageAddedWeightInBodyWeightPercentage =>
      _calculateAverageAddedWeightInBodyWeightPercentage();

  int _calculateAverageAddedWeightInBodyWeightPercentage() {
    if (bodyWeight != null && history.averageAddedWeight != 0) {
      return 100 + ((history.averageAddedWeight / bodyWeight) * 100).round();
    } else {
      return null;
    }
  }

  Color _determineExertionColor(int perceivedExertion) {
    if (perceivedExertion == 10) return styles.difficultyColors[4];
    return styles.difficultyColors[perceivedExertion ~/ 2];
  }

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
