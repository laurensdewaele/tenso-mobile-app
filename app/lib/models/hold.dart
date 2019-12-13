import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/grips.dart';
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
      {@required this.grip,
      @required this.handHold,
      @required this.boardHolds,
      @required this.repetitions,
      @required this.restBeforeNextHold,
      @required this.restBetweenRepetitions,
      @required this.hangTime,
      @required this.addedWeight});

  final Grip grip;
  final HandHolds handHold;
  final List<BoardHold> boardHolds;
  final int repetitions;
  final int restBeforeNextHold;
  final int restBetweenRepetitions;
  final int hangTime;
  final int addedWeight;
}
