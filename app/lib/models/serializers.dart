import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:app/models/models.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Board,
  BoardHold,
  CompletedWorkout,
  CompletedWorkouts,
  DeviceInfo,
  Fingers,
  Grip,
  HandHold,
  HandType,
  Hold,
  HoldType,
  Label,
  Settings,
  Sound,
  TempUnit,
  WeightUnit,
  Workout,
  Workouts,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
