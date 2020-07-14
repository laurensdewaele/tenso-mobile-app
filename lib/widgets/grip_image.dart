import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class GripImage extends StatelessWidget {
  GripImage(
      {Key key,
      @required this.imageAsset,
      @required this.selected,
      this.color,
      this.primaryColor = styles.Colors.primary})
      : super(key: key);

  final String imageAsset;
  final bool selected;
  final Color color;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageAsset,
      color: selected ? primaryColor : color,
    );
  }
}
