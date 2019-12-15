import 'package:app/models/fingers.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_types.dart';

class Grips {
  Grips._();

  static const Grip monoPinkyL = const Grip(
      description: 'mono pinky',
      name: 'monoPinkyL',
      fingers: const Fingers(pinky: true, count: 1),
      assetSrc: 'assets/images/grips/mono_pinky_L.png',
      dyRelativeHangAnchorPoint: 21 / 330,
      handType: HandTypes.leftHand);

  static const Grip monoPinkyR = const Grip(
      description: 'mono pinky',
      name: 'monoPinkyL',
      fingers: const Fingers(pinky: true, count: 1),
      assetSrc: 'assets/images/grips/mono_pinky_R.png',
      dyRelativeHangAnchorPoint: 21 / 330,
      handType: HandTypes.rightHand);

  static const Grip monoRingL = const Grip(
      description: 'mono ring finger',
      name: 'monoRingL',
      fingers: const Fingers(ring: true, count: 1),
      assetSrc: 'assets/images/grips/mono_ring_L.png',
      handType: HandTypes.leftHand,
      dyRelativeHangAnchorPoint: 22 / 336);
  static const Grip monoRingR = const Grip(
      description: 'mono ring finger',
      name: 'monoRingL',
      handType: HandTypes.rightHand,
      fingers: const Fingers(ring: true, count: 1),
      assetSrc: 'assets/images/grips/mono_ring_R.png',
      dyRelativeHangAnchorPoint: 22 / 336);

  static const Grip monoMiddleL = const Grip(
      description: 'mono middle finger',
      name: 'monoMiddleL',
      handType: HandTypes.leftHand,
      fingers: const Fingers(middle: true, count: 1),
      assetSrc: 'assets/images/grips/mono_middle_L.png',
      dyRelativeHangAnchorPoint: 25 / 369);
  static const Grip monoMiddleR = const Grip(
      description: 'mono middle finger',
      name: 'monoMiddleL',
      handType: HandTypes.rightHand,
      fingers: const Fingers(middle: true, count: 1),
      assetSrc: 'assets/images/grips/mono_middle_R.png',
      dyRelativeHangAnchorPoint: 25 / 369);

  static const Grip monoIndexL = const Grip(
      description: 'mono index finger',
      name: 'monoIndexL',
      handType: HandTypes.leftHand,
      fingers: const Fingers(index: true, count: 1),
      assetSrc: 'assets/images/grips/mono_index_L.png',
      dyRelativeHangAnchorPoint: 23 / 317);

  static const Grip monoIndexR = const Grip(
      description: 'mono index finger',
      name: 'monoIndexL',
      handType: HandTypes.rightHand,
      fingers: const Fingers(index: true, count: 1),
      assetSrc: 'assets/images/grips/mono_index_R.png',
      dyRelativeHangAnchorPoint: 23 / 317);

  static const Grip frontTwoL = const Grip(
      description: 'front two',
      name: 'frontTwoL',
      handType: HandTypes.leftHand,
      fingers: const Fingers(index: true, middle: true, count: 2),
      assetSrc: 'assets/images/grips/front_two_L.png',
      dyRelativeHangAnchorPoint: 20 / 300);

  static const Grip frontTwoR = const Grip(
      description: 'front two',
      name: 'frontTwoL',
      handType: HandTypes.rightHand,
      fingers: const Fingers(index: true, middle: true, count: 2),
      assetSrc: 'assets/images/grips/front_two_R.png',
      dyRelativeHangAnchorPoint: 20 / 300);

  static const Grip middleTwoL = const Grip(
      description: 'middle two',
      name: 'middleTwoL',
      handType: HandTypes.leftHand,
      fingers: const Fingers(middle: true, ring: true, count: 2),
      assetSrc: 'assets/images/grips/middle_two_L.png',
      dyRelativeHangAnchorPoint: 45 / 332);
  static const Grip middleTwoR = const Grip(
      description: 'middle two',
      name: 'middleTwoL',
      handType: HandTypes.rightHand,
      fingers: const Fingers(middle: true, ring: true, count: 2),
      assetSrc: 'assets/images/grips/middle_two_R.png',
      dyRelativeHangAnchorPoint: 45 / 332);

  static const Grip backTwoL = const Grip(
      description: 'back two',
      name: 'backTwoL',
      handType: HandTypes.leftHand,
      fingers: const Fingers(ring: true, pinky: true, count: 2),
      assetSrc: 'assets/images/grips/back_two_L.png',
      dyRelativeHangAnchorPoint: 28 / 332);

