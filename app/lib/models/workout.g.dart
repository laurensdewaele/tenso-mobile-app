// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Workout> _$workoutSerializer = new _$WorkoutSerializer();

class _$WorkoutSerializer implements StructuredSerializer<Workout> {
  @override
  final Iterable<Type> types = const [Workout, _$Workout];
  @override
  final String wireName = 'Workout';

  @override
  Iterable<Object> serialize(Serializers serializers, Workout object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'sets',
      serializers.serialize(object.sets, specifiedType: const FullType(int)),
      'holdCount',
      serializers.serialize(object.holdCount,
          specifiedType: const FullType(int)),
      'stopwatchRestTimers',
      serializers.serialize(object.stopwatchRestTimers,
          specifiedType: const FullType(bool)),
      'board',
      serializers.serialize(object.board, specifiedType: const FullType(Board)),
      'holds',
      serializers.serialize(object.holds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Hold)])),
      'weightUnit',
      serializers.serialize(object.weightUnit,
          specifiedType: const FullType(WeightUnit)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'label',
      serializers.serialize(object.label, specifiedType: const FullType(Label)),
    ];
    if (object.restBetweenHolds != null) {
      result
        ..add('restBetweenHolds')
        ..add(serializers.serialize(object.restBetweenHolds,
            specifiedType: const FullType(int)));
    }
    if (object.restBetweenSets != null) {
      result
        ..add('restBetweenSets')
        ..add(serializers.serialize(object.restBetweenSets,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Workout deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WorkoutBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sets':
          result.sets = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'holdCount':
          result.holdCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'stopwatchRestTimers':
          result.stopwatchRestTimers = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'restBetweenHolds':
          result.restBetweenHolds = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'restBetweenSets':
          result.restBetweenSets = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'board':
          result.board.replace(serializers.deserialize(value,
              specifiedType: const FullType(Board)) as Board);
          break;
        case 'holds':
          result.holds.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Hold)]))
              as BuiltList<Object>);
          break;
        case 'weightUnit':
          result.weightUnit = serializers.deserialize(value,
              specifiedType: const FullType(WeightUnit)) as WeightUnit;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'label':
          result.label = serializers.deserialize(value,
              specifiedType: const FullType(Label)) as Label;
          break;
      }
    }

    return result.build();
  }
}

class _$Workout extends Workout {
  @override
  final String id;
  @override
  final int sets;
  @override
  final int holdCount;
  @override
  final bool stopwatchRestTimers;
  @override
  final int restBetweenHolds;
  @override
  final int restBetweenSets;
  @override
  final Board board;
  @override
  final BuiltList<Hold> holds;
  @override
  final WeightUnit weightUnit;
  @override
  final String name;
  @override
  final Label label;

  factory _$Workout([void Function(WorkoutBuilder) updates]) =>
      (new WorkoutBuilder()..update(updates)).build();

