import 'dart:async';

import 'package:test/test.dart';

import '../../data/test_data.dart';

import 'package:app/models/models.dart';
import 'package:app/view_models/workout/workout_vm.dart';

void main() {
  group('Workout view model', () {
    WorkoutViewModel _workoutViewModel;

    setUp(() {
      _workoutViewModel = WorkoutViewModel(
          workoutType: WorkoutTypes.newWorkout,
          workout: basicTestWorkout,
          currentWeightUnit: WeightUnit.metric);
    });

    test('init', () {
      expect(_workoutViewModel.title, 'New workout');
      _workoutViewModel.state$.listen((WorkoutViewModelState state) {
        expect(state.holdCount, 3);
        expect(state.holds.length, 3);
      });
      _workoutViewModel.holdCount$.listen((int holdCount) {
        expect(holdCount, 3);
      });
    });

    group('holdCount and hold creation', () {
      test('add holdCount', () {
        scheduleMicrotask(() {
          _workoutViewModel.setHoldCount(4);
        });
        expect(_workoutViewModel.holdCount$, emitsInOrder([3, 4]));
      });
      test('amount of holds', () {
//        final WorkoutViewModelState _state = WorkoutViewModelState.fromWorkout(
//            basicTestWorkout, WeightUnit.metric);
//
//        scheduleMicrotask(() {
//          _workoutViewModel.setHoldCount(3);
//        });
//
//        _workoutViewModel.state$.listen((WorkoutViewModelState state) {
//          final state1 = state.copyWith(board: null);
//          final _state1 = _state.copyWith(board: null);
//          print(state1 == _state1);
//        });
//
//        expect(
//            _workoutViewModel.state$,
//            emitsInOrder([
//              emits(_state),
//              emits(_state),
//            ]));
      });
      test('holdCount stream should only emit when value is different', () {});
    });
  });
}
