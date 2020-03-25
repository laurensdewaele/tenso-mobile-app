import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'temp_unit.g.dart';

class TempUnit extends EnumClass {
  static Serializer<TempUnit> get serializer => _$tempUnitSerializer;

  static const TempUnit fahrenheit = _$fahrenheit;
  static const TempUnit celsius = _$celsius;

  const TempUnit._(String name) : super(name);

  static BuiltSet<TempUnit> get values => _$stValues;
  static TempUnit valueOf(String name) => _$stValueOf(name);
}
