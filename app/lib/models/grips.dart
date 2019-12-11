import 'package:flutter/cupertino.dart';

class Grips {
  Grips._();

  static final Grip monoPinky = Grip(
      description: 'mono pinky',
      name: 'monoPinky',
      fingers: Fingers(pinky: true),
      assetSrc: 'assets/images/grips/4_fingers.png');
  static final Grip monoRing = Grip(
      description: 'mono ring finger',
      name: 'monoRing',
      fingers: Fingers(ring: true),
      assetSrc: 'assets/images/grips/4_fingers.png');
  static final Grip monoMiddle = Grip(
      description: 'mono middle finger',
      name: 'monoMiddle',
      fingers: Fingers(middle: true),
      assetSrc: 'assets/images/grips/4_fingers.png');
  static final Grip monoIndex = Grip(
      description: 'mono index finger',
      name: 'monoIndex',
      fingers: Fingers(index: true),
      assetSrc: 'assets/images/grips/4_fingers.png');

  static final Grip frontTwo = Grip(
      description: 'front two',
      name: 'frontTwo',
      fingers: Fingers(index: true, middle: true),
      assetSrc: 'assets/images/grips/4_fingers.png');
  static final Grip middleTwo = Grip(
      description: 'middle two',
      name: 'middleTwo',
      fingers: Fingers(middle: true, ring: true),
      assetSrc: 'assets/images/grips/4_fingers.png');
  static final Grip backTwo = Grip(
      description: 'back two',
      name: 'backTwo',
      fingers: Fingers(ring: true, pinky: true),
      assetSrc: 'assets/images/grips/4_fingers.png');

  static final Grip frontThree = Grip(
      description: 'front three',
      name: 'frontThree',
      fingers: Fingers(index: true, middle: true, ring: true),
      assetSrc: 'assets/images/grips/4_fingers.png');
  static final Grip backThree = Grip(
      description: 'back three',
      name: 'backThree',
      fingers: Fingers(middle: true, ring: true, pinky: true),
      assetSrc: 'assets/images/grips/4_fingers.png');

  static final Grip openHand = Grip(
      description: 'open hand',
      name: 'openHand',
      fingers: Fingers(index: true, middle: true, ring: true, pinky: true),
      assetSrc: 'assets/images/grips/4_fingers.png');
  static final Grip openHandCrimp = Grip(
      description: 'open hand crimp',
      name: 'openHandCrimp',
      fingers: Fingers(index: true, middle: true, ring: true, pinky: true),
      crimped: true,
      assetSrc: 'assets/images/grips/4_fingers.png');
  static final Grip fullCrimp = Grip(
      description: 'full crimp',
      name: 'fullCrimp',
      fingers: Fingers(
          index: true, middle: true, ring: true, pinky: true, thumb: true),
      crimped: true,
      assetSrc: 'assets/images/grips/4_fingers.png');

  static final List<Grip> basic = [
    Grips.openHand,
    Grips.frontThree,
    Grips.backThree,
    Grips.frontTwo,
    Grips.middleTwo,
    Grips.backTwo,
  ];

  static final List<Grip> advanced = [
    Grips.openHandCrimp,
    Grips.openHand,
    Grips.frontThree,
    Grips.backThree,
    Grips.frontTwo,
    Grips.middleTwo,
    Grips.backTwo,
    Grips.monoIndex,
    Grips.monoMiddle,
    Grips.monoRing,
    Grips.monoPinky,
  ];
}

class Grip {
  Grip(
      {@required this.fingers,
      this.crimped = false,
      @required this.assetSrc,
      @required this.description,
      this.name});

  final Fingers fingers;
  final bool crimped;
  final String assetSrc;
  final String name;
  final String description;
}

class Fingers {
  const Fingers(
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
