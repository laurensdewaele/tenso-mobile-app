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
  ExecutionEvent,
  ExecutionEventType,
  Fingers,
  Grip,
  HandHold,
  HandType,
  History,
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
