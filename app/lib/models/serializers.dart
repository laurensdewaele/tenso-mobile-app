import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/completed_workout.dart';
import 'package:app/models/completed_workouts.dart';
import 'package:app/models/device_info.dart';
import 'package:app/models/fingers.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hand_type.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/hold_type.dart';
import 'package:app/models/label.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/sound.dart';
import 'package:app/models/temp_unit.dart';
import 'package:app/models/weight_unit.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workouts.dart';

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
