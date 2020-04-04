import 'package:flutter/widgets.dart';

import 'package:app/services/error.dart';

class ParseException<T> extends AppException {
  final String parseType;
  final FormatException exception;
  final Widget errorMessage;
  final StackTrace stackTrace;

  ParseException({
    @required this.parseType,
    @required this.exception,
    @required this.errorMessage,
    @required this.stackTrace,
  });
}

class ParseResult<T> {
  final T value;
  final bool success;

  const ParseResult({
    @required this.value,
    @required this.success,
  });
}

class InputParsers {
  ParseResult<double> parseToDouble(String s) {
    double value;
    try {
      value = double.parse(s.trim());
    } on FormatException catch (exception, stackTrace) {
      throw ParseException(
          exception: exception,
          parseType: 'parseToDouble',
          stackTrace: stackTrace,
          errorMessage: Text('df'));
    }
  }

  ParseResult<int> parseToInt(String s) {}
}
