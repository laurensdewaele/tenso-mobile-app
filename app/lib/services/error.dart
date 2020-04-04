import 'package:flutter/widgets.dart';

import 'package:app/styles/styles.dart' as styles;

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
}

class ErrorService {}
