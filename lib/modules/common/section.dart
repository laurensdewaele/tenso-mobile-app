import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';

class Section extends StatelessWidget {
  Section(
      {@required this.title,
      @required this.children,
      this.nextSectionHasInfoIcon = false});

  final String title;
  final List<Widget> children;
  final bool nextSectionHasInfoIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: styles.Staatliches.xlBlack,
        ),
        Divider(height: styles.Measurements.l),
        ...children,
        Divider(
            height: nextSectionHasInfoIcon == true
                ? styles.Measurements.xxl - styles.Measurements.kInfoIconSurplus
                : styles.Measurements.xxl),
      ],
    );
  }
}
