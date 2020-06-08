// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.model.dart';

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
      'groups',
      serializers.serialize(object.groups,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Group)])),
      'weightSystem',
      serializers.serialize(object.weightSystem,
          specifiedType: const FullType(WeightSystem)),
      'restBetweenGroupsFixed',
      serializers.serialize(object.restBetweenGroupsFixed,
          specifiedType: const FullType(bool)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'label',
      serializers.serialize(object.label, specifiedType: const FullType(Label)),
    ];
    if (object.sets != null) {
      result
        ..add('sets')
        ..add(serializers.serialize(object.sets,
            specifiedType: const FullType(int)));
    }
    if (object.holdCount != null) {
      result
        ..add('holdCount')
        ..add(serializers.serialize(object.holdCount,
            specifiedType: const FullType(int)));
    }
    if (object.countdownRestTimer != null) {
      result
        ..add('countdownRestTimer')
        ..add(serializers.serialize(object.countdownRestTimer,
            specifiedType: const FullType(bool)));
    }
    if (object.board != null) {
      result
        ..add('board')
        ..add(serializers.serialize(object.board,
            specifiedType: const FullType(Board)));
    }
    if (object.holds != null) {
      result
        ..add('holds')
        ..add(serializers.serialize(object.holds,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Hold)])));
    }
    if (object.restBetweenGroupsS != null) {
      result
        ..add('restBetweenGroupsS')
        ..add(serializers.serialize(object.restBetweenGroupsS,
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
        case 'countdownRestTimer':
          result.countdownRestTimer = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
        case 'groups':
          result.groups.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Group)]))
              as BuiltList<Object>);
          break;
        case 'weightSystem':
          result.weightSystem = serializers.deserialize(value,
              specifiedType: const FullType(WeightSystem)) as WeightSystem;
          break;
        case 'restBetweenGroupsS':
          result.restBetweenGroupsS = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'restBetweenGroupsFixed':
          result.restBetweenGroupsFixed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
  final bool countdownRestTimer;
  @override
  final Board board;
  @override
  final BuiltList<Hold> holds;
  @override
  final BuiltList<Group> groups;
  @override
  final WeightSystem weightSystem;
  @override
  final int restBetweenGroupsS;
  @override
  final bool restBetweenGroupsFixed;
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
      this.countdownRestTimer,
      this.board,
      this.holds,
      this.groups,
      this.weightSystem,
      this.restBetweenGroupsS,
      this.restBetweenGroupsFixed,
      this.name,
      this.label})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Workout', 'id');
    }
    if (groups == null) {
      throw new BuiltValueNullFieldError('Workout', 'groups');
    }
    if (weightSystem == null) {
      throw new BuiltValueNullFieldError('Workout', 'weightSystem');
    }
    if (restBetweenGroupsFixed == null) {
      throw new BuiltValueNullFieldError('Workout', 'restBetweenGroupsFixed');
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
        countdownRestTimer == other.countdownRestTimer &&
        board == other.board &&
        holds == other.holds &&
        groups == other.groups &&
        weightSystem == other.weightSystem &&
        restBetweenGroupsS == other.restBetweenGroupsS &&
        restBetweenGroupsFixed == other.restBetweenGroupsFixed &&
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
                                    $jc(
                                        $jc(
                                            $jc($jc(0, id.hashCode),
                                                sets.hashCode),
                                            holdCount.hashCode),
                                        countdownRestTimer.hashCode),
                                    board.hashCode),
                                holds.hashCode),
                            groups.hashCode),
                        weightSystem.hashCode),
                    restBetweenGroupsS.hashCode),
                restBetweenGroupsFixed.hashCode),
            name.hashCode),
        label.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Workout')
          ..add('id', id)
          ..add('sets', sets)
          ..add('holdCount', holdCount)
          ..add('countdownRestTimer', countdownRestTimer)
          ..add('board', board)
          ..add('holds', holds)
          ..add('groups', groups)
          ..add('weightSystem', weightSystem)
          ..add('restBetweenGroupsS', restBetweenGroupsS)
          ..add('restBetweenGroupsFixed', restBetweenGroupsFixed)
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

  bool _countdownRestTimer;
  bool get countdownRestTimer => _$this._countdownRestTimer;
  set countdownRestTimer(bool countdownRestTimer) =>
      _$this._countdownRestTimer = countdownRestTimer;

  BoardBuilder _board;
  BoardBuilder get board => _$this._board ??= new BoardBuilder();
  set board(BoardBuilder board) => _$this._board = board;

  ListBuilder<Hold> _holds;
  ListBuilder<Hold> get holds => _$this._holds ??= new ListBuilder<Hold>();
  set holds(ListBuilder<Hold> holds) => _$this._holds = holds;

  ListBuilder<Group> _groups;
  ListBuilder<Group> get groups => _$this._groups ??= new ListBuilder<Group>();
  set groups(ListBuilder<Group> groups) => _$this._groups = groups;

  WeightSystem _weightSystem;
  WeightSystem get weightSystem => _$this._weightSystem;
  set weightSystem(WeightSystem weightSystem) =>
      _$this._weightSystem = weightSystem;

  int _restBetweenGroupsS;
  int get restBetweenGroupsS => _$this._restBetweenGroupsS;
  set restBetweenGroupsS(int restBetweenGroupsS) =>
      _$this._restBetweenGroupsS = restBetweenGroupsS;

  bool _restBetweenGroupsFixed;
  bool get restBetweenGroupsFixed => _$this._restBetweenGroupsFixed;
  set restBetweenGroupsFixed(bool restBetweenGroupsFixed) =>
      _$this._restBetweenGroupsFixed = restBetweenGroupsFixed;

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
      _countdownRestTimer = _$v.countdownRestTimer;
      _board = _$v.board?.toBuilder();
      _holds = _$v.holds?.toBuilder();
      _groups = _$v.groups?.toBuilder();
      _weightSystem = _$v.weightSystem;
      _restBetweenGroupsS = _$v.restBetweenGroupsS;
      _restBetweenGroupsFixed = _$v.restBetweenGroupsFixed;
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
              countdownRestTimer: countdownRestTimer,
              board: _board?.build(),
              holds: _holds?.build(),
              groups: groups.build(),
              weightSystem: weightSystem,
              restBetweenGroupsS: restBetweenGroupsS,
              restBetweenGroupsFixed: restBetweenGroupsFixed,
              name: name,
              label: label);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'board';
        _board?.build();
        _$failedField = 'holds';
        _holds?.build();
        _$failedField = 'groups';
        groups.build();
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
