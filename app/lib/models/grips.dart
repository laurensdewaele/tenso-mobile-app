import 'package:flutter/cupertino.dart';

class Grips {
  Grips._();

  static final Grip monoPinky = Grip(
      description: 'mono pinky',
      name: 'monoPinkyL',
      fingers: Fingers(pinky: true),
      assetSrcL: 'assets/images/grips/mono_pinky_L.png',
      assetSrcR: 'assets/images/grips/mono_pinky_R.png');
  static final Grip monoRing = Grip(
    description: 'mono ring finger',
    name: 'monoRingL',
    fingers: Fingers(ring: true),
    assetSrcL: 'assets/images/grips/mono_ring_L.png',
    assetSrcR: 'assets/images/grips/mono_ring_R.png',
  );

  static final Grip monoMiddle = Grip(
      description: 'mono middle finger',
      name: 'monoMiddleL',
      fingers: Fingers(middle: true),
      assetSrcL: 'assets/images/grips/mono_middle_L.png',
      assetSrcR: 'assets/images/grips/mono_middle_R.png');

  static final Grip monoIndex = Grip(
      description: 'mono index finger',
      name: 'monoIndexL',
      fingers: Fingers(index: true),
      assetSrcL: 'assets/images/grips/mono_index_L.png',
      assetSrcR: 'assets/images/grips/mono_index_R.png');

  static final Grip frontTwo = Grip(
      description: 'front two',
      name: 'frontTwoL',
      fingers: Fingers(index: true, middle: true),
      assetSrcL: 'assets/images/grips/front_two_L.png',
      assetSrcR: 'assets/images/grips/front_two_R.png');

  static final Grip middleTwo = Grip(
      description: 'middle two',
      name: 'middleTwoL',
      fingers: Fingers(middle: true, ring: true),
      assetSrcL: 'assets/images/grips/middle_two_L.png',
      assetSrcR: 'assets/images/grips/middle_two_R.png');

  static final Grip backTwo = Grip(
      description: 'back two',
      name: 'backTwoL',
      fingers: Fingers(ring: true, pinky: true),
      assetSrcL: 'assets/images/grips/back_two_L.png',
      assetSrcR: 'assets/images/grips/back_two_R.png');

  static final Grip frontThree = Grip(
      description: 'front three',
      name: 'frontThreeL',
      fingers: Fingers(index: true, middle: true, ring: true),
      assetSrcL: 'assets/images/grips/front_three_L.png',
      assetSrcR: 'assets/images/grips/front_three_R.png');

  static final Grip backThree = Grip(
      description: 'back three',
      name: 'backThreeL',
      fingers: Fingers(middle: true, ring: true, pinky: true),
      assetSrcL: 'assets/images/grips/back_three_L.png',
      assetSrcR: 'assets/images/grips/back_three_R.png');

  static final Grip openHand = Grip(
    description: 'open hand',
    name: 'openHandL',
    fingers: Fingers(index: true, middle: true, ring: true, pinky: true),
    assetSrcL: 'assets/images/grips/open_hand_L.png',
    assetSrcR: 'assets/images/grips/open_hand_R.png',
  );

  static final Grip halfCrimp = Grip(
      description: 'half crimp',
      name: 'halfCrimpL',
      fingers: Fingers(index: true, middle: true, ring: true, pinky: true),
      crimped: true,
      assetSrcL: 'assets/images/grips/half_crimp_L.png',
      assetSrcR: 'assets/images/grips/half_crimp_R.png');

  static final Grip fullCrimp = Grip(
      description: 'full crimp',
      name: 'fullCrimpL',
      fingers: Fingers(
          index: true, middle: true, ring: true, pinky: true, thumb: true),
      crimped: true,
      assetSrcL: 'assets/images/grips/full_crimp_L.png',
      assetSrcR: 'assets/images/grips/full_crimp_R.png');

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
      @required this.assetSrcL,
      @required this.assetSrcR,
      @required this.description,
      this.name});

  final Fingers fingers;
  final bool crimped;
  final String assetSrcL;
  final String assetSrcR;
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
  Fingers(
      {this.pinky = false,
      this.ring = false,
      this.middle = false,
      this.index = false,
      this.thumb = false})
      : length = _determineLength(pinky, ring, middle, index, thumb);
  final bool pinky;
  final bool ring;
  final bool middle;
  final bool index;
  final bool thumb;
  final int length;

  static int _determineLength(pinky, ring, middle, index, thumb) {
    final list = [pinky, ring, middle, index, thumb];
    list.removeWhere((finger) => !finger);
    return list.length;
  }
}
