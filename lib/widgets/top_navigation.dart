import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/icon_button.dart';
import 'package:tenso_app/widgets/icons.dart' as icons;

class TopNavigation extends StatelessWidget {
  TopNavigation({this.title, this.dark = false, this.handleBackNavigation});

  final String title;
  final bool dark;
  final VoidCallback handleBackNavigation;

  void _handleTap(BuildContext context) {
    if (handleBackNavigation == null) {
      Navigator.of(context).pop();
    } else {
      handleBackNavigation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Stack(children: [
        Row(
          children: [
            GestureDetector(
                onTap: () => _handleTap(context),
                child: IconButton(
                  padding: EdgeInsets.fromLTRB(
                      styles.Measurements.xs,
                      styles.Measurements.m,
                      styles.Measurements.m,
                      styles.Measurements.m),
                  handleTap: () => _handleTap(context),
                  icon: dark ? icons.backIconBlack : icons.backIconWhite,
                ))
          ],
        ),
        Positioned.fill(
          child: Center(
            child: Text(title,
                style: dark
                    ? styles.Staatliches.mBlack
                    : styles.Staatliches.mWhite,
                textAlign: TextAlign.center),
          ),
        ),
      ]),
    ]);
  }
}
