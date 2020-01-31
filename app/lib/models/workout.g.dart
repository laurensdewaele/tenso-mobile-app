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
      'difficulty',
      serializers.serialize(object.difficulty,
          specifiedType: const FullType(String)),
      'sets',
      serializers.serialize(object.sets, specifiedType: const FullType(int)),
      'holdCount',
      serializers.serialize(object.holdCount,
          specifiedType: const FullType(int)),
      'restBetweenHolds',
      serializers.serialize(object.restBetweenHolds,
          specifiedType: const FullType(int)),
      'restBetweenSets',
      serializers.serialize(object.restBetweenSets,
          specifiedType: const FullType(int)),
      'board',
      serializers.serialize(object.board, specifiedType: const FullType(Board)),
      'holds',
      serializers.serialize(object.holds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Hold)])),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

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
        case 'difficulty':
          result.difficulty = serializers.deserialize(value,
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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Workout extends Workout {
  @override
  final String difficulty;
  @override
  final int sets;
  @override
  final int holdCount;
  @override
  final int restBetweenHolds;
  @override
  final int restBetweenSets;
  @override
  final Board board;
  @override
  final BuiltList<Hold> holds;
  @override
  final String name;

  factory _$Workout([void Function(WorkoutBuilder) updates]) =>
      (new WorkoutBuilder()..update(updates)).build();

  _$Workout._(
      {this.difficulty,
      this.sets,
      this.holdCount,
      this.restBetweenHolds,
      this.restBetweenSets,
      this.board,
      this.holds,
      this.name})
      : super._() {
    if (difficulty == null) {
      throw new BuiltValueNullFieldError('Workout', 'difficulty');
    }
    if (sets == null) {
      throw new BuiltValueNullFieldError('Workout', 'sets');
    }
    if (holdCount == null) {
      throw new BuiltValueNullFieldError('Workout', 'holdCount');
    }
    if (restBetweenHolds == null) {
      throw new BuiltValueNullFieldError('Workout', 'restBetweenHolds');
    }
    if (restBetweenSets == null) {
      throw new BuiltValueNullFieldError('Workout', 'restBetweenSets');
    }
    if (board == null) {
      throw new BuiltValueNullFieldError('Workout', 'board');
    }
    if (holds == null) {
      throw new BuiltValueNullFieldError('Workout', 'holds');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Workout', 'name');
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
        difficulty == other.difficulty &&
        sets == other.sets &&
        holdCount == other.holdCount &&
        restBetweenHolds == other.restBetweenHolds &&
        restBetweenSets == other.restBetweenSets &&
        board == other.board &&
        holds == other.holds &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, difficulty.hashCode), sets.hashCode),
                            holdCount.hashCode),
                        restBetweenHolds.hashCode),
                    restBetweenSets.hashCode),
                board.hashCode),
            holds.hashCode),
        name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Workout')
          ..add('difficulty', difficulty)
          ..add('sets', sets)
          ..add('holdCount', holdCount)
          ..add('restBetweenHolds', restBetweenHolds)
          ..add('restBetweenSets', restBetweenSets)
          ..add('board', board)
          ..add('holds', holds)
          ..add('name', name))
        .toString();
  }
}

class WorkoutBuilder implements Builder<Workout, WorkoutBuilder> {
  _$Workout _$v;

  String _difficulty;
  String get difficulty => _$this._difficulty;
  set difficulty(String difficulty) => _$this._difficulty = difficulty;

  int _sets;
  int get sets => _$this._sets;
  set sets(int sets) => _$this._sets = sets;

  int _holdCount;
  int get holdCount => _$this._holdCount;
  set holdCount(int holdCount) => _$this._holdCount = holdCount;

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

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  WorkoutBuilder();

  WorkoutBuilder get _$this {
    if (_$v != null) {
      _difficulty = _$v.difficulty;
      _sets = _$v.sets;
      _holdCount = _$v.holdCount;
      _restBetweenHolds = _$v.restBetweenHolds;
      _restBetweenSets = _$v.restBetweenSets;
      _board = _$v.board?.toBuilder();
      _holds = _$v.holds?.toBuilder();
      _name = _$v.name;
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
              difficulty: difficulty,
              sets: sets,
              holdCount: holdCount,
              restBetweenHolds: restBetweenHolds,
              restBetweenSets: restBetweenSets,
              board: board.build(),
              holds: holds.build(),
              name: name);
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