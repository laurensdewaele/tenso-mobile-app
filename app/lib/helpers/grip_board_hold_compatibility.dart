import 'package:flutter/cupertino.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';

Widget checkGripBoardHoldCompatibility(Grip grip, BoardHold boardHold) {
  if (boardHold != null && grip.fingers.count > boardHold.maxAllowedFingers) {
    final maxAllowedFingers = boardHold.maxAllowedFingers;
    return Text(
      'This hold only has room for $maxAllowedFingers fingers',
      textAlign: TextAlign.center,
    );
  }
  return null;
}
