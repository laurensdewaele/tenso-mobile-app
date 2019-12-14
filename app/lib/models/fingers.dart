import 'package:flutter/foundation.dart';

class Fingers {
  const Fingers(
      {this.pinky = false,
      this.ring = false,
      this.middle = false,
      this.index = false,
      this.thumb = false,
      @required this.count});

  final bool pinky;
  final bool ring;
  final bool middle;
  final bool index;
  final bool thumb;
  final int count;
}
