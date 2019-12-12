import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/icon.dart';

// Built this in order the make the hit boxes bigger.
// Not a perfect solution, but apparently it cannot be done.
// https://laurens.codes/flutter_icon_button.html
class IconButton extends StatelessWidget {
  IconButton(
      {@required this.handleTap,
      @required this.icon,
      this.padding = const EdgeInsets.all(styles.Measurements.m)});

  final VoidCallback handleTap;
  final Icon icon;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleTap,
        child: Container(
          decoration: BoxDecoration(color: styles.Colors.translucent),
          child: Padding(
            padding: padding,
            child: icon,
          ),
        ));
  }
}
