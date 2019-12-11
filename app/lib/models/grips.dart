import 'package:flutter/cupertino.dart';

class Grips {
  Grips._();

  static final Grip monoPinkyL = Grip(
      description: 'mono pinky',
      name: 'monoPinkyL',
      fingers: Fingers(pinky: true),
      hands: Hands.left,
      assetSrc: 'assets/images/grips/mono_pinky_L.png');
  static final Grip monoPinkyR = Grip(
      description: 'mono pinky',
      name: 'monoPinkyR',
      fingers: Fingers(pinky: true),
      hands: Hands.right,
      assetSrc: 'assets/images/grips/mono_pinky_R.png');
  static final Grip monoRingL = Grip(
      description: 'mono ring finger',
      name: 'monoRingL',
      hands: Hands.left,
      fingers: Fingers(ring: true),
      assetSrc: 'assets/images/grips/mono_ring_L.png');
  static final Grip monoRingR = Grip(
      description: 'mono ring finger',
      name: 'monoRingR',
      hands: Hands.right,
      fingers: Fingers(ring: true),
      assetSrc: 'assets/images/grips/mono_ring_R.png');
  static final Grip monoMiddleL = Grip(
      description: 'mono middle finger',
      name: 'monoMiddleL',
      hands: Hands.left,
      fingers: Fingers(middle: true),
      assetSrc: 'assets/images/grips/mono_middle_L.png');
  static final Grip monoMiddleR = Grip(
      description: 'mono middle finger',
      name: 'monoMiddleR',
      hands: Hands.right,
      fingers: Fingers(middle: true),
      assetSrc: 'assets/images/grips/mono_middle_R.png');
  static final Grip monoIndexL = Grip(
      description: 'mono index finger',
      name: 'monoIndexL',
      hands: Hands.left,
      fingers: Fingers(index: true),
      assetSrc: 'assets/images/grips/mono_index_L.png');
  static final Grip monoIndexR = Grip(
      description: 'mono index finger',
      name: 'monoIndexR',
      hands: Hands.right,
      fingers: Fingers(index: true),
      assetSrc: 'assets/images/grips/mono_index_R.png');
  static final Grip frontTwoL = Grip(
      description: 'front two',
      name: 'frontTwoL',
      hands: Hands.left,
      fingers: Fingers(index: true, middle: true),
      assetSrc: 'assets/images/grips/front_two_L.png');
  static final Grip frontTwoR = Grip(
      description: 'front two',
      name: 'frontTwoR',
      hands: Hands.right,
      fingers: Fingers(index: true, middle: true),
      assetSrc: 'assets/images/grips/front_two_R.png');
  static final Grip middleTwoL = Grip(
      description: 'middle two',
      name: 'middleTwoL',
      hands: Hands.left,
      fingers: Fingers(middle: true, ring: true),
      assetSrc: 'assets/images/grips/middle_two_L.png');
  static final Grip middleTwoR = Grip(
      description: 'middle two',
      name: 'middleTwoR',
      hands: Hands.right,
      fingers: Fingers(middle: true, ring: true),
      assetSrc: 'assets/images/grips/middle_two_R.png');
  static final Grip backTwoL = Grip(
      description: 'back two',
      name: 'backTwoL',
      hands: Hands.left,
      fingers: Fingers(ring: true, pinky: true),
      assetSrc: 'assets/images/grips/back_two_L.png');
  static final Grip backTwoR = Grip(
      description: 'back two',
      name: 'backTwoR',
      hands: Hands.right,
      fingers: Fingers(ring: true, pinky: true),
      assetSrc: 'assets/images/grips/back_two_R.png');
  static final Grip frontThreeL = Grip(
      description: 'front three',
      name: 'frontThreeL',
      hands: Hands.left,
      fingers: Fingers(index: true, middle: true, ring: true),
      assetSrc: 'assets/images/grips/front_three_L.png');
  static final Grip frontThreeR = Grip(
      description: 'front three',
      name: 'frontThreeR',
      hands: Hands.right,
      fingers: Fingers(index: true, middle: true, ring: true),
      assetSrc: 'assets/images/grips/front_three_R.png');
  static final Grip backThreeL = Grip(
      description: 'back three',
      name: 'backThreeL',
      hands: Hands.left,
      fingers: Fingers(middle: true, ring: true, pinky: true),
      assetSrc: 'assets/images/grips/back_three_L.png');
  static final Grip backThreeR = Grip(
      description: 'back three',
      name: 'backThreeR',
      hands: Hands.right,
      fingers: Fingers(middle: true, ring: true, pinky: true),
      assetSrc: 'assets/images/grips/back_three_R.png');
  static final Grip openHandL = Grip(
      description: 'open hand',
      name: 'openHandL',
      hands: Hands.left,
      fingers: Fingers(index: true, middle: true, ring: true, pinky: true),
      assetSrc: 'assets/images/grips/open_hand_L.png');
  static final Grip openHandR = Grip(
      description: 'open hand',
      name: 'openHandR',
      hands: Hands.right,
      fingers: Fingers(index: true, middle: true, ring: true, pinky: true),
      assetSrc: 'assets/images/grips/open_hand_R.png');
  static final Grip halfCrimpL = Grip(
      description: 'half crimp',
      name: 'halfCrimpL',
      hands: Hands.left,
      fingers: Fingers(index: true, middle: true, ring: true, pinky: true),
      crimped: true,
      assetSrc: 'assets/images/grips/half_crimp_L.png');
  static final Grip halfCrimpR = Grip(
      description: 'half crimp',
      name: 'halfCrimpR',
      hands: Hands.right,
      fingers: Fingers(index: true, middle: true, ring: true, pinky: true),
      crimped: true,
      assetSrc: 'assets/images/grips/half_crimp_R.png');
  static final Grip fullCrimpL = Grip(
      description: 'full crimp',
      name: 'fullCrimpL',
      hands: Hands.left,
      fingers: Fingers(
          index: true, middle: true, ring: true, pinky: true, thumb: true),
      crimped: true,
      assetSrc: 'assets/images/grips/full_crimp_L.png');
  static final Grip fullCrimpR = Grip(
      description: 'full crimp',
      name: 'fullCrimpR',
      hands: Hands.right,
      fingers: Fingers(
          index: true, middle: true, ring: true, pinky: true, thumb: true),
      crimped: true,
      assetSrc: 'assets/images/grips/full_crimp_R.png');

