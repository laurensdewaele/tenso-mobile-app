import 'package:test/test.dart';

import '../../data/test_data.dart';

import 'package:app/models/models.dart';
import 'package:app/view_models/workout/workout_vm.dart';

void main() {
  group('Workout extra page', () {
    test('should initialize', () {});
    group('validation', () {
      test('should occur when input field loses focus', () {});
      test('should occur when navigator tell us to', () {});
      test('should report values back to workout_vm on validation success',
          () {});

      group('valid input', () {
        test('set label', () {});
        test('set name', () {});
      });

      group('invalid input', () {
        test('should throw on invalid name', () {});
      });
    });
  });
}
