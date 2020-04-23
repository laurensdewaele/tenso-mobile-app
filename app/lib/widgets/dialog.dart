import 'dart:ui' show ImageFilter;
import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

Future<void> showAppDialog({
  @required BuildContext context,
  @required Widget content,
  double width,
  double landscapeWidth,
}) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => AppDialog(
          content: content, width: width, landscapeWidth: landscapeWidth));
}

/// Creates an iOS-style alert dialog.
class AppDialog extends StatelessWidget {
  const AppDialog(
      {Key key, @required this.content, this.width, this.landscapeWidth})
      : super(key: key);

  final Widget content;
  final double width;
  final double landscapeWidth;

  @override
  Widget build(BuildContext context) {
    final Orientation _orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (_orientation == Orientation.portrait) {
              return Container(
                  width: width ?? double.infinity,
                  margin: const EdgeInsets.symmetric(
                      vertical: styles.Measurements.m),
                  padding:
                      EdgeInsets.symmetric(horizontal: styles.Measurements.m),
                  child: _Dialog(
                    content: content,
                  ));
            } else {
              return Container(
                  width: landscapeWidth ?? styles.kLandscapeDialogWidth,
                  child: _Dialog(
                    content: content,
                  ));
            }
          },
        ),
      ),
    );
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({Key key, this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: styles.kBorderRadiusAll,
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: styles.kDialogBackdropBlurAmount,
            sigmaY: styles.kDialogBackdropBlurAmount),
        child: Container(
          decoration: styles.kDialogBlurOverlayDecoration,
          child: Container(
            color: styles.Colors.bgWhite,
            padding: EdgeInsets.all(styles.Measurements.m),
            child: content,
          ),
        ),
      ),
    );
  }
}
