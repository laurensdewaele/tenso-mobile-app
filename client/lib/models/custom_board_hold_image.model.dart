import 'dart:convert';
import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'custom_board_hold_image.model.g.dart';

abstract class CustomBoardHoldImage
    implements Built<CustomBoardHoldImage, CustomBoardHoldImageBuilder> {
  static Serializer<CustomBoardHoldImage> get serializer =>
      _$customBoardHoldImageSerializer;

  BuiltList<int> get positions;
  HoldType get holdType;
  double get leftPercent;
  double get topPercent;
  double get widthPercent;
  double get heightPercent;
  // We need to scale images because Figma adds pixels to the original
  // measurements, in order to add room for the shadows.
  double get scale;
  String get imageAsset;

  Rect getRect({double boardWidth, double boardHeight}) {
    return Rect.fromLTWH(leftPercent * boardWidth, topPercent * boardHeight,
        widthPercent * boardWidth, heightPercent * boardHeight);
  }

  factory CustomBoardHoldImage(
          [void Function(CustomBoardHoldImageBuilder) updates]) =
      _$CustomBoardHoldImage;
  CustomBoardHoldImage._();

  String toJson() {
    return json.encode(
        serializers.serializeWith(CustomBoardHoldImage.serializer, this));
  }

  static CustomBoardHoldImage fromJson(String jsonString) {
    return serializers.deserializeWith(
        CustomBoardHoldImage.serializer, json.decode(jsonString));
  }
}
