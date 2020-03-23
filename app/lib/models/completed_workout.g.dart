// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_workout.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CompletedWorkout> _$completedWorkoutSerializer =
    new _$CompletedWorkoutSerializer();

class _$CompletedWorkoutSerializer
    implements StructuredSerializer<CompletedWorkout> {
  @override
  final Iterable<Type> types = const [CompletedWorkout, _$CompletedWorkout];
  @override
  final String wireName = 'CompletedWorkout';

  @override
  Iterable<Object> serialize(Serializers serializers, CompletedWorkout object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'workout',
      serializers.serialize(object.workout,
          specifiedType: const FullType(Workout)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'completedDate',
      serializers.serialize(object.completedDate,
          specifiedType: const FullType(DateTime)),
      'effortLevel',
      serializers.serialize(object.effortLevel,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  CompletedWorkout deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompletedWorkoutBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'workout':
          result.workout.replace(serializers.deserialize(value,
              specifiedType: const FullType(Workout)) as Workout);
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'completedDate':
          result.completedDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'effortLevel':
          result.effortLevel = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$CompletedWorkout extends CompletedWorkout {
  @override
  final Workout workout;
  @override
  final String id;
  @override
  final DateTime completedDate;
  @override
  final int effortLevel;

  factory _$CompletedWorkout(
          [void Function(CompletedWorkoutBuilder) updates]) =>
      (new CompletedWorkoutBuilder()..update(updates)).build();

  _$CompletedWorkout._(
      {this.workout, this.id, this.completedDate, this.effortLevel})
      : super._() {
    if (workout == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'workout');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'id');
    }
    if (completedDate == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'completedDate');
    }
    if (effortLevel == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'effortLevel');
    }
  }

  @override
  CompletedWorkout rebuild(void Function(CompletedWorkoutBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompletedWorkoutBuilder toBuilder() =>
      new CompletedWorkoutBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompletedWorkout &&
        workout == other.workout &&
        id == other.id &&
        completedDate == other.completedDate &&
        effortLevel == other.effortLevel;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, workout.hashCode), id.hashCode), completedDate.hashCode),
        effortLevel.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompletedWorkout')
          ..add('workout', workout)
          ..add('id', id)
          ..add('completedDate', completedDate)
          ..add('effortLevel', effortLevel))
        .toString();
  }
}

class CompletedWorkoutBuilder
    implements Builder<CompletedWorkout, CompletedWorkoutBuilder> {
  _$CompletedWorkout _$v;

  WorkoutBuilder _workout;
  WorkoutBuilder get workout => _$this._workout ??= new WorkoutBuilder();
  set workout(WorkoutBuilder workout) => _$this._workout = workout;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  DateTime _completedDate;
  DateTime get completedDate => _$this._completedDate;
  set completedDate(DateTime completedDate) =>
      _$this._completedDate = completedDate;

  int _effortLevel;
  int get effortLevel => _$this._effortLevel;
  set effortLevel(int effortLevel) => _$this._effortLevel = effortLevel;

  CompletedWorkoutBuilder();

  CompletedWorkoutBuilder get _$this {
    if (_$v != null) {
      _workout = _$v.workout?.toBuilder();
      _id = _$v.id;
      _completedDate = _$v.completedDate;
      _effortLevel = _$v.effortLevel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompletedWorkout other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CompletedWorkout;
  }

  @override
  void update(void Function(CompletedWorkoutBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CompletedWorkout build() {
    _$CompletedWorkout _$result;
    try {
      _$result = _$v ??
          new _$CompletedWorkout._(
              workout: workout.build(),
              id: id,
              completedDate: completedDate,
              effortLevel: effortLevel);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'workout';
        workout.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompletedWorkout', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
