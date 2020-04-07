import 'package:flutter/widgets.dart';

import 'package:app/services/error.dart';

class ValidationException<T> extends AppException {
  final String validationType;
  final Widget errorMessage;
  final T input;

  ValidationException(
      {@required this.validationType,
      @required this.errorMessage,
      @required this.input});
}

// Do not forget null checks here, InputParsers can return null
abstract class Validations {
  static bool biggerThanZero<T>(T value) {
    if (value == null) {
      return false;
    }

    if ((value as dynamic) > 0) {
      return true;
    } else {
      throw ValidationException<T>(
          validationType: 'biggerThanZero',
          errorMessage: ErrorMessages.biggerThanZero(),
          input: value);
    }
  }

  static bool betweenRange<T>(int min, int max, dynamic value) {
    if (value == null) {
      return false;
    }
    if (value > min && value < max) {
      return true;
    } else {
      throw ValidationException<T>(
          validationType: 'betweenRange',
          errorMessage: ErrorMessages.betweenRange(min, max),
          input: value);
    }
  }
}