  static final List<Grip> basicR = [
    Grips.openHandR,
    Grips.frontThreeR,
    Grips.backThreeR,
    Grips.frontTwoR,
    Grips.middleTwoR,
    Grips.backTwoR,
  ];

  static final List<Grip> basicL = [
    Grips.openHandL,
    Grips.frontThreeL,
    Grips.backThreeL,
    Grips.frontTwoL,
    Grips.middleTwoL,
    Grips.backTwoL,
  ];

  static final List<Grip> advancedL = [
    Grips.fullCrimpL,
    Grips.halfCrimpL,
    Grips.openHandL,
    Grips.frontThreeL,
    Grips.backThreeL,
    Grips.frontTwoL,
    Grips.middleTwoL,
    Grips.backTwoL,
    Grips.monoIndexL,
    Grips.monoMiddleL,
    Grips.monoRingL,
    Grips.monoPinkyL,
  ];

  static final List<Grip> advancedR = [
    Grips.fullCrimpR,
    Grips.halfCrimpR,
    Grips.openHandR,
    Grips.frontThreeR,
    Grips.backThreeR,
    Grips.frontTwoR,
    Grips.middleTwoR,
    Grips.backTwoR,
    Grips.monoIndexR,
    Grips.monoMiddleR,
    Grips.monoRingR,
    Grips.monoPinkyR,
  ];
}

enum Hands { left, right }

class Grip {
  Grip(
      {@required this.fingers,
      this.crimped = false,
      @required this.assetSrc,
      @required this.description,
      @required this.hands,
      this.name});

  final Fingers fingers;
  final bool crimped;
  final String assetSrc;
  final String name;
  final String description;
  final Hands hands;

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
