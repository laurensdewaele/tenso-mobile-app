import 'dart:convert';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/serializers.dart';
import 'package:app/styles/styles.dart' as styles;

part 'workout.g.dart';

abstract class Workout implements Built<Workout, WorkoutBuilder> {
  static Serializer<Workout> get serializer => _$workoutSerializer;

  String get difficulty;
  int get sets;
  int get holdCount;
  int get restBetweenHolds;
  int get restBetweenSets;
  Board get board;
  BuiltList<Hold> get holds;
  String get name;
  Color get difficultyColor => _determineDifficultyColor();
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

  Color _determineDifficultyColor() {
    final int difficultyNo = int.parse(difficulty.split('')[0]);

    if (difficultyNo - 5 <= 0) {
      return styles.difficultyColors[0];
    }

    if (difficultyNo - 5 >= 4) {
      return styles.difficultyColors[4];
    }
    return styles.difficultyColors[difficultyNo - 5];
  }

  int _calculateDuration() {
    int value = 0;
    value += (sets - 1) * restBetweenSets;
    value += sets * (holds.length - 1) * restBetweenHolds;
    holds.forEach((hold) {
      value += (hold.restBetweenRepetitions - 1) * hold.repetitions;
      value += hold.hangTime;
    });
    return value.toInt();
  }
}
