import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unit.g.dart';

class Unit extends EnumClass {
  static Serializer<Unit> get serializer => _$unitSerializer;

  static const Unit imperial = _$imperial;
  static const Unit metric = _$metric;

  const Unit._(String name) : super(name);

  static BuiltSet<Unit> get values => _$stValues;
  static Unit valueOf(String name) => _$stValueOf(name);
}
