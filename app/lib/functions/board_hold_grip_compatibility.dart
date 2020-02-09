import 'package:flutter/cupertino.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hold_type.dart';

Widget checkCompatibility(Grip grip, BoardHold boardHold) {
  if (boardHold != null && grip.fingers.count > boardHold.maxAllowedFingers) {
    final maxAllowedFingers = boardHold.maxAllowedFingers;
    return Text(
      'This hold only has room for $maxAllowedFingers fingers',
      textAlign: TextAlign.center,
    );
  }
  if (boardHold != null &&
      grip.crimped == true &&
      boardHold.holdType == HoldType.jug) {
    return Text(
      'You should not crimp on jugs',
      textAlign: TextAlign.center,
    );
  }
  return null;
}
