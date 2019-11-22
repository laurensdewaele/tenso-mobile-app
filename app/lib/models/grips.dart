import 'package:flutter/cupertino.dart';

class Grips {
  Grips._();

  static final _Grip monoPinky = _Grip(fingers: _Fingers(pinky: true));
  static final _Grip monoRing = _Grip(fingers: _Fingers(ring: true));
  static final _Grip monoMiddle = _Grip(fingers: _Fingers(middle: true));
  static final _Grip monoIndex = _Grip(fingers: _Fingers(index: true));

  static final _Grip frontTwo =
      _Grip(fingers: _Fingers(index: true, middle: true));
  static final _Grip middleTwo =
      _Grip(fingers: _Fingers(middle: true, ring: true));
  static final _Grip backTwo =
      _Grip(fingers: _Fingers(ring: true, pinky: true));

  static final _Grip frontThree =
      _Grip(fingers: _Fingers(index: true, middle: true, ring: true));
  static final _Grip backThree =
      _Grip(fingers: _Fingers(middle: true, ring: true, pinky: true));

  static final _Grip openHand = _Grip(
      fingers: _Fingers(index: true, middle: true, ring: true, pinky: true));
  static final _Grip openHandCrimp = _Grip(
      fingers: _Fingers(index: true, middle: true, ring: true, pinky: true),
      crimped: true);
  static final _Grip fullCrimp = _Grip(
      fingers: _Fingers(
          index: true, middle: true, ring: true, pinky: true, thumb: true),
      crimped: true);
}

class _Grip {
  _Grip({@required this.fingers, this.crimped = false});
  final _Fingers fingers;
  final bool crimped;
}

class _Fingers {
  const _Fingers(
      {this.pinky = false,
      this.ring = false,
      this.middle = false,
      this.index = false,
      this.thumb = false});
  final bool pinky;
  final bool ring;
  final bool middle;
  final bool index;
  final bool thumb;
}
