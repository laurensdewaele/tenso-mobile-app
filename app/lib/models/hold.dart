import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';

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
      // TODO: Mark all as required
      {this.grip,
      this.handHold,
      this.boardHolds,
      this.repetitions,
      this.restBeforeNextHold,
      this.restBetweenRepetitions,
      this.hangTime,
      this.addedWeight});

  final String grip;
  final HandHolds handHold;
  final List<BoardHold> boardHolds;
  final int repetitions;
  final int restBeforeNextHold;
  final int restBetweenRepetitions;
  final int hangTime;
  final int addedWeight;
}

enum HandHolds { twoHanded, oneHandedLeft, oneHandedRight }
