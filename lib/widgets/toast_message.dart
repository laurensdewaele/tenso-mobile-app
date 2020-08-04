import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/divider.dart';

class ToastMessage extends StatelessWidget {
  ToastMessage({Key key, @required this.success, @required this.message})
      : super(key: key);

  final bool success;
  final Widget message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (success == false)
          Image.asset(
            'assets/images/icons/error.png',
            width: 40,
            height: 40,
          ),
        if (success == true)
          Image.asset(
            'assets/images/icons/success.png',
            width: 40,
            height: 40,
          ),
        Divider(width: styles.Measurements.m),
        Expanded(child: Center(child: message))
      ],
    );
  }
}

abstract class ToastMessages {
  static Widget failedBrowserLaunch() => ToastMessage(
        success: false,
        message: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
            TextSpan(
              text: 'Failed to open browser.',
              style: styles.Lato.sBlack,
            ),
          ]),
        ),
      );

  static Widget groupsEmpty() => ToastMessage(
        success: false,
        message: RichText(
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
        ),
      );
  static Widget exceedsSupportedFingers({int max}) => ToastMessage(
      success: false,
      message: Text(
        'This hold only has room for $max fingers.',
        textAlign: TextAlign.center,
        style: styles.Lato.sBlack,
      ));
  static Widget holdAlreadyTaken() => ToastMessage(
      success: false,
      message: Text(
        'Hold is already taken.',
        textAlign: TextAlign.center,
      ));
  static Widget biggerThanZero({String inputField}) => ToastMessage(
      success: false,
      message: RichText(
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
      ));
  static Widget biggerOrEqualToZero({String inputField}) => ToastMessage(
      success: false,
      message: RichText(
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
      ));
  static Widget inputNotEmpty({String inputField}) => ToastMessage(
      success: false,
      message: RichText(
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
      ));
  static Widget inputNotANumber({String inputField}) => ToastMessage(
      success: false,
      message: RichText(
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
      ));
  static Widget inputSmallerThanZero({String inputField}) => ToastMessage(
      success: false,
      message: RichText(
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
      ));
  static Widget inputLargerThan({int max, String inputField}) => ToastMessage(
        success: false,
        message: RichText(
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
            ])),
      );
  static Widget betweenRange({int min, int max, String inputField}) =>
      ToastMessage(
          success: false,
          message: RichText(
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
              TextSpan(
                  text: 'smaller than $min ', style: styles.Lato.sBlackBold),
              TextSpan(
                text: 'or ',
                style: styles.Lato.sBlack,
              ),
              TextSpan(
                  text: 'larger than $max.', style: styles.Lato.sBlackBold),
            ]),
          ));

  static Widget customBoardNotAdjacent() => ToastMessage(
      success: false,
      message: RichText(
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
      ));

  static Widget customBoardDeselect() => ToastMessage(
        success: false,
        message: RichText(
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
            ])),
      );
  static Widget minimumTwoBoardHolds() => ToastMessage(
        success: false,
        message: RichText(
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
            TextSpan(
                text: 'holds in order to save.', style: styles.Lato.sBlack),
          ]),
        ),
      );
  static Widget loggingOnlyPossibleOnRests() => ToastMessage(
        success: false,
        message: RichText(
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
        ),
      );
  static Widget loggingNotPossibleWhenNoCompletedHangs() => ToastMessage(
        success: false,
        message: RichText(
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
        ),
      );

  static Widget feedbackError() => ToastMessage(
        success: false,
        message: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
            TextSpan(
              text: 'The message could not be sent. Please try again at a ',
              style: styles.Lato.sBlack,
            ),
            TextSpan(
              text: 'later date.',
              style: styles.Lato.sBlackBold,
            ),
          ]),
        ),
      );

  static Widget feedbackSuccess() => ToastMessage(
        success: true,
        message: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(text: '', style: styles.Lato.sBlack, children: [
            TextSpan(
              text: 'The message has been sent.',
              style: styles.Lato.sBlack,
            ),
          ]),
        ),
      );
}
