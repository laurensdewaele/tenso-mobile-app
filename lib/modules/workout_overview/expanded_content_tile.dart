import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

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
    return Column(children: <Widget>[
      Text(
        title,
        style: styles.Staatliches.xsBlack,
        textAlign: TextAlign.center,
      ),
      Divider(
        height: styles.Measurements.xs,
      ),
      if (contentContainerHeight != null)
        Container(height: contentContainerHeight, child: content),
      if (contentContainerHeight == null) content
    ]);
  }
}
