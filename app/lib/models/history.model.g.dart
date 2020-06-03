// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<History> _$historySerializer = new _$HistorySerializer();

class _$HistorySerializer implements StructuredSerializer<History> {
  @override
  final Iterable<Type> types = const [History, _$History];
  @override
  final String wireName = 'History';

  @override
  Iterable<Object> serialize(Serializers serializers, History object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'loggedMetricsList',
      serializers.serialize(object.loggedMetricsList,
          specifiedType:
              const FullType(BuiltList, const [const FullType(LoggedMetrics)])),
      'eventLog',
      serializers.serialize(object.eventLog,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ExecutionEvent)])),
    ];

    return result;
  }

  @override
  History deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HistoryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'loggedMetricsList':
          result.loggedMetricsList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(LoggedMetrics)]))
              as BuiltList<Object>);
          break;
        case 'eventLog':
          result.eventLog.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ExecutionEvent)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$History extends History {
  @override
  final BuiltList<LoggedMetrics> loggedMetricsList;
  @override
  final BuiltList<ExecutionEvent> eventLog;

  factory _$History([void Function(HistoryBuilder) updates]) =>
      (new HistoryBuilder()..update(updates)).build();

  _$History._({this.loggedMetricsList, this.eventLog}) : super._() {
    if (loggedMetricsList == null) {
      throw new BuiltValueNullFieldError('History', 'loggedMetricsList');
    }
    if (eventLog == null) {
      throw new BuiltValueNullFieldError('History', 'eventLog');
    }
  }

  @override
  History rebuild(void Function(HistoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HistoryBuilder toBuilder() => new HistoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is History &&
        loggedMetricsList == other.loggedMetricsList &&
        eventLog == other.eventLog;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, loggedMetricsList.hashCode), eventLog.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('History')
          ..add('loggedMetricsList', loggedMetricsList)
          ..add('eventLog', eventLog))
        .toString();
  }
}

class HistoryBuilder implements Builder<History, HistoryBuilder> {
  _$History _$v;

  ListBuilder<LoggedMetrics> _loggedMetricsList;
  ListBuilder<LoggedMetrics> get loggedMetricsList =>
      _$this._loggedMetricsList ??= new ListBuilder<LoggedMetrics>();
  set loggedMetricsList(ListBuilder<LoggedMetrics> loggedMetricsList) =>
      _$this._loggedMetricsList = loggedMetricsList;

  ListBuilder<ExecutionEvent> _eventLog;
  ListBuilder<ExecutionEvent> get eventLog =>
      _$this._eventLog ??= new ListBuilder<ExecutionEvent>();
  set eventLog(ListBuilder<ExecutionEvent> eventLog) =>
      _$this._eventLog = eventLog;

  HistoryBuilder();

  HistoryBuilder get _$this {
    if (_$v != null) {
      _loggedMetricsList = _$v.loggedMetricsList?.toBuilder();
      _eventLog = _$v.eventLog?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(History other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$History;
  }

  @override
  void update(void Function(HistoryBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$History build() {
    _$History _$result;
    try {
      _$result = _$v ??
          new _$History._(
              loggedMetricsList: loggedMetricsList.build(),
              eventLog: eventLog.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'loggedMetricsList';
        loggedMetricsList.build();
        _$failedField = 'eventLog';
        eventLog.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'History', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
