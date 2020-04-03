import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';

part 'completed_workouts.g.dart';

abstract class CompletedWorkouts
    implements Built<CompletedWorkouts, CompletedWorkoutsBuilder> {
  static Serializer<CompletedWorkouts> get serializer =>
      _$completedWorkoutsSerializer;

  BuiltList<CompletedWorkout> get completedWorkouts;

  factory CompletedWorkouts([void Function(CompletedWorkoutsBuilder) updates]) =
      _$CompletedWorkouts;
  CompletedWorkouts._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(CompletedWorkouts.serializer, this));
  }

  static CompletedWorkouts fromJson(String jsonString) {
    return serializers.deserializeWith(
        CompletedWorkouts.serializer, json.decode(jsonString));
  }
}
