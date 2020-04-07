import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../data/test_data.dart';
import 'package:app/data/grips.dart';
import 'package:app/models/models.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';

class MockWorkoutNavigator extends Mock implements WorkoutNavigator {}

void main() {
  group('Workout view model', () {
    WorkoutViewModel _workoutViewModel;
    WorkoutViewModelState _initialState;
    MockWorkoutNavigator _mockWorkoutNavigator;
    NavigatorPage _mockPage;
    int _mockHoldIndex;

    setUp(() {
      _mockHoldIndex = basicTestWorkout.holds.length - 1;
      _mockPage = NavigatorPage(
          page: Pages.holdPage,
          index: basicTestWorkout.holds.length + 1,
          active: true,
          holdIndex: _mockHoldIndex);
      _mockWorkoutNavigator = MockWorkoutNavigator();
      // Sets the correct _holdIndex, used for setHoldVariables
      when(_mockWorkoutNavigator.activePage$)
          .thenAnswer((_) => Stream.value(_mockPage));

      _workoutViewModel = WorkoutViewModel(
          workoutNavigator: _mockWorkoutNavigator,
          workoutType: WorkoutTypes.newWorkout,
          workout: basicTestWorkout,
          currentWeightUnit: WeightUnit.metric);

      _initialState = WorkoutViewModelState.fromWorkout(
          basicTestWorkout, WeightUnit.metric);
    });

    test('should initialize', () {
      expect(_workoutViewModel.title, 'New workout');
      _workoutViewModel.state$.listen((WorkoutViewModelState state) {
        expect(state, _initialState);
      });
    });
    test('should set general page values', () {
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
    test('should set hold page values', () {
      scheduleMicrotask(() {
        _workoutViewModel.setHoldVariables(
            leftGrip: null,
            rightGrip: Grips.backThreeL,
            leftGripBoardHold: null,
            rightGripBoardHold: basicTestWorkout.board.boardHolds[0],
            repetitions: 12,
            hangTime: 24,
            restBetweenRepetitions: 125,
            addedWeight: 41.23,
            handHold: HandHold.oneHandedRight);
        _workoutViewModel.setHoldVariables(
            leftGrip: Grips.backTwoL,
            rightGrip: Grips.backThreeL,
            leftGripBoardHold: basicTestWorkout.board.boardHolds[4],
            rightGripBoardHold: basicTestWorkout.board.boardHolds[0],
            repetitions: 1,
            hangTime: 2,
            restBetweenRepetitions: 3,
            addedWeight: 4,
            handHold: HandHold.twoHanded);
      });

      double _emitted = 0;
      _workoutViewModel.state$.listen(expectAsync1((a) {
        if (_emitted == 0) {
          expect(a, _initialState);
        }
        if (_emitted == 1) {
          expect(a.holds[_mockHoldIndex].leftGrip, null);
          expect(a.holds[_mockHoldIndex].rightGrip, Grips.backThreeL);
          expect(a.holds[_mockHoldIndex].leftGripBoardHold, null);
          expect(a.holds[_mockHoldIndex].rightGripBoardHold,
              basicTestWorkout.board.boardHolds[0]);
          expect(a.holds[_mockHoldIndex].repetitions, 12);
          expect(a.holds[_mockHoldIndex].hangTime, 24);
          expect(a.holds[_mockHoldIndex].restBetweenRepetitions, 125);
          expect(a.holds[_mockHoldIndex].addedWeight, 41.23);
        }
        if (_emitted == 2) {
          expect(a.holds[_mockHoldIndex].leftGrip, Grips.backTwoL);
          expect(a.holds[_mockHoldIndex].rightGrip, Grips.backThreeL);
          expect(a.holds[_mockHoldIndex].leftGripBoardHold,
              basicTestWorkout.board.boardHolds[4]);
          expect(a.holds[_mockHoldIndex].rightGripBoardHold,
              basicTestWorkout.board.boardHolds[0]);
          expect(a.holds[_mockHoldIndex].repetitions, 1);
          expect(a.holds[_mockHoldIndex].hangTime, 2);
          expect(a.holds[_mockHoldIndex].restBetweenRepetitions, 3);
          expect(a.holds[_mockHoldIndex].addedWeight, 4);
        }
        _emitted++;
      }, count: 3));
    });
    test('should set extra page values', () {
      scheduleMicrotask(() {
        _workoutViewModel.setExtraVariables(
            label: Label.turquoise, name: 'testing extra func');
      });

      int _emitted = 0;
      _workoutViewModel.state$
          .listen(expectAsync1((WorkoutViewModelState state) {
        if (_emitted == 0) {
          expect(state, _initialState);
        }
        if (_emitted == 1) {
          expect(state.label, Label.turquoise);
          expect(state.name, 'testing extra func');
        }
        _emitted++;
      }, count: 2));
    });
    // TODO:
    test('should save new workout when the navigator emits the save event',
        () {});
    // TODO:
    test(
        'should save edit workout when the navigator emits the save edit event',
        () {});
  });
}
