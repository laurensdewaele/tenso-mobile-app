import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'weight_unit.g.dart';

class WeightUnit extends EnumClass {
  static Serializer<WeightUnit> get serializer => _$weightUnitSerializer;

  static const WeightUnit imperial = _$imperial;
  static const WeightUnit metric = _$metric;

  const WeightUnit._(String name) : super(name);

  static BuiltSet<WeightUnit> get values => _$stValues;
  static WeightUnit valueOf(String name) => _$stValueOf(name);
}