  _$Workout._(
      {this.id,
      this.sets,
      this.holdCount,
      this.stopwatchRestTimers,
      this.restBetweenHolds,
      this.restBetweenSets,
      this.board,
      this.holds,
      this.weightUnit,
      this.name,
      this.label})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Workout', 'id');
    }
    if (sets == null) {
      throw new BuiltValueNullFieldError('Workout', 'sets');
    }
    if (holdCount == null) {
      throw new BuiltValueNullFieldError('Workout', 'holdCount');
    }
    if (stopwatchRestTimers == null) {
      throw new BuiltValueNullFieldError('Workout', 'stopwatchRestTimers');
    }
    if (board == null) {
      throw new BuiltValueNullFieldError('Workout', 'board');
    }
    if (holds == null) {
      throw new BuiltValueNullFieldError('Workout', 'holds');
    }
    if (weightUnit == null) {
      throw new BuiltValueNullFieldError('Workout', 'weightUnit');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Workout', 'name');
    }
    if (label == null) {
      throw new BuiltValueNullFieldError('Workout', 'label');
    }
  }

  @override
  Workout rebuild(void Function(WorkoutBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkoutBuilder toBuilder() => new WorkoutBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Workout &&
        id == other.id &&
        sets == other.sets &&
        holdCount == other.holdCount &&
        stopwatchRestTimers == other.stopwatchRestTimers &&
        restBetweenHolds == other.restBetweenHolds &&
        restBetweenSets == other.restBetweenSets &&
        board == other.board &&
        holds == other.holds &&
        weightUnit == other.weightUnit &&
        name == other.name &&
        label == other.label;
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
                                $jc(
                                    $jc($jc($jc(0, id.hashCode), sets.hashCode),
                                        holdCount.hashCode),
                                    stopwatchRestTimers.hashCode),
                                restBetweenHolds.hashCode),
                            restBetweenSets.hashCode),
                        board.hashCode),
                    holds.hashCode),
                weightUnit.hashCode),
            name.hashCode),
        label.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Workout')
          ..add('id', id)
          ..add('sets', sets)
          ..add('holdCount', holdCount)
          ..add('stopwatchRestTimers', stopwatchRestTimers)
          ..add('restBetweenHolds', restBetweenHolds)
          ..add('restBetweenSets', restBetweenSets)
          ..add('board', board)
          ..add('holds', holds)
          ..add('weightUnit', weightUnit)
          ..add('name', name)
          ..add('label', label))
        .toString();
  }
}

class WorkoutBuilder implements Builder<Workout, WorkoutBuilder> {
  _$Workout _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _sets;
  int get sets => _$this._sets;
  set sets(int sets) => _$this._sets = sets;

  int _holdCount;
  int get holdCount => _$this._holdCount;
  set holdCount(int holdCount) => _$this._holdCount = holdCount;

  bool _stopwatchRestTimers;
  bool get stopwatchRestTimers => _$this._stopwatchRestTimers;
  set stopwatchRestTimers(bool stopwatchRestTimers) =>
      _$this._stopwatchRestTimers = stopwatchRestTimers;

  int _restBetweenHolds;
  int get restBetweenHolds => _$this._restBetweenHolds;
  set restBetweenHolds(int restBetweenHolds) =>
      _$this._restBetweenHolds = restBetweenHolds;

  int _restBetweenSets;
  int get restBetweenSets => _$this._restBetweenSets;
  set restBetweenSets(int restBetweenSets) =>
      _$this._restBetweenSets = restBetweenSets;

  BoardBuilder _board;
  BoardBuilder get board => _$this._board ??= new BoardBuilder();
  set board(BoardBuilder board) => _$this._board = board;

  ListBuilder<Hold> _holds;
  ListBuilder<Hold> get holds => _$this._holds ??= new ListBuilder<Hold>();
  set holds(ListBuilder<Hold> holds) => _$this._holds = holds;

  WeightUnit _weightUnit;
  WeightUnit get weightUnit => _$this._weightUnit;
  set weightUnit(WeightUnit weightUnit) => _$this._weightUnit = weightUnit;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  Label _label;
  Label get label => _$this._label;
  set label(Label label) => _$this._label = label;

  WorkoutBuilder();

  WorkoutBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _sets = _$v.sets;
      _holdCount = _$v.holdCount;
      _stopwatchRestTimers = _$v.stopwatchRestTimers;
      _restBetweenHolds = _$v.restBetweenHolds;
      _restBetweenSets = _$v.restBetweenSets;
      _board = _$v.board?.toBuilder();
      _holds = _$v.holds?.toBuilder();
      _weightUnit = _$v.weightUnit;
      _name = _$v.name;
      _label = _$v.label;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Workout other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Workout;
  }

  @override
  void update(void Function(WorkoutBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Workout build() {
    _$Workout _$result;
    try {
      _$result = _$v ??
          new _$Workout._(
              id: id,
              sets: sets,
              holdCount: holdCount,
              stopwatchRestTimers: stopwatchRestTimers,
              restBetweenHolds: restBetweenHolds,
              restBetweenSets: restBetweenSets,
              board: board.build(),
              holds: holds.build(),
              weightUnit: weightUnit,
              name: name,
              label: label);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'board';
        board.build();
        _$failedField = 'holds';
        holds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Workout', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
