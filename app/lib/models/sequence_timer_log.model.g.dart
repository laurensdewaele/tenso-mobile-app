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
      'index',
      serializers.serialize(object.index, specifiedType: const FullType(int)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(SequenceTimerType)),
      'originalDurationS',
      serializers.serialize(object.originalDurationS,
          specifiedType: const FullType(int)),
      'effectiveDurationMs',
      serializers.serialize(object.effectiveDurationMs,
          specifiedType: const FullType(double)),
      'originalAddedWeight',
      serializers.serialize(object.originalAddedWeight,
          specifiedType: const FullType(double)),
      'effectiveAddedWeight',
      serializers.serialize(object.effectiveAddedWeight,
          specifiedType: const FullType(double)),
      'weightSystem',
      serializers.serialize(object.weightSystem,
          specifiedType: const FullType(WeightSystem)),
      'skipped',
      serializers.serialize(object.skipped,
          specifiedType: const FullType(bool)),
      'stopped',
      serializers.serialize(object.stopped,
          specifiedType: const FullType(bool)),
      'groupIndex',
      serializers.serialize(object.groupIndex,
          specifiedType: const FullType(int)),
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
        case 'index':
          result.index = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
                  specifiedType: const FullType(SequenceTimerType))
              as SequenceTimerType;
          break;
        case 'originalDurationS':
          result.originalDurationS = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'effectiveDurationMs':
          result.effectiveDurationMs = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'originalAddedWeight':
          result.originalAddedWeight = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'effectiveAddedWeight':
          result.effectiveAddedWeight = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'weightSystem':
          result.weightSystem = serializers.deserialize(value,
              specifiedType: const FullType(WeightSystem)) as WeightSystem;
          break;
        case 'skipped':
          result.skipped = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'stopped':
          result.stopped = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'groupIndex':
          result.groupIndex = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$SequenceTimerLog extends SequenceTimerLog {
  @override
  final int index;
  @override
  final SequenceTimerType type;
  @override
  final int originalDurationS;
  @override
  final double effectiveDurationMs;
  @override
  final double originalAddedWeight;
  @override
  final double effectiveAddedWeight;
  @override
  final WeightSystem weightSystem;
  @override
  final bool skipped;
  @override
  final bool stopped;
  @override
  final int groupIndex;

  factory _$SequenceTimerLog(
          [void Function(SequenceTimerLogBuilder) updates]) =>
      (new SequenceTimerLogBuilder()..update(updates)).build();

  _$SequenceTimerLog._(
      {this.index,
      this.type,
      this.originalDurationS,
      this.effectiveDurationMs,
      this.originalAddedWeight,
      this.effectiveAddedWeight,
      this.weightSystem,
      this.skipped,
      this.stopped,
      this.groupIndex})
      : super._() {
    if (index == null) {
      throw new BuiltValueNullFieldError('SequenceTimerLog', 'index');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('SequenceTimerLog', 'type');
    }
    if (originalDurationS == null) {
      throw new BuiltValueNullFieldError(
          'SequenceTimerLog', 'originalDurationS');
    }
    if (effectiveDurationMs == null) {
      throw new BuiltValueNullFieldError(
          'SequenceTimerLog', 'effectiveDurationMs');
    }
    if (originalAddedWeight == null) {
      throw new BuiltValueNullFieldError(
          'SequenceTimerLog', 'originalAddedWeight');
    }
    if (effectiveAddedWeight == null) {
      throw new BuiltValueNullFieldError(
          'SequenceTimerLog', 'effectiveAddedWeight');
    }
    if (weightSystem == null) {
      throw new BuiltValueNullFieldError('SequenceTimerLog', 'weightSystem');
    }
    if (skipped == null) {
      throw new BuiltValueNullFieldError('SequenceTimerLog', 'skipped');
    }
    if (stopped == null) {
      throw new BuiltValueNullFieldError('SequenceTimerLog', 'stopped');
    }
    if (groupIndex == null) {
      throw new BuiltValueNullFieldError('SequenceTimerLog', 'groupIndex');
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
        index == other.index &&
        type == other.type &&
        originalDurationS == other.originalDurationS &&
        effectiveDurationMs == other.effectiveDurationMs &&
        originalAddedWeight == other.originalAddedWeight &&
        effectiveAddedWeight == other.effectiveAddedWeight &&
        weightSystem == other.weightSystem &&
        skipped == other.skipped &&
        stopped == other.stopped &&
        groupIndex == other.groupIndex;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc($jc(0, index.hashCode), type.hashCode),
                                    originalDurationS.hashCode),
                                effectiveDurationMs.hashCode),
                            originalAddedWeight.hashCode),
                        effectiveAddedWeight.hashCode),
                    weightSystem.hashCode),
                skipped.hashCode),
            stopped.hashCode),
        groupIndex.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SequenceTimerLog')
          ..add('index', index)
          ..add('type', type)
          ..add('originalDurationS', originalDurationS)
          ..add('effectiveDurationMs', effectiveDurationMs)
          ..add('originalAddedWeight', originalAddedWeight)
          ..add('effectiveAddedWeight', effectiveAddedWeight)
          ..add('weightSystem', weightSystem)
          ..add('skipped', skipped)
          ..add('stopped', stopped)
          ..add('groupIndex', groupIndex))
        .toString();
  }
}

