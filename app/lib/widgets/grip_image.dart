import 'package:flutter/cupertino.dart';

import 'package:app/models/hand_hold.dart';
import 'package:app/styles/styles.dart' as styles;

class GripImage extends StatelessWidget {
  GripImage(
      {Key key,
      @required this.handHold,
      @required this.assetSrcL,
      @required this.assetSrcR,
      @required this.selected,
      this.color = styles.Colors.lightGray})
      : super(key: key);

  final HandHolds handHold;
  final String assetSrcL;
  final String assetSrcR;
  final bool selected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      handHold == HandHolds.oneHandedLeft ? assetSrcL : assetSrcR,
      color: selected ? styles.Colors.black : color,
    );
  }
}
