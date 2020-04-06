import 'dart:async';

import 'package:test/test.dart';

import '../../data/test_data.dart';

import 'package:app/models/models.dart';
import 'package:app/view_models/workout/workout_vm.dart';

void main() {
  group('Workout view model', () {
    WorkoutViewModel _workoutViewModel;
    WorkoutViewModelState _initialState;

    setUp(() {
      _workoutViewModel = WorkoutViewModel(
          workoutType: WorkoutTypes.newWorkout,
          workout: basicTestWorkout,
          currentWeightUnit: WeightUnit.metric);

      _initialState = WorkoutViewModelState.fromWorkout(
          basicTestWorkout, WeightUnit.metric);
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

    group('setHoldCount', () {
      test('add holdCount', () {
        scheduleMicrotask(() {
          _workoutViewModel.setHoldCount(4);
        });
        expect(_workoutViewModel.holdCount$, emitsInOrder([3, 4]));
      });
      test('amount of holds', () {
        double _emitted = 0;
        _workoutViewModel.state$.listen(expectAsync1((a) {
          if (_emitted == 0) {
            expect(a.holds.length, 3);
          }
          if (_emitted == 1) {
            expect(a.holds.length, 4);
          }
          if (_emitted == 3) {
            expect(a.holds.length, 1);
          }
          _emitted++;
        }, count: 3));

        _workoutViewModel.setHoldCount(4);
        _workoutViewModel.setHoldCount(1);
      });
      test('holdCount stream should only emit when value is different', () {});
    });

    test('setSets', () {
      double _emitted = 0;
      _workoutViewModel.state$.listen(expectAsync1((a) {
        if (_emitted == 0) {
          expect(a, _initialState);
        }
        if (_emitted == 1) {
          expect(a.sets, 5);
        }
        _emitted++;
      }, count: 2));
      _workoutViewModel.setSets(5);
    });
    test('setRestBetweenSets', () {
      double _emitted = 0;
      _workoutViewModel.state$.listen(expectAsync1((a) {
        if (_emitted == 0) {
          expect(a, _initialState);
        }
        if (_emitted == 1) {
          expect(a.restBetweenSets, 333);
        }
        _emitted++;
      }, count: 2));
      _workoutViewModel.setRestBetweenSets(333);
    });
    test('setRestBetweenHolds', () {
      double _emitted = 0;
      _workoutViewModel.state$.listen(expectAsync1((a) {
        if (_emitted == 0) {
          expect(a, _initialState);
        }
        if (_emitted == 1) {
          expect(a.restBetweenHolds, 444);
        }
        _emitted++;
      }, count: 2));
      _workoutViewModel.setRestBetweenHolds(444);
    });
    test('setBoard', () {
      final _newBoard = _initialState.board.rebuild((b) => b..width = 400);

      double _emitted = 0;
      _workoutViewModel.state$.listen(expectAsync1((a) {
        if (_emitted == 0) {
          expect(a, _initialState);
        }
        if (_emitted == 1) {
          expect(a.board.width, 400);
        }
        _emitted++;
      }, count: 2));
      _workoutViewModel.setBoard(_newBoard);
    });
    test('setHolds', () {
      final Hold _hold = _initialState.holds[0];
      final List<Hold> _newHolds = []
        ..addAll(_initialState.holds)
        ..add(_hold);

      double _emitted = 0;
      _workoutViewModel.state$.listen(expectAsync1((a) {
        if (_emitted == 0) {
          expect(a, _initialState);
        }
        if (_emitted == 1) {
          expect(a.holds.length, _initialState.holds.length + 1);
        }
        _emitted++;
      }, count: 2));
      _workoutViewModel.setHolds(_newHolds);
    });
    test('setLabel', () {
      double _emitted = 0;
      _workoutViewModel.state$.listen(expectAsync1((a) {
        if (_emitted == 0) {
          expect(a, _initialState);
        }
        if (_emitted == 1) {
          expect(a.label, Label.yellow);
        }
        _emitted++;
      }, count: 2));
      _workoutViewModel.setLabel(Label.yellow);
    });
  });
}
