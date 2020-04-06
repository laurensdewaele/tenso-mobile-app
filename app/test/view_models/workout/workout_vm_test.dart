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
        expect(state, _initialState);
      });
    });

    test('setGeneralVariables', () {
      final Board _newBoard =
          _initialState.board.rebuild((b) => b..width = 500);
      final List<Hold> _newHolds = []
        ..addAll(_initialState.holds)
        ..add(_initialState.holds[0]);

      double _emitted = 0;
      _workoutViewModel.state$.listen(expectAsync1((a) {
        if (_emitted == 0) {
          expect(a, _initialState);
        }
        if (_emitted == 1) {
          expect(a.holdCount, _initialState.holdCount + 1);
          expect(a.sets, 5);
          expect(a.restBetweenHolds, 400);
          expect(a.restBetweenSets, 300);
          expect(a.board, _newBoard);
          expect(a.holds.length, _initialState.holds.length + 1);
          expect(a.holds, _newHolds);
        }
        if (_emitted == 3) {
          expect(a.holdCount, 1);
          expect(a.sets, 2);
          expect(a.restBetweenHolds, 3);
          expect(a.restBetweenSets, 4);
          expect(a.board, _initialState.board);
          expect(a.holds.length, 1);
          expect(a.holds, []..add(_initialState.holds[0]));
        }
        _emitted++;
      }, count: 3));

      _workoutViewModel.setGeneralVariables(
          holdCount: _initialState.holdCount + 1,
          sets: 5,
          restBetweenHolds: 400,
          restBetweenSets: 300,
          board: _newBoard);
      _workoutViewModel.setGeneralVariables(
          holdCount: 1,
          sets: 2,
          restBetweenHolds: 3,
          restBetweenSets: 4,
          board: _initialState.board);
    });
    test('should save workout when the navigator emits the save event', () {});
  });
}
