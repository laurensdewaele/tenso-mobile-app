import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/models/serializers.dart';

part 'versioning.model.g.dart';

abstract class Versioning implements Built<Versioning, VersioningBuilder> {
  static Serializer<Versioning> get serializer => _$versioningSerializer;

  BuiltList<Version> get versions;

  factory Versioning([void Function(VersioningBuilder) updates]) = _$Versioning;
  Versioning._();

  String toJson() {
    return json.encode(serializers.serializeWith(Versioning.serializer, this));
  }

  static Versioning fromJson(String jsonString) {
    return serializers.deserializeWith(
        Versioning.serializer, json.decode(jsonString));
  }
}
