import 'package:flutter/foundation.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';

enum HoldProperties {
  grip,
  handHold,
  boardHolds,
  repetitions,
  restBeforeNextHold,
  restBetweenRepetitions,
  hangTime,
  addedWeight
}

@immutable
class Hold {
  const Hold(
      {this.leftGrip,
      this.rightGrip,
      @required this.handHold,
      @required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.repetitions,
      @required this.restBeforeNextHold,
      @required this.restBetweenRepetitions,
      @required this.hangTime,
      @required this.addedWeight});

  final Grip leftGrip;
  final Grip rightGrip;
  final HandHolds handHold;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final int repetitions;
  final int restBeforeNextHold;
  final int restBetweenRepetitions;
  final int hangTime;
  final int addedWeight;
}
