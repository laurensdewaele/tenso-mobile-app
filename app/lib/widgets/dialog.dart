import 'dart:ui' show ImageFilter;
import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class AppDialog extends StatelessWidget {
  /// Creates an iOS-style alert dialog.
  ///
  /// The [actions] must not be null.
  const AppDialog({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SafeArea(
          child: Center(
              child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                      vertical: styles.Measurements.m),
                  padding:
                      EdgeInsets.symmetric(horizontal: styles.Measurements.m),
                  child: ClipRRect(
                    borderRadius: styles.kAppBorderRadiusAll,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: styles.kDialogBackdropBlurAmount,
                          sigmaY: styles.kDialogBackdropBlurAmount),
                      child: Container(
                        decoration: styles.kDialogBlurOverlayDecoration,
                        child: Container(
                          color: styles.Colors.bgWhite,
                          padding: EdgeInsets.all(styles.Measurements.m),
                          child: child,
                        ),
                      ),
                    ),
                  ))),
        );
      },
    );
  }
}

Future<void> showAppDialog(
    {@required BuildContext context, @required Widget child}) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => AppDialog(child: child));
}
