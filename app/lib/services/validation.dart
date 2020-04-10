import 'package:flutter/widgets.dart';

import 'package:app/models/models.dart';
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
abstract class Validators {
  static bool biggerThanZero<T>(T value) {
    bool _bool = false;
    if (value == null) {
      return _bool;
    }

    if ((value as dynamic) > 0) {
      _bool = true;
    } else {
      throw ValidationException<T>(
          validationType: 'biggerThanZero',
          errorMessage: ErrorMessages.biggerThanZero(),
          input: value);
    }
    return _bool;
  }

  static bool betweenRange<T>(int min, int max, dynamic value) {
    bool _bool = false;
    if (value == null) {
      return _bool;
    }
    if (value > min && value < max) {
      _bool = true;
    } else {
      throw ValidationException<T>(
          validationType: 'betweenRange',
          errorMessage: ErrorMessages.betweenRange(min, max),
          input: value);
    }
    return _bool;
  }

  static bool stringNotEmpty(String s) {
    bool _bool = false;
    if (s == null) {
      return _bool;
    }

    if (s.length == 0) {
      throw ValidationException<String>(
          validationType: 'stringNotEmpty',
          errorMessage: ErrorMessages.inputNotEmpty(),
          input: s);
    } else {
      _bool = true;
    }
    return _bool;
  }

  static bool checkGripCompatibility(BoardHold boardHold, Grip grip) {
    bool _bool = false;

    if (boardHold == null || grip == null) {
      return _bool;
    }

    if (boardHold.checkGripCompatibility(grip) == true) {
      _bool = true;
    } else {
      throw ValidationException<BoardHold>(
          input: boardHold,
          errorMessage:
              ErrorMessages.maxAllowedFingers(boardHold.maxAllowedFingers),
          validationType: 'gripCompatibility');
    }
    return _bool;
  }
}
