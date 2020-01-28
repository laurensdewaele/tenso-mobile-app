// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GradeType _$sportFrench = const GradeType._('sportFrench');
const GradeType _$sportUSA = const GradeType._('sportUSA');
const GradeType _$boulderVScale = const GradeType._('boulderVScale');
const GradeType _$boulderFont = const GradeType._('boulderFont');

GradeType _$stValueOf(String name) {
  switch (name) {
    case 'sportFrench':
      return _$sportFrench;
    case 'sportUSA':
      return _$sportUSA;
    case 'boulderVScale':
      return _$boulderVScale;
    case 'boulderFont':
      return _$boulderFont;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GradeType> _$stValues =
    new BuiltSet<GradeType>(const <GradeType>[
  _$sportFrench,
  _$sportUSA,
  _$boulderVScale,
  _$boulderFont,
]);

Serializer<GradeType> _$gradeTypeSerializer = new _$GradeTypeSerializer();

class _$GradeTypeSerializer implements PrimitiveSerializer<GradeType> {
  @override
  final Iterable<Type> types = const <Type>[GradeType];
  @override
  final String wireName = 'GradeType';

  @override
  Object serialize(Serializers serializers, GradeType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GradeType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GradeType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
