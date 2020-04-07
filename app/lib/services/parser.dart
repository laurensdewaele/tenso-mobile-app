import 'package:flutter/widgets.dart';

import 'package:app/services/error.dart';

class ParseException extends AppException {
  final String input;
  final String parseType;
  final FormatException exception;
  final Widget errorMessage;
  final StackTrace stackTrace;

  ParseException({
    @required this.input,
    @required this.parseType,
    @required this.exception,
    @required this.errorMessage,
    @required this.stackTrace,
  });
}

abstract class InputParsers {
  static double parseToDouble(String s) {
    if (s == null) {
      return null;
    }

    double value;
    try {
      value = double.parse(s.trim());
    } on FormatException catch (exception, stackTrace) {
      throw ParseException(
          input: s,
          exception: exception,
          parseType: 'parseToDouble',
          stackTrace: stackTrace,
          errorMessage: ErrorMessages.inputNotANumber());
    }
    return value;
  }

  static int parseToInt(String s) {
    if (s == null) {
      return null;
    }

    int value;
    try {
      value = int.parse(s.trim());
    } on FormatException catch (exception, stackTrace) {
      throw ParseException(
          input: s,
          exception: exception,
          parseType: 'parseToInt',
          stackTrace: stackTrace,
          errorMessage: ErrorMessages.inputNotANumber());
    }
    return value;
  }
}
