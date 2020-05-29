import 'package:app/models/models.dart';
import 'package:app/services/error.service.dart';
import 'package:flutter/widgets.dart';

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
  static bool biggerThanZero<T>(
      {@required T value, @required String inputField}) {
    bool _bool = false;

    if (value == null) {
      return _bool;
    }

    if ((value as dynamic) > 0) {
      _bool = true;
    } else {
      throw ValidationException<T>(
          validationType: 'biggerThanZero',
          errorMessage: ErrorMessages.biggerThanZero(inputField: inputField),
          input: value);
    }
    return _bool;
  }

  static bool biggerOrEqualToZero<T>(
      {@required T value, @required String inputField}) {
    bool _bool = false;

    if (value == null) {
      return _bool;
    }

    if ((value as dynamic) >= 0) {
      _bool = true;
    } else {
      throw ValidationException<T>(
          validationType: 'biggerOrEqualToZero',
          errorMessage:
              ErrorMessages.biggerOrEqualToZero(inputField: inputField),
          input: value);
    }
    return _bool;
  }

  static bool betweenRange<T>(
      {@required int min,
      @required int max,
      @required T value,
      @required String inputField}) {
    bool _bool = false;

    if (value == null) {
      return _bool;
    }
    if ((value as dynamic) > min && (value as dynamic) < max) {
      _bool = true;
    } else {
      throw ValidationException<T>(
          validationType: 'betweenRange',
          errorMessage: ErrorMessages.betweenRange(
              min: min, max: max, inputField: inputField),
          input: value);
    }
    return _bool;
  }

  static bool stringNotEmpty(
      {@required String string, @required String inputField}) {
    bool _bool = false;

    if (string == null || string.length == 0) {
      throw ValidationException<String>(
          validationType: 'stringNotEmpty',
          errorMessage: ErrorMessages.inputNotEmpty(inputField: inputField),
          input: string);
    } else {
      _bool = true;
    }
    return _bool;
  }

  static bool checkGripCompatibility(
      {@required BoardHold boardHold, @required Grip grip}) {
    bool _bool = false;

    if (boardHold == null || grip == null) {
      return _bool;
    }

    if (boardHold.checkGripCompatibility(grip) == true) {
      _bool = true;
    } else {
      throw ValidationException<BoardHold>(
          input: boardHold,
          errorMessage: ErrorMessages.exceedsSupportedFingers(
              max: boardHold.supportedFingers),
          validationType: 'gripCompatibility');
    }
    return _bool;
  }
}
