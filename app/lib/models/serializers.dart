import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/fingers.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hand_type.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/hold_type.dart';
import 'package:app/models/menu_item.dart';
import 'package:app/models/unit.dart';
import 'package:app/models/workout.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Board,
  BoardHold,
  HoldType,
  Fingers,
  Grip,
  HandHold,
  HandType,
  Hold,
  MenuItem,
  Unit,
  Workout
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
