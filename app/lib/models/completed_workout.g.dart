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
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'history',
      serializers.serialize(object.history,
          specifiedType: const FullType(History)),
      'workout',
      serializers.serialize(object.workout,
          specifiedType: const FullType(Workout)),
      'completedDate',
      serializers.serialize(object.completedDate,
          specifiedType: const FullType(DateTime)),
      'perceivedExertion',
      serializers.serialize(object.perceivedExertion,
          specifiedType: const FullType(int)),
      'tempUnit',
      serializers.serialize(object.tempUnit,
          specifiedType: const FullType(TempUnit)),
    ];
    if (object.bodyWeight != null) {
      result
        ..add('bodyWeight')
        ..add(serializers.serialize(object.bodyWeight,
            specifiedType: const FullType(double)));
    }
    if (object.temperature != null) {
      result
        ..add('temperature')
        ..add(serializers.serialize(object.temperature,
            specifiedType: const FullType(double)));
    }
    if (object.humidity != null) {
      result
        ..add('humidity')
        ..add(serializers.serialize(object.humidity,
            specifiedType: const FullType(double)));
    }
    if (object.comments != null) {
      result
        ..add('comments')
        ..add(serializers.serialize(object.comments,
            specifiedType: const FullType(String)));
    }
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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'history':
          result.history.replace(serializers.deserialize(value,
              specifiedType: const FullType(History)) as History);
          break;
        case 'workout':
          result.workout.replace(serializers.deserialize(value,
              specifiedType: const FullType(Workout)) as Workout);
          break;
        case 'completedDate':
          result.completedDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'perceivedExertion':
          result.perceivedExertion = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'bodyWeight':
          result.bodyWeight = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'temperature':
          result.temperature = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tempUnit':
          result.tempUnit = serializers.deserialize(value,
              specifiedType: const FullType(TempUnit)) as TempUnit;
          break;
        case 'humidity':
          result.humidity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'comments':
          result.comments = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CompletedWorkout extends CompletedWorkout {
  @override
  final String id;
  @override
  final History history;
  @override
  final Workout workout;
  @override
  final DateTime completedDate;
  @override
  final int perceivedExertion;
  @override
  final double bodyWeight;
  @override
  final double temperature;
  @override
  final TempUnit tempUnit;
  @override
  final double humidity;
  @override
  final String comments;

  factory _$CompletedWorkout(
          [void Function(CompletedWorkoutBuilder) updates]) =>
      (new CompletedWorkoutBuilder()..update(updates)).build();

  _$CompletedWorkout._(
      {this.id,
      this.history,
      this.workout,
      this.completedDate,
      this.perceivedExertion,
      this.bodyWeight,
      this.temperature,
      this.tempUnit,
      this.humidity,
      this.comments})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'id');
    }
    if (history == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'history');
    }
    if (workout == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'workout');
    }
    if (completedDate == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'completedDate');
    }
    if (perceivedExertion == null) {
      throw new BuiltValueNullFieldError(
          'CompletedWorkout', 'perceivedExertion');
    }
    if (tempUnit == null) {
      throw new BuiltValueNullFieldError('CompletedWorkout', 'tempUnit');
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
        id == other.id &&
        history == other.history &&
        workout == other.workout &&
        completedDate == other.completedDate &&
        perceivedExertion == other.perceivedExertion &&
        bodyWeight == other.bodyWeight &&
        temperature == other.temperature &&
        tempUnit == other.tempUnit &&
        humidity == other.humidity &&
        comments == other.comments;
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
                                $jc($jc($jc(0, id.hashCode), history.hashCode),
                                    workout.hashCode),
                                completedDate.hashCode),
                            perceivedExertion.hashCode),
                        bodyWeight.hashCode),
                    temperature.hashCode),
                tempUnit.hashCode),
            humidity.hashCode),
        comments.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompletedWorkout')
          ..add('id', id)
          ..add('history', history)
          ..add('workout', workout)
          ..add('completedDate', completedDate)
          ..add('perceivedExertion', perceivedExertion)
          ..add('bodyWeight', bodyWeight)
          ..add('temperature', temperature)
          ..add('tempUnit', tempUnit)
          ..add('humidity', humidity)
          ..add('comments', comments))
        .toString();
  }
}

class CompletedWorkoutBuilder
    implements Builder<CompletedWorkout, CompletedWorkoutBuilder> {
  _$CompletedWorkout _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  HistoryBuilder _history;
  HistoryBuilder get history => _$this._history ??= new HistoryBuilder();
  set history(HistoryBuilder history) => _$this._history = history;

  WorkoutBuilder _workout;
  WorkoutBuilder get workout => _$this._workout ??= new WorkoutBuilder();
  set workout(WorkoutBuilder workout) => _$this._workout = workout;

  DateTime _completedDate;
  DateTime get completedDate => _$this._completedDate;
  set completedDate(DateTime completedDate) =>
      _$this._completedDate = completedDate;

  int _perceivedExertion;
  int get perceivedExertion => _$this._perceivedExertion;
  set perceivedExertion(int perceivedExertion) =>
      _$this._perceivedExertion = perceivedExertion;

  double _bodyWeight;
  double get bodyWeight => _$this._bodyWeight;
  set bodyWeight(double bodyWeight) => _$this._bodyWeight = bodyWeight;

  double _temperature;
  double get temperature => _$this._temperature;
  set temperature(double temperature) => _$this._temperature = temperature;

  TempUnit _tempUnit;
  TempUnit get tempUnit => _$this._tempUnit;
  set tempUnit(TempUnit tempUnit) => _$this._tempUnit = tempUnit;

  double _humidity;
  double get humidity => _$this._humidity;
  set humidity(double humidity) => _$this._humidity = humidity;

  String _comments;
  String get comments => _$this._comments;
  set comments(String comments) => _$this._comments = comments;

  CompletedWorkoutBuilder();

  CompletedWorkoutBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _history = _$v.history?.toBuilder();
      _workout = _$v.workout?.toBuilder();
      _completedDate = _$v.completedDate;
      _perceivedExertion = _$v.perceivedExertion;
      _bodyWeight = _$v.bodyWeight;
      _temperature = _$v.temperature;
      _tempUnit = _$v.tempUnit;
      _humidity = _$v.humidity;
      _comments = _$v.comments;
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
              id: id,
              history: history.build(),
              workout: workout.build(),
              completedDate: completedDate,
              perceivedExertion: perceivedExertion,
              bodyWeight: bodyWeight,
              temperature: temperature,
              tempUnit: tempUnit,
              humidity: humidity,
              comments: comments);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'history';
        history.build();
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
