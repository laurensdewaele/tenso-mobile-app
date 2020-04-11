import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:app/services/parser.dart';
import 'package:app/services/toast.dart';
import 'package:app/services/validation.dart';
import 'package:app/styles/styles.dart' as styles;

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

class ErrorService {
  ToastService _toastService;

  // Creates a singleton.
  ErrorService._(ToastService toastService) : _toastService = toastService;
  static final ErrorService _errorService = ErrorService._(ToastService());
  factory ErrorService() {
    return _errorService;
  }

  Future<Null> handleFlutterError(FlutterErrorDetails details) {
    if (details.exception is AppException) {
      if (details.exception is ValidationException) {
        _toastService
            .add((details.exception as ValidationException).errorMessage);
      } else if (details.exception is ParseException) {
        _toastService.add((details.exception as ParseException).errorMessage);
      } else {
        print('You forgot to handle an AppExpection!');
      }
    } else {
      if (isInDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        // This will be caught by runZoned's onError.
        // In our case, being handled by ErrorService.handleZonedError.
        Zone.current.handleUncaughtError(details.exception, details.stack);
      }
    }
    return Future.value(null);
  }

  Future<Null> handleZonedError(dynamic error, dynamic stackTrace) {
    print('Caught error: $error');

    if (isInDebugMode) {
      print(stackTrace);
    } else {
      // TODO: Handle by sentry
    }
    return Future.value(null);
  }
}

class AppException {}

abstract class ErrorMessages {
  static Widget maxAllowedFingers(int maxAllowedFingers) => Text(
        'This hold only has room for $maxAllowedFingers fingers',
        textAlign: TextAlign.center,
        style: styles.Lato.sBlack,
      );
  static Widget holdAlreadyTaken() => Text(
        'Hold is already taken',
        textAlign: TextAlign.center,
      );
  static Widget biggerThanZero() => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Please input a value ',
            style: styles.Lato.sBlack,
            children: [
              TextSpan(text: 'bigger than 0.', style: styles.Lato.sBlackBold),
            ]),
      );
  static Widget inputNotEmpty() => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'The input can ',
            style: styles.Lato.sBlack,
            children: [
              TextSpan(text: 'not be empty.', style: styles.Lato.sBlackBold),
            ]),
      );
  static Widget inputNotANumber() => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'The input is ',
            style: styles.Lato.sBlack,
            children: [
              TextSpan(text: 'not a number.', style: styles.Lato.sBlackBold),
            ]),
      );
  static Widget inputSmallerThanZero(String inputField) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '$inputField ',
            style: styles.Lato.sBlackBold,
            children: [
              TextSpan(
                  text: 'input can not be ',
                  style: styles.Lato.sBlack,
                  children: [
                    TextSpan(
                        text: 'smaller than 0', style: styles.Lato.sBlackBold),
                  ]),
            ]),
      );
  static Widget inputLargerThan(int max, String inputField) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '$inputField ',
            style: styles.Lato.sBlackBold,
            children: [
              TextSpan(
                  text: 'input can not be ',
                  style: styles.Lato.sBlack,
                  children: [
                    TextSpan(
                        text: 'lager than $max', style: styles.Lato.sBlackBold),
                  ]),
            ]),
      );
  static Widget betweenRange(int min, int max) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'input can not be smaller than ',
            style: styles.Lato.sBlack,
            children: [
              TextSpan(
                  text: '$min, ',
                  style: styles.Lato.sBlackBold,
                  children: [
                    TextSpan(
                        text: 'or larger than ',
                        style: styles.Lato.sBlack,
                        children: [
                          TextSpan(
                            text: '$max',
                            style: styles.Lato.sBlackBold,
                          )
                        ]),
                  ]),
            ]),
      );
}
