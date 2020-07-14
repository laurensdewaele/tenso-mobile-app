import 'dart:convert';

import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'board.model.g.dart';

abstract class Board implements Built<Board, BoardBuilder> {
  static Serializer<Board> get serializer => _$boardSerializer;

  String get id;
  @nullable
  BuiltList<CustomBoardHoldImage> get customBoardHoldImages;
  @nullable
  String get manufacturer;
  @nullable
  String get model;
  String get name;
  String get imageAsset;
  double get imageAssetHeight;
  double get imageAssetWidth;
  double get handToBoardHeightRatio;
  BuiltList<BoardHold> get boardHolds;
  BoardHold get defaultLeftGripHold;
  BoardHold get defaultRightGripHold;
  double get aspectRatio => imageAssetWidth / imageAssetHeight;
  bool get isCustom => customBoardHoldImages != null;
  String get capitalizedName => _capitalizeName();

  String _capitalizeName() {
    if (name.length > 1) {
      return name[0].toUpperCase() + name.substring(1);
    } else {
      return name[0].toUpperCase();
    }
  }

  factory Board([void Function(BoardBuilder) updates]) = _$Board;
  Board._();

  String toJson() {
    return json.encode(serializers.serializeWith(Board.serializer, this));
  }

  static Board fromJson(String jsonString) {
    return serializers.deserializeWith(
        Board.serializer, json.decode(jsonString));
  }
}
