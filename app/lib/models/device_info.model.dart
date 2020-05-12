import 'dart:convert';

import 'package:app/models/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'device_info.model.g.dart';

abstract class DeviceInfo implements Built<DeviceInfo, DeviceInfoBuilder> {
  static Serializer<DeviceInfo> get serializer => _$deviceInfoSerializer;

  bool get firstLaunch;

  factory DeviceInfo([void Function(DeviceInfoBuilder) updates]) = _$DeviceInfo;
  DeviceInfo._();

  String toJson() {
    return json.encode(serializers.serializeWith(DeviceInfo.serializer, this));
  }

  static DeviceInfo fromJson(String jsonString) {
    return serializers.deserializeWith(
        DeviceInfo.serializer, json.decode(jsonString));
  }
}
