import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';

class Section extends StatelessWidget {
  Section({@required this.title, @required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: styles.Typography.title,
        ),
        Divider(height: styles.Measurements.l),
        ...children,
        Divider(height: styles.Measurements.xxl),
      ],
    );
  }
}
