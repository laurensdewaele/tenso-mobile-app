import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../data/test_data.dart';
import 'package:app/models/models.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';

class MockWorkoutNavigator extends Mock implements WorkoutNavigator {}

main() {
  group('Workout navigator', () {
    WorkoutNavigator _workoutNavigator;
    WorkoutViewModel _workoutViewModel;
    MockWorkoutNavigator _mockWorkoutNavigator;
    NavigatorPage _initialPage = NavigatorPage(
        page: Pages.generalPage, holdIndex: null, active: true, index: 0);

    setUp(() {
      _mockWorkoutNavigator = MockWorkoutNavigator();
      when(_mockWorkoutNavigator.activePage$)
          .thenAnswer((_) => Stream.value(_initialPage));

      _workoutViewModel = WorkoutViewModel(
          workoutType: WorkoutTypes.newWorkout,
          currentWeightUnit: WeightUnit.metric,
          workout: basicTestWorkout,
          workoutNavigator: _mockWorkoutNavigator);
      _workoutNavigator = WorkoutNavigator(workoutViewModel: _workoutViewModel);
    });

    test('should initialize', () {
      expect(_workoutNavigator.runtimeType, WorkoutNavigator);
    });
    test('should display the correct page', () {
      _workoutNavigator.activePage$.listen(expectAsync1((NavigatorPage page) {
        expect(page, _initialPage);
      }, count: 1));
    });
    test('should build it\'s pages based on the holdCount of workout_vm', () {
      scheduleMicrotask(() {
        _workoutViewModel.setGeneralVariables(
            holdCount: 7,
            sets: 3,
            restBetweenHolds: 180,
            restBetweenSets: 180,
            board: basicTestWorkout.board);
        _workoutViewModel.setGeneralVariables(
            holdCount: 1,
            sets: 3,
            restBetweenHolds: 180,
            restBetweenSets: 180,
            board: basicTestWorkout.board);
      });

      int _emitted = 0;
      _workoutNavigator.pages$.listen(expectAsync1((List<NavigatorPage> pages) {
        if (_emitted == 0) {
          expect(pages.length, basicTestWorkout.holdCount + 2);
        }
        if (_emitted == 1) {
          expect(pages.length, 7 + 2);
        }
        if (_emitted == 2) {
          expect(pages.length, 1 + 2);
        }
        _emitted++;
      }, count: 3));
    });

    group('on navigation', () {
      test('should mark the workout page to validate', () {
        scheduleMicrotask(() {
          _workoutNavigator.handleForwardRequest();
        });

        _workoutNavigator.shouldValidate$
            .listen(expectAsync1((ValidationState state) {
          expect((state is ValidationPending), true);
        }, count: 1));
      });
      test('should navigate when validation is successful', () {
        scheduleMicrotask(() {
          _workoutNavigator.handleForwardRequest();
          _workoutNavigator.handleValidationSuccess();
        });

        int _emitted = 0;
        _workoutNavigator.activePage$.listen(expectAsync1((NavigatorPage page) {
          if (_emitted == 0) {
            expect(page, _initialPage);
          }
          if (_emitted == 1) {
            expect(
                page,
                NavigatorPage(
                    active: true,
                    index: 1,
                    holdIndex: 0,
                    page: Pages.holdPage));
          }
          _emitted++;
        }, count: 2));
      });
      test('should not navigate when validation is unsuccessful', () {
        scheduleMicrotask(() {
          _workoutNavigator.handleForwardRequest();
        });

        _workoutNavigator.activePage$.listen(expectAsync1((NavigatorPage page) {
          expect(page, _initialPage);
        }, count: 1));
      });

      group('backwards navigation', () {
        test('should tell when view can pop route', () {
          scheduleMicrotask(() {
            _workoutNavigator.handleBackRequest();
            _workoutNavigator.handleValidationSuccess();
          });

          _workoutNavigator.shouldPopRoute$.listen(expectAsync1((bool canPop) {
            expect(canPop, true);
          }, count: 1));
        });
      });
      group('forward navigation', () {
        setUp(() {
          _workoutViewModel.setGeneralVariables(
              holdCount: 1,
              sets: 1,
              restBetweenHolds: 180,
              restBetweenSets: 180,
              board: basicTestWorkout.board);
        });

        test('should tell when view can navigate back to overview', () {
          scheduleMicrotask(() {
            _workoutNavigator.handleForwardRequest();
            _workoutNavigator.handleValidationSuccess();
            _workoutNavigator.handleForwardRequest();
            _workoutNavigator.handleValidationSuccess();
            _workoutNavigator.handleForwardRequest();
            _workoutNavigator.handleValidationSuccess();
          });

          _workoutNavigator.shouldPopRoute$.listen(expectAsync1((bool canPop) {
            expect(canPop, true);
          }, count: 1));
        });

        // TODO:
        test('should tell workout_vm it should save the values', () {});
      });
    });
  });
}
