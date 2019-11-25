import 'package:flutter/cupertino.dart';

@immutable
class Hold {
  const Hold(
      // TODO: Mark all as required
      {this.grip,
      this.twoHanded,
      this.oneHandLeft,
      this.oneHandRight,
      this.pockets,
      this.repetitions,
      this.restBetweenRepetitions,
      this.hangTime,
      this.addedWeight});

  final String grip;
  final bool twoHanded;
  final bool oneHandLeft;
  final bool oneHandRight;
  final List<int> pockets;
  final int repetitions;
  final int restBetweenRepetitions;
  final int hangTime;
  final int addedWeight;
}
