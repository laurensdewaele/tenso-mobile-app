import 'dart:async';

import 'package:tenso_app/services/parser.service.dart';
import 'package:tenso_app/services/toast.service.dart';
import 'package:tenso_app/services/validation.service.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:flutter/widgets.dart';

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

abstract class ErrorMessages {
  static Widget groupsEmpty() => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: 'You need to input at least ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(
            text: '1 group.',
            style: styles.Lato.sBlackBold,
          ),
        ]),
      );
  static Widget exceedsSupportedFingers({int max}) => Text(
        'This hold only has room for $max fingers.',
        textAlign: TextAlign.center,
        style: styles.Lato.sBlack,
      );
  static Widget holdAlreadyTaken() => Text(
        'Hold is already taken.',
        textAlign: TextAlign.center,
      );
  static Widget biggerThanZero({String inputField}) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: '$inputField ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'input needs to be ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(text: 'bigger than 0.', style: styles.Lato.sBlackBold)
        ]),
      );
  static Widget biggerOrEqualToZero({String inputField}) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: '$inputField ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'input needs to be ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(text: 'bigger or equal to 0.', style: styles.Lato.sBlackBold)
        ]),
      );
  static Widget inputNotEmpty({String inputField}) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: '$inputField ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'input can ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(text: 'not be empty.', style: styles.Lato.sBlackBold)
        ]),
      );
  static Widget inputNotANumber({String inputField}) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: '$inputField ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'input is ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(text: 'not a number.', style: styles.Lato.sBlackBold)
        ]),
      );
  static Widget inputSmallerThanZero({String inputField}) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: '$inputField ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'input can not be ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(text: 'smaller than 0.', style: styles.Lato.sBlackBold)
        ]),
      );
  static Widget inputLargerThan({int max, String inputField}) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: '$inputField ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'input can not be ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(text: 'larger than $max.', style: styles.Lato.sBlackBold)
        ]),
      );
  static Widget betweenRange({int min, int max, String inputField}) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: '$inputField ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'input can not be ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(text: 'smaller than $min ', style: styles.Lato.sBlackBold),
          TextSpan(
            text: 'or ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(text: 'larger than $max.', style: styles.Lato.sBlackBold),
        ]),
      );

  static Widget customBoardNotAdjacent() => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: 'Multiple selection requires elements ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(
            text: 'next to each other, ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(text: 'on the ', style: styles.Lato.sBlack),
          TextSpan(text: 'same row.', style: styles.Lato.sBlackBold),
        ]),
      );

  static Widget customBoardDeselect() => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: 'Deselecting here will ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(
            text: 'create a gap. ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(text: 'Elements ', style: styles.Lato.sBlack),
          TextSpan(
            text: 'need to be next to each other.',
            style: styles.Lato.sBlackBold,
          ),
        ]),
      );
  static Widget minimumTwoBoardHolds() => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: 'There needs to be a ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(
            text: 'minimum ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'of ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(
            text: '2 ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(text: 'holds in order to save.', style: styles.Lato.sBlack),
        ]),
      );
  static Widget loggingOnlyPossibleOnRests() => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: 'Logging ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'hangs is only possible on ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(
            text: 'rest ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'periods.',
            style: styles.Lato.sBlack,
          ),
        ]),
      );
  static Widget loggingNotPossibleWhenNoCompletedHangs() => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
          TextSpan(
            text: 'Logging ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'is not possible when there are ',
            style: styles.Lato.sBlack,
          ),
          TextSpan(
            text: 'no completed ',
            style: styles.Lato.sBlackBold,
          ),
          TextSpan(
            text: 'hangs.',
            style: styles.Lato.sBlack,
          ),
        ]),
      );
}
