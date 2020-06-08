import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'group.model.g.dart';

abstract class Group implements Built<Group, GroupBuilder> {
  static Serializer<Group> get serializer => _$groupSerializer;

  Board get board;

  HandHold get handHold;
  @nullable
  Grip get leftGrip;
  @nullable
  Grip get rightGrip;
  @nullable
  BoardHold get leftGripBoardHold;
  @nullable
  BoardHold get rightGripBoardHold;

  bool get repeaters;

  int get repetitions;
  int get hangTimeS;

  bool get restBetweenRepsFixed;
  @nullable
  int get restBetweenRepsS;

  @nullable
  int get sets;
  @nullable
  bool get restBetweenSetsFixed;
  @nullable
  int get restBetweenSetsS;

  double get addedWeight;

  factory Group([void Function(GroupBuilder) updates]) = _$Group;

  Group._();

  String toJson() {
    return json.encode(serializers.serializeWith(Group.serializer, this));
  }

  static Group fromJson(String jsonString) {
    return serializers.deserializeWith(
        Group.serializer, json.decode(jsonString));
  }
}
