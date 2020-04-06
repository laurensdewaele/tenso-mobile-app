import 'package:test/test.dart';

import 'package:app/view_models/workout/workout_general_vm.dart';

void main() {
  group('Workout general page view model', () {
    test('should validate when input field loses focus', () {});
    test('should set board', () {});

    // validation only happens when the input loses focus
    // or when the navigator tells it's time to.
    group('input validation', () {
      group('valid input', () {
        test('should set holdCount', () {});
        test('should set sets', () {});
        test('should set restBetweenHolds', () {});
        test('should set restBetweenSets', () {});
      });

      group('invalid input', () {
        test('should throw on invalid holdCount', () {});
        test('should throw on invalid sets', () {});
        test('should throw on invalid restBetweenHolds', () {});
        test('should throw on invalid restBetweenSets', () {});
      });
    });

    group('on navigation', () {
      test('should validate', () {});
      test('if vaidation is successful => report back to navigator', () {});
      test(
          'if validation is successful => save variables on workout_vm', () {});
    });
  });
}
