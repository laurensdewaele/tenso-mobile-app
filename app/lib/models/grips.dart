import 'package:flutter/cupertino.dart';

class Grips {
  Grips._();

  static final Grip monoPinky = Grip(
      description: 'mono pinky',
      name: 'monoPinkyL',
      fingers: Fingers(pinky: true),
      assetSrc: 'assets/images/grips/mono_pinky_L.png');
  static final Grip monoRing = Grip(
      description: 'mono ring finger',
      name: 'monoRingL',
      fingers: Fingers(ring: true),
      assetSrc: 'assets/images/grips/mono_ring_L.png');

  static final Grip monoMiddle = Grip(
      description: 'mono middle finger',
      name: 'monoMiddleL',
      fingers: Fingers(middle: true),
      assetSrc: 'assets/images/grips/mono_middle_L.png');

  static final Grip monoIndex = Grip(
      description: 'mono index finger',
      name: 'monoIndexL',
      fingers: Fingers(index: true),
      assetSrc: 'assets/images/grips/mono_index_L.png');

  static final Grip frontTwo = Grip(
      description: 'front two',
      name: 'frontTwoL',
      fingers: Fingers(index: true, middle: true),
      assetSrc: 'assets/images/grips/front_two_L.png');

  static final Grip middleTwo = Grip(
      description: 'middle two',
      name: 'middleTwoL',
      fingers: Fingers(middle: true, ring: true),
      assetSrc: 'assets/images/grips/middle_two_L.png');

  static final Grip backTwo = Grip(
      description: 'back two',
      name: 'backTwoL',
      fingers: Fingers(ring: true, pinky: true),
      assetSrc: 'assets/images/grips/back_two_L.png');

  static final Grip frontThree = Grip(
      description: 'front three',
      name: 'frontThreeL',
      fingers: Fingers(index: true, middle: true, ring: true),
      assetSrc: 'assets/images/grips/front_three_L.png');

  static final Grip backThree = Grip(
      description: 'back three',
      name: 'backThreeL',
      fingers: Fingers(middle: true, ring: true, pinky: true),
      assetSrc: 'assets/images/grips/back_three_L.png');

  static final Grip openHand = Grip(
      description: 'open hand',
      name: 'openHandL',
      fingers: Fingers(index: true, middle: true, ring: true, pinky: true),
      assetSrc: 'assets/images/grips/open_hand_L.png');

  static final Grip halfCrimp = Grip(
      description: 'half crimp',
      name: 'halfCrimpL',
      fingers: Fingers(index: true, middle: true, ring: true, pinky: true),
      crimped: true,
      assetSrc: 'assets/images/grips/half_crimp_L.png');

  static final Grip fullCrimp = Grip(
      description: 'full crimp',
      name: 'fullCrimpL',
      fingers: Fingers(
          index: true, middle: true, ring: true, pinky: true, thumb: true),
      crimped: true,
      assetSrc: 'assets/images/grips/full_crimp_L.png');

  static final List<Grip> basic = [
    Grips.openHand,
    Grips.frontThree,
    Grips.backThree,
    Grips.frontTwo,
    Grips.middleTwo,
    Grips.backTwo,
  ];

  static final List<Grip> advanced = [
    Grips.fullCrimp,
    Grips.halfCrimp,
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Grip && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
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
