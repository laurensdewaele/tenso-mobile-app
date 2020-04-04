import 'dart:convert';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';
import 'package:app/styles/styles.dart' as styles;

part 'workout.g.dart';

abstract class Workout implements Built<Workout, WorkoutBuilder> {
  static Serializer<Workout> get serializer => _$workoutSerializer;

  String get id;

  // This is used for easily comparing which completed workout
  // is different from the other without having to do a deep comparison.
  @nullable
  String get editedId;

  Label get label;
  // Color class cannot be serialized by built value
  Color get labelColor => styles.labelColors[label];
  int get sets;
  int get holdCount;
  int get restBetweenHolds;
  int get restBetweenSets;
  Board get board;
  BuiltList<Hold> get holds;
  String get name;
  WeightUnit get weightUnit;
  int get duration => _calculateDuration();
  double get averageAddedWeight => _calculateAverageAddedWeight();
  int get averageHangTime => _calculateAverageHangTime();

  double _calculateAverageAddedWeight() {
    final List<double> weights = holds.map((w) => w.addedWeight).toList();
    final double total = weights.fold(0, (a, b) => a + b);
    final double average = total / weights.length;
    return double.parse(average.toStringAsFixed(1));
  }

  int _calculateAverageHangTime() {
    final List<int> hangSeconds = holds.map((w) => w.hangTime).toList();
    final double total = hangSeconds.fold(0, (a, b) => a + b);
    return total ~/ hangSeconds.length;
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

  factory Workout([void Function(WorkoutBuilder) updates]) = _$Workout;
  Workout._();

  String toJson() {
    return json.encode(serializers.serializeWith(Workout.serializer, this));
  }

  static Workout fromJson(String jsonString) {
    return serializers.deserializeWith(
        Workout.serializer, json.decode(jsonString));
  }
}