  static const Grip backTwoR = const Grip(
      description: 'back two',
      name: 'backTwoL',
      handType: HandTypes.rightHand,
      fingers: const Fingers(ring: true, pinky: true, count: 2),
      assetSrc: 'assets/images/grips/back_two_R.png',
      dyRelativeHangAnchorPoint: 28 / 332);

  static const Grip frontThreeL = const Grip(
      description: 'front three',
      name: 'frontThreeL',
      handType: HandTypes.leftHand,
      fingers: const Fingers(index: true, middle: true, ring: true, count: 3),
      assetSrc: 'assets/images/grips/front_three_L.png',
      dyRelativeHangAnchorPoint: 30 / 297);
  static const Grip frontThreeR = const Grip(
      description: 'front three',
      name: 'frontThreeL',
      handType: HandTypes.rightHand,
      fingers: const Fingers(index: true, middle: true, ring: true, count: 3),
      assetSrc: 'assets/images/grips/front_three_R.png',
      dyRelativeHangAnchorPoint: 30 / 297);

  static const Grip backThreeL = const Grip(
      description: 'back three',
      name: 'backThreeL',
      handType: HandTypes.leftHand,
      fingers: const Fingers(middle: true, ring: true, pinky: true, count: 3),
      assetSrc: 'assets/images/grips/back_three_L.png',
      dyRelativeHangAnchorPoint: 30 / 292);
  static const Grip backThreeR = const Grip(
      description: 'back three',
      name: 'backThreeL',
      handType: HandTypes.rightHand,
      fingers: const Fingers(middle: true, ring: true, pinky: true, count: 3),
      assetSrc: 'assets/images/grips/back_three_R.png',
      dyRelativeHangAnchorPoint: 30 / 292);

  static const Grip openHandL = const Grip(
      description: 'open hand',
      name: 'openHandL',
      handType: HandTypes.leftHand,
      fingers: const Fingers(
          index: true, middle: true, ring: true, pinky: true, count: 4),
      assetSrc: 'assets/images/grips/open_hand_L.png',
      dyRelativeHangAnchorPoint: 26 / 316);
  static const Grip openHandR = const Grip(
      description: 'open hand',
      name: 'openHandL',
      handType: HandTypes.rightHand,
      fingers: const Fingers(
          index: true, middle: true, ring: true, pinky: true, count: 4),
      assetSrc: 'assets/images/grips/open_hand_R.png',
      dyRelativeHangAnchorPoint: 26 / 316);

  static const Grip halfCrimpL = const Grip(
      description: 'half crimp',
      name: 'halfCrimpL',
      handType: HandTypes.leftHand,
      fingers: const Fingers(
          index: true, middle: true, ring: true, pinky: true, count: 4),
      crimped: true,
      assetSrc: 'assets/images/grips/half_crimp_L.png',
      dyRelativeHangAnchorPoint: 58 / 318);
  static const Grip halfCrimpR = const Grip(
      description: 'half crimp',
      name: 'halfCrimpL',
      handType: HandTypes.rightHand,
      fingers: const Fingers(
          index: true, middle: true, ring: true, pinky: true, count: 4),
      crimped: true,
      assetSrc: 'assets/images/grips/half_crimp_R.png',
      dyRelativeHangAnchorPoint: 58 / 318);

  static const Grip fullCrimpL = const Grip(
      description: 'full crimp',
      name: 'fullCrimpL',
      handType: HandTypes.leftHand,
      fingers: const Fingers(
          index: true,
          middle: true,
          ring: true,
          pinky: true,
          thumb: true,
          count: 5),
      crimped: true,
      assetSrc: 'assets/images/grips/full_crimp_L.png',
      dyRelativeHangAnchorPoint: 65 / 282);
  static const Grip fullCrimpR = const Grip(
      description: 'full crimp',
      name: 'fullCrimpL',
      handType: HandTypes.rightHand,
      fingers: const Fingers(
          index: true,
          middle: true,
          ring: true,
          pinky: true,
          thumb: true,
          count: 5),
      crimped: true,
      assetSrc: 'assets/images/grips/full_crimp_R.png',
      dyRelativeHangAnchorPoint: 65 / 282);

  static const List<Grip> basicL = [
    Grips.openHandL,
    Grips.frontThreeL,
    Grips.backThreeL,
    Grips.frontTwoL,
    Grips.middleTwoL,
    Grips.backTwoL,
  ];
  static const List<Grip> basicR = [
    Grips.openHandR,
    Grips.frontThreeR,
    Grips.backThreeR,
    Grips.frontTwoR,
    Grips.middleTwoR,
    Grips.backTwoR,
  ];

  static const List<Grip> advancedL = [
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
  static const List<Grip> advancedR = [
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
