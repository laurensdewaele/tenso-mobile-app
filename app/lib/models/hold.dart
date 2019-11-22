import 'package:flutter/cupertino.dart';

@immutable
class Hold {
  const Hold(
      // TODO: Mark all as required
      {this.grip,
      this.twoHanded,
      this.leftHanded,
      this.rightHanded,
      this.pockets,
      this.repetitions,
      this.restBetweenRepetitions,
      this.hangTime,
      this.addedWeight});

  final String grip;
  final bool twoHanded;
  final bool leftHanded;
  final bool rightHanded;
  final List<String> pockets;
  final int repetitions;
  final int restBetweenRepetitions;
  final int hangTime;
  final int addedWeight;
}
