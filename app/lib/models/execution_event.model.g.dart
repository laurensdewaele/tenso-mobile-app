// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution_event.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ExecutionEvent> _$executionEventSerializer =
    new _$ExecutionEventSerializer();

class _$ExecutionEventSerializer
    implements StructuredSerializer<ExecutionEvent> {
  @override
  final Iterable<Type> types = const [ExecutionEvent, _$ExecutionEvent];
  @override
  final String wireName = 'ExecutionEvent';

  @override
  Iterable<Object> serialize(Serializers serializers, ExecutionEvent object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'executionEventType',
      serializers.serialize(object.executionEventType,
          specifiedType: const FullType(ExecutionEventType)),
    ];
    if (object.elapsedMs != null) {
      result
        ..add('elapsedMs')
        ..add(serializers.serialize(object.elapsedMs,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ExecutionEvent deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExecutionEventBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'executionEventType':
          result.executionEventType = serializers.deserialize(value,
                  specifiedType: const FullType(ExecutionEventType))
              as ExecutionEventType;
          break;
        case 'elapsedMs':
          result.elapsedMs = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ExecutionEvent extends ExecutionEvent {
  @override
  final ExecutionEventType executionEventType;
  @override
  final int elapsedMs;

  factory _$ExecutionEvent([void Function(ExecutionEventBuilder) updates]) =>
      (new ExecutionEventBuilder()..update(updates)).build();

  _$ExecutionEvent._({this.executionEventType, this.elapsedMs}) : super._() {
    if (executionEventType == null) {
      throw new BuiltValueNullFieldError(
          'ExecutionEvent', 'executionEventType');
    }
  }

  @override
  ExecutionEvent rebuild(void Function(ExecutionEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExecutionEventBuilder toBuilder() =>
      new ExecutionEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExecutionEvent &&
        executionEventType == other.executionEventType &&
        elapsedMs == other.elapsedMs;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, executionEventType.hashCode), elapsedMs.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExecutionEvent')
          ..add('executionEventType', executionEventType)
          ..add('elapsedMs', elapsedMs))
        .toString();
  }
}

class ExecutionEventBuilder
    implements Builder<ExecutionEvent, ExecutionEventBuilder> {
  _$ExecutionEvent _$v;

  ExecutionEventType _executionEventType;
  ExecutionEventType get executionEventType => _$this._executionEventType;
  set executionEventType(ExecutionEventType executionEventType) =>
      _$this._executionEventType = executionEventType;

  int _elapsedMs;
  int get elapsedMs => _$this._elapsedMs;
  set elapsedMs(int elapsedMs) => _$this._elapsedMs = elapsedMs;

  ExecutionEventBuilder();

  ExecutionEventBuilder get _$this {
    if (_$v != null) {
      _executionEventType = _$v.executionEventType;
      _elapsedMs = _$v.elapsedMs;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExecutionEvent other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ExecutionEvent;
  }

  @override
  void update(void Function(ExecutionEventBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExecutionEvent build() {
    final _$result = _$v ??
        new _$ExecutionEvent._(
            executionEventType: executionEventType, elapsedMs: elapsedMs);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
