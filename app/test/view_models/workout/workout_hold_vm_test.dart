import 'package:test/test.dart';

import '../../data/test_data.dart';

import 'package:app/models/models.dart';
import 'package:app/view_models/workout/workout_vm.dart';

main() {
  group('Workout hold page', () {
    test('should initialize', () {});

    group('validation', () {
      test('should occur when input field loses focus', () {});
      test('should occur when navigator tell us to', () {});
      test('should report values back to workout_vm on validation success',
          () {});

      group('valid input', () {
        test('set grips', () {});
        test('set boardHolds', () {});
        test('set repetitions', () {});
        test('set hang time seconds', () {});
        test('set seconds between repetitions', () {});
        test('set added weight', () {});
      });

      group('invalid input', () {
        test('should throw on invalid grips', () {});
        test('should throw on invalid boardHolds', () {});
        test('should throw on invalid repetitions', () {});
        test('should throw on invalid hang time seconds', () {});
        test('should throw on invalid seconds between repetitions', () {});
        test('should throw on invalid added weight', () {});
      });
    });
  });
}
