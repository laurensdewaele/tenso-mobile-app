import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;

Widget checkGripBoardHoldCompatibility(Grip grip, BoardHold boardHold) {
  if (boardHold != null && grip.fingers.count > boardHold.maxAllowedFingers) {
    final maxAllowedFingers = boardHold.maxAllowedFingers;
    return Text(
      'This hold only has room for $maxAllowedFingers fingers',
      textAlign: TextAlign.center,
      style: styles.Lato.sBlack,
    );
  }
  return null;
}
