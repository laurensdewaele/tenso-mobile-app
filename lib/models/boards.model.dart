import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'boards.model.g.dart';

abstract class Boards implements Built<Boards, BoardsBuilder> {
  static Serializer<Boards> get serializer => _$boardsSerializer;

  BuiltList<Board> get boards;

  factory Boards([void Function(BoardsBuilder) updates]) = _$Boards;
  Boards._();

  String toJson() {
    return json.encode(serializers.serializeWith(Boards.serializer, this));
  }

  static Boards fromJson(String jsonString) {
    return serializers.deserializeWith(
        Boards.serializer, json.decode(jsonString));
  }
}
