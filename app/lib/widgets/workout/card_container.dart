import 'package:flutter/cupertino.dart';

import 'package:app/widgets/card.dart';
import 'package:app/styles/styles.dart' as styles;

// It was necessary to not keep this above the general/hold/extra tab.
// Extra tab has an info icon title.
class CardContainer extends StatelessWidget {
  CardContainer({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: styles.Measurements.m,
                vertical: styles.Measurements.l),
            child: child,
          )
        ]));
  }
}
