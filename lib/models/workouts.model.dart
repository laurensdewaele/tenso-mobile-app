import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workouts.model.g.dart';

abstract class Workouts implements Built<Workouts, WorkoutsBuilder> {
  static Serializer<Workouts> get serializer => _$workoutsSerializer;

  BuiltList<Workout> get workouts;

  factory Workouts([void Function(WorkoutsBuilder) updates]) = _$Workouts;
  Workouts._();

  String toJson() {
    return json.encode(serializers.serializeWith(Workouts.serializer, this));
  }

  static Workouts fromJson(String jsonString) {
    return serializers.deserializeWith(
        Workouts.serializer, json.decode(jsonString));
  }
}
