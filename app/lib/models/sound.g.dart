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
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'filename',
      serializers.serialize(object.filename,
          specifiedType: const FullType(String)),
      'muted',
      serializers.serialize(object.muted, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  Sound deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SoundBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'filename':
          result.filename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'muted':
          result.muted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$Sound extends Sound {
  @override
  final String name;
  @override
  final String filename;
  @override
  final bool muted;

  factory _$Sound([void Function(SoundBuilder) updates]) =>
      (new SoundBuilder()..update(updates)).build();

  _$Sound._({this.name, this.filename, this.muted}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('Sound', 'name');
    }
    if (filename == null) {
      throw new BuiltValueNullFieldError('Sound', 'filename');
    }
    if (muted == null) {
      throw new BuiltValueNullFieldError('Sound', 'muted');
    }
  }

  @override
  Sound rebuild(void Function(SoundBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SoundBuilder toBuilder() => new SoundBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Sound &&
        name == other.name &&
        filename == other.filename &&
        muted == other.muted;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, name.hashCode), filename.hashCode), muted.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Sound')
          ..add('name', name)
          ..add('filename', filename)
          ..add('muted', muted))
        .toString();
  }
}

class SoundBuilder implements Builder<Sound, SoundBuilder> {
  _$Sound _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _filename;
  String get filename => _$this._filename;
  set filename(String filename) => _$this._filename = filename;

  bool _muted;
  bool get muted => _$this._muted;
  set muted(bool muted) => _$this._muted = muted;

  SoundBuilder();

  SoundBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _filename = _$v.filename;
      _muted = _$v.muted;
      _$v = null;
    }
    return this;
  }

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
    final _$result =
        _$v ?? new _$Sound._(name: name, filename: filename, muted: muted);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