class SequenceTimerLogBuilder
    implements Builder<SequenceTimerLog, SequenceTimerLogBuilder> {
  _$SequenceTimerLog _$v;

  int _index;
  int get index => _$this._index;
  set index(int index) => _$this._index = index;

  SequenceTimerType _type;
  SequenceTimerType get type => _$this._type;
  set type(SequenceTimerType type) => _$this._type = type;

  int _originalDurationS;
  int get originalDurationS => _$this._originalDurationS;
  set originalDurationS(int originalDurationS) =>
      _$this._originalDurationS = originalDurationS;

  double _effectiveDurationMs;
  double get effectiveDurationMs => _$this._effectiveDurationMs;
  set effectiveDurationMs(double effectiveDurationMs) =>
      _$this._effectiveDurationMs = effectiveDurationMs;

  double _originalAddedWeight;
  double get originalAddedWeight => _$this._originalAddedWeight;
  set originalAddedWeight(double originalAddedWeight) =>
      _$this._originalAddedWeight = originalAddedWeight;

  double _effectiveAddedWeight;
  double get effectiveAddedWeight => _$this._effectiveAddedWeight;
  set effectiveAddedWeight(double effectiveAddedWeight) =>
      _$this._effectiveAddedWeight = effectiveAddedWeight;

  WeightSystem _weightSystem;
  WeightSystem get weightSystem => _$this._weightSystem;
  set weightSystem(WeightSystem weightSystem) =>
      _$this._weightSystem = weightSystem;

  bool _skipped;
  bool get skipped => _$this._skipped;
  set skipped(bool skipped) => _$this._skipped = skipped;

  bool _stopped;
  bool get stopped => _$this._stopped;
  set stopped(bool stopped) => _$this._stopped = stopped;

  int _groupIndex;
  int get groupIndex => _$this._groupIndex;
  set groupIndex(int groupIndex) => _$this._groupIndex = groupIndex;

  SequenceTimerLogBuilder();

  SequenceTimerLogBuilder get _$this {
    if (_$v != null) {
      _index = _$v.index;
      _type = _$v.type;
      _originalDurationS = _$v.originalDurationS;
      _effectiveDurationMs = _$v.effectiveDurationMs;
      _originalAddedWeight = _$v.originalAddedWeight;
      _effectiveAddedWeight = _$v.effectiveAddedWeight;
      _weightSystem = _$v.weightSystem;
      _skipped = _$v.skipped;
      _stopped = _$v.stopped;
      _groupIndex = _$v.groupIndex;
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
            index: index,
            type: type,
            originalDurationS: originalDurationS,
            effectiveDurationMs: effectiveDurationMs,
            originalAddedWeight: originalAddedWeight,
            effectiveAddedWeight: effectiveAddedWeight,
            weightSystem: weightSystem,
            skipped: skipped,
            stopped: stopped,
            groupIndex: groupIndex);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
