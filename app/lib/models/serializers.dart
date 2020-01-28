import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/hold_type.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Board,
  BoardHold,
  HoldType,
//  Fingers,
//  Grades,
//  Grip,
//  HandHold,
//  HandType,
//  Hold,
//  MenuItem,
//  Sound,
//  Units,
//  Workout
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
