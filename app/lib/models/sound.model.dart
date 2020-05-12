import 'dart:convert';

import 'package:app/models/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sound.model.g.dart';

abstract class Sound implements Built<Sound, SoundBuilder> {
  static Serializer<Sound> get serializer => _$soundSerializer;

  String get name;
  String get filename;
  bool get muted;

  factory Sound([void Function(SoundBuilder) updates]) = _$Sound;
  Sound._();

  String toJson() {
    return json.encode(serializers.serializeWith(Sound.serializer, this));
  }

  static Sound fromJson(String jsonString) {
    return serializers.deserializeWith(
        Sound.serializer, json.decode(jsonString));
  }
}
