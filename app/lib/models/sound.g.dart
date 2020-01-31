// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Sound> _$soundSerializer = new _$SoundSerializer();

class _$SoundSerializer implements StructuredSerializer<Sound> {
  @override
  final Iterable<Type> types = const [Sound, _$Sound];
  @override
  final String wireName = 'Sound';

  @override
  Iterable<Object> serialize(Serializers serializers, Sound object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object>[];
  }

  @override
  Sound deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new SoundBuilder().build();
  }
}

class _$Sound extends Sound {
  factory _$Sound([void Function(SoundBuilder) updates]) =>
      (new SoundBuilder()..update(updates)).build();

  _$Sound._() : super._();

  @override
  Sound rebuild(void Function(SoundBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SoundBuilder toBuilder() => new SoundBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Sound;
  }

  @override
  int get hashCode {
    return 685040891;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('Sound').toString();
  }
}

class SoundBuilder implements Builder<Sound, SoundBuilder> {
  _$Sound _$v;

  SoundBuilder();

  @override
  void replace(Sound other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Sound;
  }

  @override
  void update(void Function(SoundBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Sound build() {
    final _$result = _$v ?? new _$Sound._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
