import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:tenso_app/dto/feedback.dto.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/models/version.model.dart';
import 'package:tenso_app/models/versioning.model.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Board,
  Boards,
  BoardHold,
  CompletedWorkout,
  CompletedWorkouts,
  DeviceInfo,
  Feedback,
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
  Version,
  Versioning,
  WeightSystem,
  Workout,
  Workouts,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
