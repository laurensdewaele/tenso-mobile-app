import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../data/test_data.dart';
import 'package:app/models/models.dart';
import 'package:app/services/keyboard.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/view_models/workout/workout_general_vm.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';

class MockWorkoutViewModel extends Mock implements WorkoutViewModel {}

void main() {
  group('Workout general page', () {
    WorkoutGeneralViewModel _workoutGeneralViewModel;
    MockWorkoutViewModel _mockWorkoutViewModel;
    WorkoutNavigator _workoutNavigator;
    KeyboardService _keyboardService;

    setUp(() {
      _keyboardService = KeyboardService();
      _mockWorkoutViewModel = MockWorkoutViewModel();
      when(_mockWorkoutViewModel.holdCount$).thenAnswer((_) => Stream.value(3));
      when(_mockWorkoutViewModel.state$).thenAnswer((_) => Stream.value(
          WorkoutViewModelState(
              name: basicTestWorkout.name,
              label: basicTestWorkout.label,
              holds: basicTestWorkout.holds.toList(),
              board: basicTestWorkout.board,
              restBetweenHolds: basicTestWorkout.restBetweenHolds,
              restBetweenSets: basicTestWorkout.restBetweenSets,
              sets: basicTestWorkout.sets,
              holdCount: basicTestWorkout.holdCount,
              weightUnit: basicTestWorkout.weightUnit)));
      _workoutNavigator =
          WorkoutNavigator(workoutViewModel: _mockWorkoutViewModel);
      _workoutGeneralViewModel = WorkoutGeneralViewModel(
          workoutViewModel: _mockWorkoutViewModel,
          workoutNavigator: _workoutNavigator,
          keyboardService: _keyboardService);
    });

    test('initialize', () {
      expect(_workoutGeneralViewModel.holdCount, basicTestWorkout.holdCount);
      expect(_workoutGeneralViewModel.sets, basicTestWorkout.sets);
      expect(_workoutGeneralViewModel.restBetweenHolds,
          basicTestWorkout.restBetweenHolds);
      expect(_workoutGeneralViewModel.restBetweenSets,
          basicTestWorkout.restBetweenSets);
      expect(_workoutGeneralViewModel.board, basicTestWorkout.board);
    });
    test('should validate when input field loses focus', () {
      _workoutGeneralViewModel.setHoldCount('10');
      _keyboardService.handleScreenTap();
      scheduleMicrotask(() {
        expect(_workoutGeneralViewModel.holdCount, 10);
      });
    });
    test('should validate when input field completes', () {
      _workoutGeneralViewModel.setRestBetweenSets('122');
      _keyboardService.handleInputComplete();
      scheduleMicrotask(() {
        expect(_workoutGeneralViewModel.restBetweenSets, 122);
      });
    });
    test('should set board', () {
      _workoutGeneralViewModel
          .setBoard(basicTestWorkout.board.rebuild((b) => b..width = 1234));
      expect(_workoutGeneralViewModel.board.width, 1234);
    });

    // validation only happens when the input loses focus
    // or when the navigator tells it's time to.
    group('input validation', () {
      group('valid input', () {
        test('should set holdCount', () {
          _workoutGeneralViewModel.setHoldCount('11');
          _workoutNavigator.handleForwardRequest();
          scheduleMicrotask(() {
            expect(_workoutGeneralViewModel.holdCount, 11);
          });
        });
        test('should set sets', () {
          _workoutGeneralViewModel.setSets('44');
          _workoutNavigator.handleForwardRequest();
          scheduleMicrotask(() {
            expect(_workoutGeneralViewModel.sets, 44);
          });
        });
        test('should set restBetweenHolds', () {
          _workoutGeneralViewModel.setRestBetweenHolds('53');
          _workoutNavigator.handleForwardRequest();
          scheduleMicrotask(() {
            expect(_workoutGeneralViewModel.restBetweenHolds, 53);
          });
        });
        test('should set restBetweenSets', () {
          _workoutGeneralViewModel.setRestBetweenSets('12');
          _workoutNavigator.handleForwardRequest();
          scheduleMicrotask(() {
            expect(_workoutGeneralViewModel.restBetweenSets, 12);
          });
        });
      });

      group('invalid input', () {
        test('should throw on invalid holdCount', () {
          try {
            _workoutGeneralViewModel.setHoldCount('/sdf');
          } catch (exception) {
            expect(exception.runtimeType, ParseException);
          }

          try {
            _workoutGeneralViewModel.setHoldCount('-5');
          } catch (exception) {
            expect(exception.runtimeType, ValidationException);
          }
        });
        test('should throw on invalid sets', () {
          try {
            _workoutGeneralViewModel.setSets('/sdf');
          } catch (exception) {
            expect(exception.runtimeType, ParseException);
          }

          try {
            _workoutGeneralViewModel.setSets('-0');
          } catch (exception) {
            expect(exception.runtimeType, ValidationException);
          }
        });
        test('should throw on invalid restBetweenHolds', () {
          try {
            _workoutGeneralViewModel.setRestBetweenHolds('/sdf');
          } catch (exception) {
            expect(exception.runtimeType, ParseException);
          }

          try {
            _workoutGeneralViewModel.setRestBetweenHolds('0');
          } catch (exception) {
            expect(exception.runtimeType, ValidationException);
          }
        });
        test('should throw on invalid restBetweenSets', () {
          try {
            _workoutGeneralViewModel.setRestBetweenSets('/sdf');
          } catch (exception) {
            expect(exception.runtimeType, ParseException);
          }

          try {
            _workoutGeneralViewModel.setRestBetweenSets('-100.32');
          } catch (exception) {
            expect(exception.runtimeType, ValidationException);
          }
        });
      });
    });

    group('on navigation', () {
      NavigatorPage _initialPage;
      Board _newBoard;

      setUp(() {
        _initialPage = NavigatorPage(
            page: Pages.generalPage, holdIndex: null, active: true, index: 0);
        _newBoard = basicTestWorkout.board.rebuild((b) => b..width = 400);
        _workoutGeneralViewModel.setHoldCount('10');
        _workoutGeneralViewModel.setSets('4');
        _workoutGeneralViewModel.setRestBetweenHolds('100');
        _workoutGeneralViewModel.setRestBetweenSets('110');
        _workoutGeneralViewModel.setBoard(_newBoard);

        _workoutNavigator.handleForwardRequest();
      });

      test('if validation is successful => report back to navigator', () {
        int _emitted = 0;
        _workoutNavigator.activePage$.listen(expectAsync1((NavigatorPage page) {
          if (_emitted == 0) {
            page = _initialPage;
          }
          if (_emitted == 1) {
            page = NavigatorPage(
                page: Pages.holdPage, holdIndex: 0, active: true, index: 1);
          }
          _emitted++;
        }, count: 2));
      });
      test('if validation is successful => save variables on workout_vm', () {
        scheduleMicrotask(() {
          verify(_mockWorkoutViewModel.setGeneralVariables(
              holdCount: argThat(equals(10), named: 'holdCount'),
              sets: argThat(equals(4), named: 'sets'),
              restBetweenHolds: argThat(equals(100), named: 'restBetweenHolds'),
              restBetweenSets: argThat(equals(110), named: 'restBetweenSets'),
              board: argThat(equals(_newBoard), named: 'board')));
        });
      });
    });
  });
}
