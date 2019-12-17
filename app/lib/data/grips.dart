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
    handType: HandTypes.leftHand,
    dxHangAnchor: 45.0 - 20,
    dyHangAnchor: 33.0 - 26,
    assetWidth: 234,
    assetHeight: 330,
  );

  static const Grip monoPinkyR = const Grip(
      assetWidth: 234,
      assetHeight: 330,
      dxHangAnchor: 45.0 + 14.0,
      dyHangAnchor: 33.0 - 26.0,
      description: 'mono pinky',
      name: 'monoPinkyL',
      fingers: const Fingers(pinky: true, count: 1),
      assetSrc: 'assets/images/grips/mono_pinky_R.png',
      handType: HandTypes.rightHand);

  static const Grip monoRingL = const Grip(
    assetHeight: 219,
    assetWidth: 336,
    dxHangAnchor: 45.0 - 16.0,
    dyHangAnchor: 33.0 - 27.0,
    description: 'mono ring finger',
    name: 'monoRingL',
    fingers: const Fingers(ring: true, count: 1),
    assetSrc: 'assets/images/grips/mono_ring_L.png',
    handType: HandTypes.leftHand,
  );

  static const Grip monoRingR = const Grip(
    assetWidth: 219,
    assetHeight: 336,
    dxHangAnchor: 45.0 + 4.0,
    dyHangAnchor: 33.0 - 27.0,
    description: 'mono ring finger',
    name: 'monoRingL',
    handType: HandTypes.rightHand,
    fingers: const Fingers(ring: true, count: 1),
    assetSrc: 'assets/images/grips/mono_ring_R.png',
  );

  static const Grip monoMiddleL = const Grip(
    assetWidth: 211,
    assetHeight: 369,
    dxHangAnchor: 45.0 - 11,
    dyHangAnchor: 33.0 - 27,
    description: 'mono middle finger',
    name: 'monoMiddleL',
    handType: HandTypes.leftHand,
    fingers: const Fingers(middle: true, count: 1),
    assetSrc: 'assets/images/grips/mono_middle_L.png',
  );

  static const Grip monoMiddleR = const Grip(
    assetWidth: 211,
    assetHeight: 369,
    dxHangAnchor: 45.0 - 11,
    dyHangAnchor: 33.0 - 27,
    description: 'mono middle finger',
    name: 'monoMiddleL',
    handType: HandTypes.rightHand,
    fingers: const Fingers(middle: true, count: 1),
    assetSrc: 'assets/images/grips/mono_middle_R.png',
  );

  static const Grip monoIndexL = const Grip(
    assetWidth: 176,
    assetHeight: 317,
    dxHangAnchor: 45.0 - 1,
    dyHangAnchor: 33.0 - 25,
    description: 'mono index finger',
    name: 'monoIndexL',
    handType: HandTypes.leftHand,
    fingers: const Fingers(index: true, count: 1),
    assetSrc: 'assets/images/grips/mono_index_L.png',
  );

  static const Grip monoIndexR = const Grip(
    assetWidth: 176,
    assetHeight: 317,
    dxHangAnchor: 45.0 - 23,
    dyHangAnchor: 33.0 - 25,
    description: 'mono index finger',
    name: 'monoIndexL',
    handType: HandTypes.rightHand,
    fingers: const Fingers(index: true, count: 1),
    assetSrc: 'assets/images/grips/mono_index_R.png',
  );

  static const Grip frontTwoL = const Grip(
    assetWidth: 210,
    assetHeight: 300,
    dxHangAnchor: 45.0 - 3,
    dyHangAnchor: 33.0 - 27,
    description: 'front two',
    name: 'frontTwoL',
    handType: HandTypes.leftHand,
    fingers: const Fingers(index: true, middle: true, count: 2),
    assetSrc: 'assets/images/grips/front_two_L.png',
  );

  static const Grip frontTwoR = const Grip(
    assetWidth: 210,
    assetHeight: 300,
    dxHangAnchor: 45.0 - 3,
    dyHangAnchor: 33.0 - 27,
    description: 'front two',
    name: 'frontTwoL',
    handType: HandTypes.rightHand,
    fingers: const Fingers(index: true, middle: true, count: 2),
    assetSrc: 'assets/images/grips/front_two_R.png',
  );

  static const Grip middleTwoL = const Grip(
    assetWidth: 236,
    assetHeight: 332,
    dxHangAnchor: 45.0 - 11,
    dyHangAnchor: 33.0 - 21,
    description: 'middle two',
    name: 'middleTwoL',
    handType: HandTypes.leftHand,
    fingers: const Fingers(middle: true, ring: true, count: 2),
    assetSrc: 'assets/images/grips/middle_two_L.png',
  );
  static const Grip middleTwoR = const Grip(
    assetWidth: 236,
    assetHeight: 332,
    dxHangAnchor: 45.0 + 8,
    dyHangAnchor: 33.0 - 21,
    description: 'middle two',
    name: 'middleTwoL',
    handType: HandTypes.rightHand,
    fingers: const Fingers(middle: true, ring: true, count: 2),
    assetSrc: 'assets/images/grips/middle_two_R.png',
  );

  static const Grip backTwoL = const Grip(
    assetWidth: 219,
    assetHeight: 322,
    dxHangAnchor: 45.0 - 25,
    dyHangAnchor: 33.0 - 25,
    description: 'back two',
    name: 'backTwoL',
    handType: HandTypes.leftHand,
    fingers: const Fingers(ring: true, pinky: true, count: 2),
    assetSrc: 'assets/images/grips/back_two_L.png',
  );

  static const Grip backTwoR = const Grip(
    assetWidth: 219,
    assetHeight: 322,
    dxHangAnchor: 45.0 + 17.0,
    dyHangAnchor: 33.0 - 25,
    description: 'back two',
    name: 'backTwoL',
    handType: HandTypes.rightHand,
    fingers: const Fingers(ring: true, pinky: true, count: 2),
    assetSrc: 'assets/images/grips/back_two_R.png',
  );

  static const Grip frontThreeL = const Grip(
    assetWidth: 177,
    assetHeight: 297,
    dxHangAnchor: 45.0 - 9.0,
    dyHangAnchor: 33.0 - 24.0,
    description: 'front three',
    name: 'frontThreeL',
    handType: HandTypes.leftHand,
    fingers: const Fingers(index: true, middle: true, ring: true, count: 3),
    assetSrc: 'assets/images/grips/front_three_L.png',
  );
  static const Grip frontThreeR = const Grip(
    assetWidth: 177,
    assetHeight: 297,
    dxHangAnchor: 45.0 - 9,
    dyHangAnchor: 33.0 - 24.0,
    description: 'front three',
    name: 'frontThreeL',
    handType: HandTypes.rightHand,
    fingers: const Fingers(index: true, middle: true, ring: true, count: 3),
    assetSrc: 'assets/images/grips/front_three_R.png',
  );

  static const Grip backThreeL = const Grip(
    assetWidth: 241,
    assetHeight: 292,
    dxHangAnchor: 45.0 - 5,
    dyHangAnchor: 33.0 - 20,
    description: 'back three',
    name: 'backThreeL',
    handType: HandTypes.leftHand,
    fingers: const Fingers(middle: true, ring: true, pinky: true, count: 3),
    assetSrc: 'assets/images/grips/back_three_L.png',
  );
  static const Grip backThreeR = const Grip(
    assetWidth: 241,
    assetHeight: 292,
    dxHangAnchor: 45.0 + 18.0,
    dyHangAnchor: 33.0 - 20.0,
    description: 'back three',
    name: 'backThreeL',
    handType: HandTypes.rightHand,
    fingers: const Fingers(middle: true, ring: true, pinky: true, count: 3),
    assetSrc: 'assets/images/grips/back_three_R.png',
  );

  static const Grip openHandL = const Grip(
    assetWidth: 238,
    assetHeight: 316,
    dxHangAnchor: 39.5,
    dyHangAnchor: 10,
    description: 'open hand',
    name: 'openHandL',
    handType: HandTypes.leftHand,
    fingers: const Fingers(
        index: true, middle: true, ring: true, pinky: true, count: 4),
    assetSrc: 'assets/images/grips/open_hand_L.png',
  );
  static const Grip openHandR = const Grip(
    assetWidth: 238,
    assetHeight: 316,
    dxHangAnchor: 51,
    dyHangAnchor: 10,
    description: 'open hand',
    name: 'openHandL',
    handType: HandTypes.rightHand,
    fingers: const Fingers(
        index: true, middle: true, ring: true, pinky: true, count: 4),
    assetSrc: 'assets/images/grips/open_hand_R.png',
  );

  static const Grip halfCrimpL = const Grip(
    assetWidth: 274,
    assetHeight: 318,
    dxHangAnchor: 45.0,
    dyHangAnchor: 33.0 - 10,
    description: 'half crimp',
    name: 'halfCrimpL',
    handType: HandTypes.leftHand,
    fingers: const Fingers(
        index: true, middle: true, ring: true, pinky: true, count: 4),
    crimped: true,
    assetSrc: 'assets/images/grips/half_crimp_L.png',
  );

  static const Grip halfCrimpR = const Grip(
    assetWidth: 274,
    assetHeight: 318,
    dxHangAnchor: 45.0 + 16.0,
    dyHangAnchor: 33.0 - 10.0,
    description: 'half crimp',
    name: 'halfCrimpL',
    handType: HandTypes.rightHand,
    fingers: const Fingers(
        index: true, middle: true, ring: true, pinky: true, count: 4),
    crimped: true,
    assetSrc: 'assets/images/grips/half_crimp_R.png',
  );

  static const Grip fullCrimpL = const Grip(
    assetWidth: 177,
    assetHeight: 282,
    dxHangAnchor: 45.0 - 6,
    dyHangAnchor: 33.0 - 7,
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
  );
  static const Grip fullCrimpR = const Grip(
    assetWidth: 177,
    assetHeight: 282,
    dxHangAnchor: 45.0 - 6,
    dyHangAnchor: 33.0 - 7,
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
  );

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
