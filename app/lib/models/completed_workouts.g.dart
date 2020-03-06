// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_workouts.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CompletedWorkouts> _$completedWorkoutsSerializer =
    new _$CompletedWorkoutsSerializer();

class _$CompletedWorkoutsSerializer
    implements StructuredSerializer<CompletedWorkouts> {
  @override
  final Iterable<Type> types = const [CompletedWorkouts, _$CompletedWorkouts];
  @override
  final String wireName = 'CompletedWorkouts';

  @override
  Iterable<Object> serialize(Serializers serializers, CompletedWorkouts object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'completedWorkouts',
      serializers.serialize(object.completedWorkouts,
          specifiedType: const FullType(
              BuiltList, const [const FullType(CompletedWorkout)])),
    ];

    return result;
  }

  @override
  CompletedWorkouts deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompletedWorkoutsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'completedWorkouts':
          result.completedWorkouts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CompletedWorkout)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$CompletedWorkouts extends CompletedWorkouts {
  @override
  final BuiltList<CompletedWorkout> completedWorkouts;

  factory _$CompletedWorkouts(
          [void Function(CompletedWorkoutsBuilder) updates]) =>
      (new CompletedWorkoutsBuilder()..update(updates)).build();

  _$CompletedWorkouts._({this.completedWorkouts}) : super._() {
    if (completedWorkouts == null) {
      throw new BuiltValueNullFieldError(
          'CompletedWorkouts', 'completedWorkouts');
    }
  }

  @override
  CompletedWorkouts rebuild(void Function(CompletedWorkoutsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompletedWorkoutsBuilder toBuilder() =>
      new CompletedWorkoutsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompletedWorkouts &&
        completedWorkouts == other.completedWorkouts;
  }

  @override
  int get hashCode {
    return $jf($jc(0, completedWorkouts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompletedWorkouts')
          ..add('completedWorkouts', completedWorkouts))
        .toString();
  }
}

class CompletedWorkoutsBuilder
    implements Builder<CompletedWorkouts, CompletedWorkoutsBuilder> {
  _$CompletedWorkouts _$v;

  ListBuilder<CompletedWorkout> _completedWorkouts;
  ListBuilder<CompletedWorkout> get completedWorkouts =>
      _$this._completedWorkouts ??= new ListBuilder<CompletedWorkout>();
  set completedWorkouts(ListBuilder<CompletedWorkout> completedWorkouts) =>
      _$this._completedWorkouts = completedWorkouts;

  CompletedWorkoutsBuilder();

  CompletedWorkoutsBuilder get _$this {
    if (_$v != null) {
      _completedWorkouts = _$v.completedWorkouts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompletedWorkouts other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CompletedWorkouts;
  }

  @override
  void update(void Function(CompletedWorkoutsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CompletedWorkouts build() {
    _$CompletedWorkouts _$result;
    try {
      _$result = _$v ??
          new _$CompletedWorkouts._(
              completedWorkouts: completedWorkouts.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'completedWorkouts';
        completedWorkouts.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompletedWorkouts', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
