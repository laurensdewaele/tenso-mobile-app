import 'package:flutter/widgets.dart';
import 'package:tenso_app/modules/toast/toast_message.dart';
import 'package:tenso_app/services/error.service.dart';

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
  static double parseToDouble(
      {@required @required String string,
      @required @required String inputField}) {
    if (string == null) {
      return null;
    }

    double value;
    try {
      final String replacedCommas = string.replaceFirst(',', '.');
      value = double.parse(replacedCommas.trim());
    } on FormatException catch (exception, stackTrace) {
      throw ParseException(
          input: string,
          exception: exception,
          parseType: 'parseToDouble',
          stackTrace: stackTrace,
          errorMessage: ToastMessages.inputNotANumber(inputField: inputField));
    }
    return value;
  }

  static int parseToInt(
      {@required @required String string,
      @required @required String inputField}) {
    if (string == null) {
      return null;
    }

    int value;
    try {
      value = int.parse(string.trim());
    } on FormatException catch (exception, stackTrace) {
      throw ParseException(
          input: string,
          exception: exception,
          parseType: 'parseToInt',
          stackTrace: stackTrace,
          errorMessage: ToastMessages.inputNotANumber(inputField: inputField));
    }
    return value;
  }

  static String parseString({@required String string}) {
    if (string == null) {
      return null;
    }

    return string.trim();
  }
}
