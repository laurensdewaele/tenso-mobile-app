// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequence_timer_log.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SequenceTimerLog> _$sequenceTimerLogSerializer =
    new _$SequenceTimerLogSerializer();

class _$SequenceTimerLogSerializer
    implements StructuredSerializer<SequenceTimerLog> {
  @override
  final Iterable<Type> types = const [SequenceTimerLog, _$SequenceTimerLog];
  @override
  final String wireName = 'SequenceTimerLog';

  @override
  Iterable<Object> serialize(Serializers serializers, SequenceTimerLog object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(SequenceTimerType)),
      'duration',
      serializers.serialize(object.duration,
          specifiedType: const FullType(int)),
      'effectiveDuration',
      serializers.serialize(object.effectiveDuration,
          specifiedType: const FullType(int)),
      'skipped',
      serializers.serialize(object.skipped,
          specifiedType: const FullType(bool)),
      'stopped',
      serializers.serialize(object.stopped,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  SequenceTimerLog deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SequenceTimerLogBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
                  specifiedType: const FullType(SequenceTimerType))
              as SequenceTimerType;
          break;
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'effectiveDuration':
          result.effectiveDuration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'skipped':
          result.skipped = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'stopped':
          result.stopped = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$SequenceTimerLog extends SequenceTimerLog {
  @override
  final SequenceTimerType type;
  @override
  final int duration;
  @override
  final int effectiveDuration;
  @override
  final bool skipped;
  @override
  final bool stopped;

  factory _$SequenceTimerLog(
          [void Function(SequenceTimerLogBuilder) updates]) =>
      (new SequenceTimerLogBuilder()..update(updates)).build();

  _$SequenceTimerLog._(
      {this.type,
      this.duration,
      this.effectiveDuration,
      this.skipped,
      this.stopped})
      : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('SequenceTimerLog', 'type');
    }
    if (duration == null) {
      throw new BuiltValueNullFieldError('SequenceTimerLog', 'duration');
    }
    if (effectiveDuration == null) {
      throw new BuiltValueNullFieldError(
          'SequenceTimerLog', 'effectiveDuration');
    }
    if (skipped == null) {
      throw new BuiltValueNullFieldError('SequenceTimerLog', 'skipped');
    }
    if (stopped == null) {
      throw new BuiltValueNullFieldError('SequenceTimerLog', 'stopped');
    }
  }

  @override
  SequenceTimerLog rebuild(void Function(SequenceTimerLogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SequenceTimerLogBuilder toBuilder() =>
      new SequenceTimerLogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SequenceTimerLog &&
        type == other.type &&
        duration == other.duration &&
        effectiveDuration == other.effectiveDuration &&
        skipped == other.skipped &&
        stopped == other.stopped;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, type.hashCode), duration.hashCode),
                effectiveDuration.hashCode),
            skipped.hashCode),
        stopped.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SequenceTimerLog')
          ..add('type', type)
          ..add('duration', duration)
          ..add('effectiveDuration', effectiveDuration)
          ..add('skipped', skipped)
          ..add('stopped', stopped))
        .toString();
  }
}

class SequenceTimerLogBuilder
    implements Builder<SequenceTimerLog, SequenceTimerLogBuilder> {
  _$SequenceTimerLog _$v;

  SequenceTimerType _type;
  SequenceTimerType get type => _$this._type;
  set type(SequenceTimerType type) => _$this._type = type;

  int _duration;
  int get duration => _$this._duration;
  set duration(int duration) => _$this._duration = duration;

  int _effectiveDuration;
  int get effectiveDuration => _$this._effectiveDuration;
  set effectiveDuration(int effectiveDuration) =>
      _$this._effectiveDuration = effectiveDuration;

  bool _skipped;
  bool get skipped => _$this._skipped;
  set skipped(bool skipped) => _$this._skipped = skipped;

  bool _stopped;
  bool get stopped => _$this._stopped;
  set stopped(bool stopped) => _$this._stopped = stopped;

  SequenceTimerLogBuilder();

  SequenceTimerLogBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _duration = _$v.duration;
      _effectiveDuration = _$v.effectiveDuration;
      _skipped = _$v.skipped;
      _stopped = _$v.stopped;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SequenceTimerLog other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SequenceTimerLog;
  }

  @override
  void update(void Function(SequenceTimerLogBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SequenceTimerLog build() {
    final _$result = _$v ??
        new _$SequenceTimerLog._(
            type: type,
            duration: duration,
            effectiveDuration: effectiveDuration,
            skipped: skipped,
            stopped: stopped);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
