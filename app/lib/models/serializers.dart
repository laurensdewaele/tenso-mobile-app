import 'package:app/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Board,
  Boards,
  BoardHold,
  CompletedWorkout,
  CompletedWorkouts,
  DeviceInfo,
  Fingers,
  Grip,
  Group,
  HandHold,
  HandType,
  History,
  HoldType,
  Label,
  Settings,
  SequenceTimerLog,
  SequenceTimerType,
  Sound,
  TempUnit,
  WeightSystem,
  Workout,
  Workouts,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
