// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'versioning.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Versioning> _$versioningSerializer = new _$VersioningSerializer();

class _$VersioningSerializer implements StructuredSerializer<Versioning> {
  @override
  final Iterable<Type> types = const [Versioning, _$Versioning];
  @override
  final String wireName = 'Versioning';

  @override
  Iterable<Object> serialize(Serializers serializers, Versioning object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'versions',
      serializers.serialize(object.versions,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Version)])),
    ];

    return result;
  }

  @override
  Versioning deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VersioningBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'versions':
          result.versions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Version)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$Versioning extends Versioning {
  @override
  final BuiltList<Version> versions;

  factory _$Versioning([void Function(VersioningBuilder) updates]) =>
      (new VersioningBuilder()..update(updates)).build();

  _$Versioning._({this.versions}) : super._() {
    if (versions == null) {
      throw new BuiltValueNullFieldError('Versioning', 'versions');
    }
  }

  @override
  Versioning rebuild(void Function(VersioningBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VersioningBuilder toBuilder() => new VersioningBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Versioning && versions == other.versions;
  }

  @override
  int get hashCode {
    return $jf($jc(0, versions.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Versioning')
          ..add('versions', versions))
        .toString();
  }
}

class VersioningBuilder implements Builder<Versioning, VersioningBuilder> {
  _$Versioning _$v;

  ListBuilder<Version> _versions;
  ListBuilder<Version> get versions =>
      _$this._versions ??= new ListBuilder<Version>();
  set versions(ListBuilder<Version> versions) => _$this._versions = versions;

  VersioningBuilder();

  VersioningBuilder get _$this {
    if (_$v != null) {
      _versions = _$v.versions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Versioning other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Versioning;
  }

  @override
  void update(void Function(VersioningBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Versioning build() {
    _$Versioning _$result;
    try {
      _$result = _$v ?? new _$Versioning._(versions: versions.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'versions';
        versions.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Versioning', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
