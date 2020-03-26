import 'dart:convert';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/serializers.dart';
import 'package:app/models/weight_unit.dart';

part 'workout.g.dart';

abstract class Workout implements Built<Workout, WorkoutBuilder> {
  static Serializer<Workout> get serializer => _$workoutSerializer;

  String get id;

  // This is used for easily comparing which completed workout
  // is different from the other without having to do a deep comparison.
  @nullable
  String get editedId;

  Color get label;
  int get sets;
  int get holdCount;
  int get restBetweenHolds;
  int get restBetweenSets;
  Board get board;
  BuiltList<Hold> get holds;
  String get name;
  WeightUnit get weightUnit;
  int get duration => _calculateDuration();

  factory Workout([void Function(WorkoutBuilder) updates]) = _$Workout;
  Workout._();

  String toJson() {
    return json.encode(serializers.serializeWith(Workout.serializer, this));
  }

  static Workout fromJson(String jsonString) {
    return serializers.deserializeWith(
        Workout.serializer, json.decode(jsonString));
  }

  int _calculateDuration() {
    int total = 0;
    int totalHangTimePerSet = 0;
    int totalRestBetweenRepsPerSet = 0;
    int totalRestBetweenHoldsPerSet = 0;
    int totalRestBetweenSets = 0;

    holds.forEach((hold) {
      if (hold.repetitions > 1) {
        totalRestBetweenRepsPerSet +=
            (hold.repetitions - 1) * hold.restBetweenRepetitions;
      }
      totalHangTimePerSet += hold.hangTime * hold.repetitions;
    });

    if (holds.length > 1) {
      totalRestBetweenHoldsPerSet += (holds.length - 1) * restBetweenHolds;
    }
    if (sets > 1) {
      totalRestBetweenSets += (sets - 1) * restBetweenSets;
    }
    for (var i = 0; i < sets; i++) {
      total += totalHangTimePerSet +
          totalRestBetweenRepsPerSet +
          totalRestBetweenHoldsPerSet;
    }
    total += totalRestBetweenSets;
    return total.toInt();
  }
}
