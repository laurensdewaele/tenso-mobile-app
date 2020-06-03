// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_metrics.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LoggedMetrics> _$loggedMetricsSerializer =
    new _$LoggedMetricsSerializer();

class _$LoggedMetricsSerializer implements StructuredSerializer<LoggedMetrics> {
  @override
  final Iterable<Type> types = const [LoggedMetrics, _$LoggedMetrics];
  @override
  final String wireName = 'LoggedMetrics';

  @override
  Iterable<Object> serialize(Serializers serializers, LoggedMetrics object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'duration',
      serializers.serialize(object.duration,
          specifiedType: const FullType(int)),
      'addedWeight',
      serializers.serialize(object.addedWeight,
          specifiedType: const FullType(double)),
      'currentHang',
      serializers.serialize(object.currentHang,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  LoggedMetrics deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LoggedMetricsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'addedWeight':
          result.addedWeight = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'currentHang':
          result.currentHang = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$LoggedMetrics extends LoggedMetrics {
  @override
  final int duration;
  @override
  final double addedWeight;
  @override
  final int currentHang;

  factory _$LoggedMetrics([void Function(LoggedMetricsBuilder) updates]) =>
      (new LoggedMetricsBuilder()..update(updates)).build();

  _$LoggedMetrics._({this.duration, this.addedWeight, this.currentHang})
      : super._() {
    if (duration == null) {
      throw new BuiltValueNullFieldError('LoggedMetrics', 'duration');
    }
    if (addedWeight == null) {
      throw new BuiltValueNullFieldError('LoggedMetrics', 'addedWeight');
    }
    if (currentHang == null) {
      throw new BuiltValueNullFieldError('LoggedMetrics', 'currentHang');
    }
  }

  @override
  LoggedMetrics rebuild(void Function(LoggedMetricsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoggedMetricsBuilder toBuilder() => new LoggedMetricsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoggedMetrics &&
        duration == other.duration &&
        addedWeight == other.addedWeight &&
        currentHang == other.currentHang;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, duration.hashCode), addedWeight.hashCode),
        currentHang.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoggedMetrics')
          ..add('duration', duration)
          ..add('addedWeight', addedWeight)
          ..add('currentHang', currentHang))
        .toString();
  }
}

class LoggedMetricsBuilder
    implements Builder<LoggedMetrics, LoggedMetricsBuilder> {
  _$LoggedMetrics _$v;

  int _duration;
  int get duration => _$this._duration;
  set duration(int duration) => _$this._duration = duration;

  double _addedWeight;
  double get addedWeight => _$this._addedWeight;
  set addedWeight(double addedWeight) => _$this._addedWeight = addedWeight;

  int _currentHang;
  int get currentHang => _$this._currentHang;
  set currentHang(int currentHang) => _$this._currentHang = currentHang;

  LoggedMetricsBuilder();

  LoggedMetricsBuilder get _$this {
    if (_$v != null) {
      _duration = _$v.duration;
      _addedWeight = _$v.addedWeight;
      _currentHang = _$v.currentHang;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoggedMetrics other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LoggedMetrics;
  }

  @override
  void update(void Function(LoggedMetricsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoggedMetrics build() {
    final _$result = _$v ??
        new _$LoggedMetrics._(
            duration: duration,
            addedWeight: addedWeight,
            currentHang: currentHang);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
