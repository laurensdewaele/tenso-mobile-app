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
      'completedDate',
      serializers.serialize(object.completedDate,
          specifiedType: const FullType(DateTime)),
      'feltDifficulty',
      serializers.serialize(object.feltDifficulty,
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
        case 'completedDate':
          result.completedDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'feltDifficulty':
          result.feltDifficulty = serializers.deserialize(value,
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
  final DateTime completedDate;
  @override
  final int feltDifficulty;

  factory _$CompletedWorkout(
          [void Function(CompletedWorkoutBuilder) updates]) =>
      (new CompletedWorkoutBuilder()..update(updates)).build();

  _$CompletedWorkout._({this.workout, this.completedDate, this.feltDifficulty})
      : super._() {
    if (workout == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'workout');
    }
    if (completedDate == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'completedDate');
    }
    if (feltDifficulty == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'feltDifficulty');
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
        completedDate == other.completedDate &&
        feltDifficulty == other.feltDifficulty;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, workout.hashCode), completedDate.hashCode),
        feltDifficulty.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompletedWorkout')
          ..add('workout', workout)
          ..add('completedDate', completedDate)
          ..add('feltDifficulty', feltDifficulty))
        .toString();
  }
}

class CompletedWorkoutBuilder
    implements Builder<CompletedWorkout, CompletedWorkoutBuilder> {
  _$CompletedWorkout _$v;

  WorkoutBuilder _workout;
  WorkoutBuilder get workout => _$this._workout ??= new WorkoutBuilder();
  set workout(WorkoutBuilder workout) => _$this._workout = workout;

  DateTime _completedDate;
  DateTime get completedDate => _$this._completedDate;
  set completedDate(DateTime completedDate) =>
      _$this._completedDate = completedDate;

  int _feltDifficulty;
  int get feltDifficulty => _$this._feltDifficulty;
  set feltDifficulty(int feltDifficulty) =>
      _$this._feltDifficulty = feltDifficulty;

  CompletedWorkoutBuilder();

  CompletedWorkoutBuilder get _$this {
    if (_$v != null) {
      _workout = _$v.workout?.toBuilder();
      _completedDate = _$v.completedDate;
      _feltDifficulty = _$v.feltDifficulty;
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
              completedDate: completedDate,
              feltDifficulty: feltDifficulty);
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
