// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DeviceInfo> _$deviceInfoSerializer = new _$DeviceInfoSerializer();

class _$DeviceInfoSerializer implements StructuredSerializer<DeviceInfo> {
  @override
  final Iterable<Type> types = const [DeviceInfo, _$DeviceInfo];
  @override
  final String wireName = 'DeviceInfo';

  @override
  Iterable<Object> serialize(Serializers serializers, DeviceInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'firstLaunch',
      serializers.serialize(object.firstLaunch,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  DeviceInfo deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DeviceInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'firstLaunch':
          result.firstLaunch = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$DeviceInfo extends DeviceInfo {
  @override
  final bool firstLaunch;

  factory _$DeviceInfo([void Function(DeviceInfoBuilder) updates]) =>
      (new DeviceInfoBuilder()..update(updates)).build();

  _$DeviceInfo._({this.firstLaunch}) : super._() {
    if (firstLaunch == null) {
      throw new BuiltValueNullFieldError('DeviceInfo', 'firstLaunch');
    }
  }

  @override
  DeviceInfo rebuild(void Function(DeviceInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeviceInfoBuilder toBuilder() => new DeviceInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeviceInfo && firstLaunch == other.firstLaunch;
  }

  @override
  int get hashCode {
    return $jf($jc(0, firstLaunch.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DeviceInfo')
          ..add('firstLaunch', firstLaunch))
        .toString();
  }
}

class DeviceInfoBuilder implements Builder<DeviceInfo, DeviceInfoBuilder> {
  _$DeviceInfo _$v;

  bool _firstLaunch;
  bool get firstLaunch => _$this._firstLaunch;
  set firstLaunch(bool firstLaunch) => _$this._firstLaunch = firstLaunch;

  DeviceInfoBuilder();

  DeviceInfoBuilder get _$this {
    if (_$v != null) {
      _firstLaunch = _$v.firstLaunch;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeviceInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DeviceInfo;
  }

  @override
  void update(void Function(DeviceInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DeviceInfo build() {
    final _$result = _$v ?? new _$DeviceInfo._(firstLaunch: firstLaunch);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
