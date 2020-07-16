import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:tenso_app/services/parser.service.dart';
import 'package:tenso_app/services/toast.service.dart';
import 'package:tenso_app/services/validation.service.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

class ErrorService {
  ToastService _toastService;

  ErrorService._(ToastService toastService) : _toastService = toastService;
  static final ErrorService _errorService = ErrorService._(ToastService());
  factory ErrorService() => _errorService;

  Future<Null> handleFlutterError(FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      // This will be caught by runZoned's onError.
      // In our case, being handled by ErrorService.handleZonedError.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
    return Future.value();
  }

  Future<Null> handleZonedError(dynamic error, dynamic stackTrace) {
    if (error is AppException) {
      if (error is ValidationException) {
        _toastService.add(error.errorMessage);
      } else if (error is ParseException) {
        _toastService.add(error.errorMessage);
      } else {
        print('You forgot to handle an AppExpection!');
      }
    } else {
      print('Caught error: $error');

      if (isInDebugMode) {
        print(stackTrace);
      } else {
        // TODO: Handle by sentry
      }
    }
    return Future.value();
  }
}

class AppException {}
