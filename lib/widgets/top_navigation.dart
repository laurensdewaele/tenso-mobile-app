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
                  icon:
                      dark == true ? icons.backIconWhite : icons.backIconBlack,
                ))
          ],
        ),
        Positioned.fill(
          child: Center(
            child: Text(title,
                style: dark == true
                    ? styles.Staatliches.mWhite
                    : styles.Staatliches.mBlack,
                textAlign: TextAlign.center),
          ),
        ),
      ]),
    ]);
  }
}
