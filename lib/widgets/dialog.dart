import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

Future<void> showAppDialog({
  @required BuildContext context,
  @required Widget content,
  @required bool smallWidth,
  bool fullWidth = false,
}) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => AppDialog(
          content: content, smallWidth: smallWidth, fullWidth: fullWidth));
}

/// Creates an iOS-style alert dialog.
class AppDialog extends StatelessWidget {
  const AppDialog(
      {Key key, @required this.content, this.smallWidth, this.fullWidth})
      : super(key: key);

  final Widget content;
  final bool smallWidth;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final Orientation _orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (_orientation == Orientation.portrait) {
              return Container(
                  width: smallWidth == true
                      ? styles.kSmallDialogWidth
                      : double.infinity,
                  margin: const EdgeInsets.symmetric(
                      vertical: styles.Measurements.m),
                  padding:
                      EdgeInsets.symmetric(horizontal: styles.Measurements.m),
                  child: _Dialog(
                    content: content,
                  ));
            } else {
              return Container(
                  width: fullWidth
                      ? double.infinity
                      : smallWidth == true
                          ? styles.kSmallDialogWidth
                          : styles.kLandscapeDialogWidth,
                  margin: const EdgeInsets.symmetric(
                      vertical: styles.Measurements.m),
                  padding:
                      EdgeInsets.symmetric(horizontal: styles.Measurements.m),
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
