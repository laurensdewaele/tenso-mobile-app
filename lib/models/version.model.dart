import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tenso_app/models/serializers.dart';

part 'version.model.g.dart';

abstract class Version implements Built<Version, VersionBuilder> {
  static Serializer<Version> get serializer => _$versionSerializer;

  String get no;
  DateTime get date;
  String get changelog;

  factory Version([void Function(VersionBuilder) updates]) = _$Version;
  Version._();

  String toJson() {
    return json.encode(serializers.serializeWith(Version.serializer, this));
  }

  static Version fromJson(String jsonString) {
    return serializers.deserializeWith(
        Version.serializer, json.decode(jsonString));
  }
}
