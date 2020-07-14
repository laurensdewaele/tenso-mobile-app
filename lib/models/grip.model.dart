import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/models/serializers.dart';

part 'grip.model.g.dart';

abstract class Grip implements Built<Grip, GripBuilder> {
  static Serializer<Grip> get serializer => _$gripSerializer;

  HandType get handType;
  Fingers get fingers;
  bool get crimped;
  String get imageAsset;
  String get name;
  String get description;
  double get anchorX;
  double get anchorY;
  double get anchorXPercent => anchorX / imageAssetWidth;
  double get anchorYPercent => anchorY / imageAssetHeight;
  double get imageAssetWidth;
  double get imageAssetHeight;
  double get aspectRatio => imageAssetWidth / imageAssetHeight;

  factory Grip([void Function(GripBuilder) updates]) = _$Grip;
  Grip._();

  String toJson() {
    return json.encode(serializers.serializeWith(Grip.serializer, this));
  }

  static Grip fromJson(String jsonString) {
    return serializers.deserializeWith(
        Grip.serializer, json.decode(jsonString));
  }
}
