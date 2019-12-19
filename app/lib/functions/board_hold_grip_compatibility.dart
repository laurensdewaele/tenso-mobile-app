import 'package:flutter/cupertino.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';

Widget checkCompatibility(Grip grip, BoardHold boardHold) {
  if (grip.fingers.count > boardHold.maxAllowedFingers) {
    final maxAllowedFingers = boardHold.maxAllowedFingers;
    return Text(
      'This hold only has room for $maxAllowedFingers fingers',
      textAlign: TextAlign.center,
    );
  }
  if (grip.crimped == true && boardHold.holdType == HoldTypes.sloper) {
    return Text(
      'You should not crimp on slopers',
      textAlign: TextAlign.center,
    );
  }
  if (grip.crimped == true && boardHold.holdType == HoldTypes.jug) {
    return Text(
      'You should not crimp on jugs',
      textAlign: TextAlign.center,
    );
  }
  return null;
}
