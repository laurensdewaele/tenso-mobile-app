import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class GripImage extends StatelessWidget {
  GripImage(
      {Key key,
      @required this.assetSrc,
      @required this.selected,
      this.color = styles.Colors.lightGray})
      : super(key: key);

  final String assetSrc;
  final bool selected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetSrc,
      color: selected ? styles.Colors.black : color,
    );
  }
}
