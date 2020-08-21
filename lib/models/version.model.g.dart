// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Version> _$versionSerializer = new _$VersionSerializer();

class _$VersionSerializer implements StructuredSerializer<Version> {
  @override
  final Iterable<Type> types = const [Version, _$Version];
  @override
  final String wireName = 'Version';

  @override
  Iterable<Object> serialize(Serializers serializers, Version object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'no',
      serializers.serialize(object.no, specifiedType: const FullType(String)),
      'incrementalNo',
      serializers.serialize(object.incrementalNo,
          specifiedType: const FullType(int)),
      'date',
      serializers.serialize(object.date,
          specifiedType: const FullType(DateTime)),
      'changelog',
      serializers.serialize(object.changelog,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  Version deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VersionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'no':
          result.no = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'incrementalNo':
          result.incrementalNo = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'changelog':
          result.changelog.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$Version extends Version {
  @override
  final String no;
  @override
  final int incrementalNo;
  @override
  final DateTime date;
  @override
  final BuiltList<String> changelog;

  factory _$Version([void Function(VersionBuilder) updates]) =>
      (new VersionBuilder()..update(updates)).build();

  _$Version._({this.no, this.incrementalNo, this.date, this.changelog})
      : super._() {
    if (no == null) {
      throw new BuiltValueNullFieldError('Version', 'no');
    }
    if (incrementalNo == null) {
      throw new BuiltValueNullFieldError('Version', 'incrementalNo');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('Version', 'date');
    }
    if (changelog == null) {
      throw new BuiltValueNullFieldError('Version', 'changelog');
    }
  }

  @override
  Version rebuild(void Function(VersionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VersionBuilder toBuilder() => new VersionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Version &&
        no == other.no &&
        incrementalNo == other.incrementalNo &&
        date == other.date &&
        changelog == other.changelog;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, no.hashCode), incrementalNo.hashCode), date.hashCode),
        changelog.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Version')
          ..add('no', no)
          ..add('incrementalNo', incrementalNo)
          ..add('date', date)
          ..add('changelog', changelog))
        .toString();
  }
}

class VersionBuilder implements Builder<Version, VersionBuilder> {
  _$Version _$v;

  String _no;
  String get no => _$this._no;
  set no(String no) => _$this._no = no;

  int _incrementalNo;
  int get incrementalNo => _$this._incrementalNo;
  set incrementalNo(int incrementalNo) => _$this._incrementalNo = incrementalNo;

  DateTime _date;
  DateTime get date => _$this._date;
  set date(DateTime date) => _$this._date = date;

  ListBuilder<String> _changelog;
  ListBuilder<String> get changelog =>
      _$this._changelog ??= new ListBuilder<String>();
  set changelog(ListBuilder<String> changelog) => _$this._changelog = changelog;

  VersionBuilder();

  VersionBuilder get _$this {
    if (_$v != null) {
      _no = _$v.no;
      _incrementalNo = _$v.incrementalNo;
      _date = _$v.date;
      _changelog = _$v.changelog?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Version other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Version;
  }

  @override
  void update(void Function(VersionBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Version build() {
    _$Version _$result;
    try {
      _$result = _$v ??
          new _$Version._(
              no: no,
              incrementalNo: incrementalNo,
              date: date,
              changelog: changelog.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'changelog';
        changelog.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Version', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
