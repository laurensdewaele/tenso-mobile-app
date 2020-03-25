import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';

class ExpandedContentTile extends StatelessWidget {
  ExpandedContentTile(
      {Key key,
      @required this.title,
      @required this.content,
      this.contentContainerHeight})
      : super(key: key);

  final String title;
  final Widget content;
  final double contentContainerHeight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: <Widget>[
      Text(
        title,
        style: styles.Staatliches.xsBlack,
      ),
      Divider(
        height: styles.Measurements.xs,
      ),
      if (contentContainerHeight != null)
        Container(height: contentContainerHeight, child: content),
      if (contentContainerHeight == null) content
    ]));
  }
}
