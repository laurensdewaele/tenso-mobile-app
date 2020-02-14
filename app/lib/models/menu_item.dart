import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/serializers.dart';

part 'menu_item.g.dart';

abstract class MenuItem implements Built<MenuItem, MenuItemBuilder> {
  static Serializer<MenuItem> get serializer => _$menuItemSerializer;

  String get name;
  String get route;

  factory MenuItem([void Function(MenuItemBuilder) updates]) = _$MenuItem;
  MenuItem._();

  String toJson() {
    return json.encode(serializers.serializeWith(MenuItem.serializer, this));
  }

  static MenuItem fromJson(String jsonString) {
    return serializers.deserializeWith(
        MenuItem.serializer, json.decode(jsonString));
  }
}
