import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/models/serializers.dart';

part 'workout.model.g.dart';

abstract class Workout implements Built<Workout, WorkoutBuilder> {
  static Serializer<Workout> get serializer => _$workoutSerializer;

  String get id;
  BuiltList<Group> get groups;
  WeightSystem get weightSystem;
  @nullable
  int get restBetweenGroupsS;
  bool get restBetweenGroupsFixed;
  String get name;
  Label get label;

  int get timeUnderTension => _calculateTimeUnderTension();
  int get totalRestTime => _calculateTotalRestTime();

  int _calculateTimeUnderTension() {
    int _total = 0;
    groups.forEach((Group group) {
      int _groupTotal = group.hangTimeS * group.reps;
      if (group.sets != null && group.sets > 0) {
        _groupTotal += _groupTotal * group.sets;
      }
      _total += _groupTotal;
    });
    return _total;
  }

  int _calculateTotalRestTime() {
    bool _canBeMeasured = true;

    if (restBetweenGroupsFixed != true && groups.length > 1) {
      _canBeMeasured = false;
    }

    groups.forEach((Group group) {
      if (group.restBetweenRepsFixed == false) {
        _canBeMeasured = false;
      }

      if (group.restBetweenSetsFixed != null &&
          group.restBetweenSetsFixed == false) {
        _canBeMeasured = false;
      }
    });

    if (_canBeMeasured == false) return null;

    int _total = 0;

    groups.forEach((Group group) {
      int _groupTotal = 0;
      _groupTotal += (group.reps - 1) * group.restBetweenRepsS;
      if (group.restBetweenSetsS != null &&
          group.restBetweenSetsS > 0 &&
          group.sets != null &&
          group.sets > 1) {
        _groupTotal += (group.sets - 1) * group.restBetweenSetsS;
      }
      _total += _groupTotal;
    });

    if (restBetweenGroupsFixed == true && restBetweenGroupsS > 0) {
      _total += (groups.length - 1) * restBetweenGroupsS;
    }

    return _total;
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
