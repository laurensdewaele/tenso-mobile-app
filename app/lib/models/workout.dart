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
  int get sets;
  int get holdCount;
  bool get countdownRestTimer;
  Board get board;
  BuiltList<Hold> get holds;
  WeightUnit get weightUnit;
  String get name;
  Label get label;

  bool get stopwatchRestTimer => !countdownRestTimer;
  // Color class cannot be serialized by built value
  Color get labelColor => styles.labelColors[label];
  int get timeUnderTension => _calculateTimeUnderTension();
  int get totalRestTime => _calculateTotalRestTime();
  double get averageAddedWeight => _calculateAverageAddedWeight();
  int get averageHangTime => _calculateAverageHangTime();
  int get totalHangsPerSet => _calculateTotalHangsPerSet();

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

  int _calculateTimeUnderTension() {
    int _total = 0;
    holds.forEach((hold) {
      _total += hold.hangTime * hold.repetitions;
    });
    return _total * sets;
  }

  int _calculateTotalRestTime() {
    if (countdownRestTimer == false) {
      return 0;
    }

    int _total = 0;
    int _currentHang = 1;
    int _currentSet = 1;
    final int _totalHangs = totalHangsPerSet * sets;
    while (_currentSet <= sets) {
      holds.forEach((hold) {
        int _currentRep = 1;
        while (_currentRep <= hold.repetitions) {
          if (_currentHang < _totalHangs) {
            _total += hold.countdownRestDuration;
            _currentHang++;
          }
          _currentRep++;
        }
      });
      _currentSet++;
    }

    return _total;
  }

  int _calculateTotalHangsPerSet() {
    int total = 0;
    holds.forEach((hold) => {total += hold.repetitions});
    return total;
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
