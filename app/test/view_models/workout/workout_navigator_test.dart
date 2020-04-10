import 'dart:async';

import 'package:test/test.dart';

import '../../data/test_data.dart';
import 'package:app/models/models.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';

main() {
  group('Workout navigator', () {
    WorkoutNavigator _workoutNavigator;
    WorkoutViewModel _workoutViewModel;
    WorkoutNavigatorPage _initialPage = WorkoutNavigatorPage(
        page: WorkoutPages.generalPage, holdIndex: null, active: true, index: 0);

    setUp(() {
      _workoutViewModel = WorkoutViewModel(
        workoutType: WorkoutTypes.newWorkout,
        currentWeightUnit: WeightUnit.metric,
        workout: basicTestWorkout,
      );
      _workoutNavigator =
          WorkoutNavigator(initialHoldCount: basicTestWorkout.holdCount);
    });

    tearDownAll(() {
      _workoutViewModel.dispose();
      _workoutNavigator.dispose();
    });

    test('should initialize', () {
      expect(_workoutNavigator.runtimeType, WorkoutNavigator);
    });
    test('should display the correct page', () {
      _workoutNavigator.activePage$.listen(expectAsync1((WorkoutNavigatorPage page) {
        expect(page, _initialPage);
      }, count: 1));
    });

    group('on navigation', () {
      test('should mark the workout page to validate', () {
        scheduleMicrotask(() {
          _workoutNavigator.handleForwardRequest();
        });

        _workoutNavigator.shouldValidate$
            .listen(expectAsync1((bool shouldValidate) {
          expect(shouldValidate, true);
        }, count: 1));
      });
      test('should navigate when validation is successful', () {
        scheduleMicrotask(() {
          _workoutNavigator.handleForwardRequest();
          _workoutNavigator.handleValidationSuccess();
        });

        int _emitted = 0;
        _workoutNavigator.activePage$.listen(expectAsync1((WorkoutNavigatorPage page) {
          if (_emitted == 0) {
            expect(page, _initialPage);
          }
          if (_emitted == 1) {
            expect(
                page,
                WorkoutNavigatorPage(
                    active: true,
                    index: 1,
                    holdIndex: 0,
                    page: WorkoutPages.holdPage));
          }
          _emitted++;
        }, count: 2));
      });
      test('should not navigate when validation is unsuccessful', () {
        scheduleMicrotask(() {
          _workoutNavigator.handleForwardRequest();
        });

        _workoutNavigator.activePage$.listen(expectAsync1((WorkoutNavigatorPage page) {
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
