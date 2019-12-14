import 'package:app/models/fingers.dart';
import 'package:app/models/grip.dart';

class Grips {
  Grips._();

  static const Grip monoPinkyL = const Grip(
    description: 'mono pinky',
    name: 'monoPinkyL',
    fingers: const Fingers(pinky: true, count: 1),
    assetSrc: 'assets/images/grips/mono_pinky_L.png',
  );

  static const Grip monoPinkyR = const Grip(
    description: 'mono pinky',
    name: 'monoPinkyL',
    fingers: const Fingers(pinky: true, count: 1),
    assetSrc: 'assets/images/grips/mono_pinky_R.png',
  );

  static const Grip monoRingL = const Grip(
    description: 'mono ring finger',
    name: 'monoRingL',
    fingers: const Fingers(ring: true, count: 1),
    assetSrc: 'assets/images/grips/mono_ring_L.png',
  );
  static const Grip monoRingR = const Grip(
    description: 'mono ring finger',
    name: 'monoRingL',
    fingers: const Fingers(ring: true, count: 1),
    assetSrc: 'assets/images/grips/mono_ring_R.png',
  );

  static const Grip monoMiddleL = const Grip(
    description: 'mono middle finger',
    name: 'monoMiddleL',
    fingers: const Fingers(middle: true, count: 1),
    assetSrc: 'assets/images/grips/mono_middle_L.png',
  );
  static const Grip monoMiddleR = const Grip(
      description: 'mono middle finger',
      name: 'monoMiddleL',
      fingers: const Fingers(middle: true, count: 1),
      assetSrc: 'assets/images/grips/mono_middle_R.png');

  static const Grip monoIndexL = const Grip(
    description: 'mono index finger',
    name: 'monoIndexL',
    fingers: const Fingers(index: true, count: 1),
    assetSrc: 'assets/images/grips/mono_index_L.png',
  );

  static const Grip monoIndexR = const Grip(
      description: 'mono index finger',
      name: 'monoIndexL',
      fingers: const Fingers(index: true, count: 1),
      assetSrc: 'assets/images/grips/mono_index_R.png');

  static const Grip frontTwoL = const Grip(
    description: 'front two',
    name: 'frontTwoL',
    fingers: const Fingers(index: true, middle: true, count: 2),
    assetSrc: 'assets/images/grips/front_two_L.png',
  );

  static const Grip frontTwoR = const Grip(
      description: 'front two',
      name: 'frontTwoL',
      fingers: const Fingers(index: true, middle: true, count: 2),
      assetSrc: 'assets/images/grips/front_two_R.png');

  static const Grip middleTwoL = const Grip(
    description: 'middle two',
    name: 'middleTwoL',
    fingers: const Fingers(middle: true, ring: true, count: 2),
    assetSrc: 'assets/images/grips/middle_two_L.png',
  );
  static const Grip middleTwoR = const Grip(
      description: 'middle two',
      name: 'middleTwoL',
      fingers: const Fingers(middle: true, ring: true, count: 2),
      assetSrc: 'assets/images/grips/middle_two_R.png');

  static const Grip backTwoL = const Grip(
    description: 'back two',
    name: 'backTwoL',
    fingers: const Fingers(ring: true, pinky: true, count: 2),
    assetSrc: 'assets/images/grips/back_two_L.png',
  );
  static const Grip backTwoR = const Grip(
      description: 'back two',
      name: 'backTwoL',
      fingers: const Fingers(ring: true, pinky: true, count: 2),
      assetSrc: 'assets/images/grips/back_two_R.png');

  static const Grip frontThreeL = const Grip(
    description: 'front three',
    name: 'frontThreeL',
    fingers: const Fingers(index: true, middle: true, ring: true, count: 3),
    assetSrc: 'assets/images/grips/front_three_L.png',
  );
  static const Grip frontThreeR = const Grip(
      description: 'front three',
      name: 'frontThreeL',
      fingers: const Fingers(index: true, middle: true, ring: true, count: 3),
      assetSrc: 'assets/images/grips/front_three_R.png');

  static const Grip backThreeL = const Grip(
    description: 'back three',
    name: 'backThreeL',
    fingers: const Fingers(middle: true, ring: true, pinky: true, count: 3),
    assetSrc: 'assets/images/grips/back_three_L.png',
  );
  static const Grip backThreeR = const Grip(
      description: 'back three',
      name: 'backThreeL',
      fingers: const Fingers(middle: true, ring: true, pinky: true, count: 3),
      assetSrc: 'assets/images/grips/back_three_R.png');

  static const Grip openHandL = const Grip(
    description: 'open hand',
    name: 'openHandL',
    fingers: const Fingers(
        index: true, middle: true, ring: true, pinky: true, count: 4),
    assetSrc: 'assets/images/grips/open_hand_L.png',
  );
  static const Grip openHandR = const Grip(
    description: 'open hand',
    name: 'openHandL',
    fingers: const Fingers(
        index: true, middle: true, ring: true, pinky: true, count: 4),
    assetSrc: 'assets/images/grips/open_hand_R.png',
  );

  static const Grip halfCrimpL = const Grip(
    description: 'half crimp',
    name: 'halfCrimpL',
    fingers: const Fingers(
        index: true, middle: true, ring: true, pinky: true, count: 4),
    crimped: true,
    assetSrc: 'assets/images/grips/half_crimp_L.png',
  );
  static const Grip halfCrimpR = const Grip(
      description: 'half crimp',
      name: 'halfCrimpL',
      fingers: const Fingers(
          index: true, middle: true, ring: true, pinky: true, count: 4),
      crimped: true,
      assetSrc: 'assets/images/grips/half_crimp_R.png');

  static const Grip fullCrimpL = const Grip(
    description: 'full crimp',
    name: 'fullCrimpL',
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
      description: 'full crimp',
      name: 'fullCrimpL',
      fingers: const Fingers(
          index: true,
          middle: true,
          ring: true,
          pinky: true,
          thumb: true,
          count: 5),
      crimped: true,
      assetSrc: 'assets/images/grips/full_crimp_R.png');

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