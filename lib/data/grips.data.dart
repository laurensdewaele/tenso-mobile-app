import 'package:tenso_app/models/models.dart';

abstract class Grips {
  static Grip chiselL = Grip((b) => b
    ..crimped = true
    ..description = 'open crimp (chisel)'
    ..name = 'chiselL'
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = true
      ..middle = true
      ..ring = true
      ..pinky = true
      ..count = 4).toBuilder()
    ..imageAsset = 'assets/images/grips/chisel_L.png'
    ..handType = HandType.leftHand
    ..anchorX = 145
    ..anchorY = 35
    ..imageAssetWidth = 224
    ..imageAssetHeight = 320);

  static Grip chiselR = Grip((b) => b
    ..crimped = true
    ..description = 'open crimp (chisel)'
    ..name = 'chiselR'
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = true
      ..middle = true
      ..ring = true
      ..pinky = true
      ..count = 4).toBuilder()
    ..imageAsset = 'assets/images/grips/chisel_R.png'
    ..handType = HandType.rightHand
    ..anchorX = 84
    ..anchorY = 35
    ..imageAssetWidth = 224
    ..imageAssetHeight = 320);

  static Grip pinchL = Grip((b) => b
    ..crimped = false
    ..description = 'pinch'
    ..name = 'pinchL'
    ..fingers = Fingers((b) => b
      ..thumb = true
      ..index = true
      ..middle = true
      ..ring = true
      ..pinky = true
      ..count = 5).toBuilder()
    ..imageAsset = 'assets/images/grips/pinch_L.png'
    ..handType = HandType.leftHand
    ..anchorX = 165
    ..anchorY = 41
    ..imageAssetWidth = 244
    ..imageAssetHeight = 270);

  static Grip pinchR = Grip((b) => b
    ..crimped = false
    ..description = 'pinch'
    ..name = 'pinchR'
    ..fingers = Fingers((b) => b
      ..thumb = true
      ..index = true
      ..middle = true
      ..ring = true
      ..pinky = true
      ..count = 5).toBuilder()
    ..imageAsset = 'assets/images/grips/pinch_R.png'
    ..handType = HandType.rightHand
    ..anchorX = 90
    ..anchorY = 41
    ..imageAssetWidth = 244
    ..imageAssetHeight = 270);

  static Grip monoPinkyL = Grip((b) => b
    ..crimped = false
    ..description = 'mono pinky'
    ..name = 'monoPinkyL'
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = false
      ..ring = false
      ..pinky = true
      ..count = 1).toBuilder()
    ..imageAsset = 'assets/images/grips/mono_pinky_L.png'
    ..handType = HandType.leftHand
    ..anchorX = 45.0 - 20
    ..anchorY = 33.0 - 26
    ..imageAssetWidth = 234 / (330 / 120)
    ..imageAssetHeight = 120);

  static Grip monoPinkyR = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 234 / (330 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 + 14.0
    ..anchorY = 33.0 - 26.0
    ..description = 'mono pinky'
    ..name = 'monoPinkyR'
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = false
      ..ring = false
      ..pinky = true
      ..count = 1).toBuilder()
    ..imageAsset = 'assets/images/grips/mono_pinky_R.png'
    ..handType = HandType.rightHand);

  static Grip monoRingL = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 336 / (219 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 16.0
    ..anchorY = 33.0 - 27.0
    ..description = 'mono ring finger'
    ..name = 'monoRingL'
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = false
      ..ring = true
      ..pinky = false
      ..count = 1).toBuilder()
    ..imageAsset = 'assets/images/grips/mono_ring_L.png'
    ..handType = HandType.leftHand);

  static Grip monoRingR = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 219 / (336 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 + 4.0
    ..anchorY = 33.0 - 27.0
    ..description = 'mono ring finger'
    ..name = 'monoRingR'
    ..handType = HandType.rightHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = false
      ..ring = true
      ..pinky = false
      ..count = 1).toBuilder()
    ..imageAsset = 'assets/images/grips/mono_ring_R.png');

  static Grip monoMiddleL = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 211 / (369 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 11
    ..anchorY = 33.0 - 27
    ..description = 'mono middle finger'
    ..name = 'monoMiddleL'
    ..handType = HandType.leftHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = true
      ..ring = false
      ..pinky = false
      ..count = 1).toBuilder()
    ..imageAsset = 'assets/images/grips/mono_middle_L.png');

  static Grip monoMiddleR = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 211 / (369 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 11
    ..anchorY = 33.0 - 27
    ..description = 'mono middle finger'
    ..name = 'monoMiddleR'
    ..handType = HandType.rightHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = true
      ..ring = false
      ..pinky = false
      ..count = 1).toBuilder()
    ..imageAsset = 'assets/images/grips/mono_middle_R.png');

  static Grip monoIndexL = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 176 / (317 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 1
    ..anchorY = 33.0 - 25
    ..description = 'mono index finger'
    ..name = 'monoIndexL'
    ..handType = HandType.leftHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = true
      ..middle = false
      ..ring = false
      ..pinky = false
      ..count = 1).toBuilder()
    ..imageAsset = 'assets/images/grips/mono_index_L.png');

  static Grip monoIndexR = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 176 / (317 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 23
    ..anchorY = 33.0 - 25
    ..description = 'mono index finger'
    ..name = 'monoIndexR'
    ..handType = HandType.rightHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = true
      ..middle = false
      ..ring = false
      ..pinky = false
      ..count = 1).toBuilder()
    ..imageAsset = 'assets/images/grips/mono_index_R.png');

  static Grip frontTwoL = Grip(
    (b) => b
      ..crimped = false
      ..imageAssetWidth = 210 / (300 / 120)
      ..imageAssetHeight = 120
      ..anchorX = 45.0 - 3
      ..anchorY = 33.0 - 27
      ..description = 'front two'
      ..name = 'frontTwoL'
      ..handType = HandType.leftHand
      ..fingers = Fingers((b) => b
        ..thumb = false
        ..index = true
        ..middle = true
        ..ring = false
        ..pinky = false
        ..count = 2).toBuilder()
      ..imageAsset = 'assets/images/grips/front_two_L.png',
  );

  static Grip frontTwoR = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 210 / (300 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 3
    ..anchorY = 33.0 - 27
    ..description = 'front two'
    ..name = 'frontTwoR'
    ..handType = HandType.rightHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = true
      ..middle = true
      ..ring = false
      ..pinky = false
      ..count = 2).toBuilder()
    ..imageAsset = 'assets/images/grips/front_two_R.png');

  static Grip middleTwoL = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 236 / (332 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 11
    ..anchorY = 33.0 - 21
    ..description = 'middle two'
    ..name = 'middleTwoL'
    ..handType = HandType.leftHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = true
      ..ring = true
      ..pinky = false
      ..count = 2).toBuilder()
    ..imageAsset = 'assets/images/grips/middle_two_L.png');

  static Grip middleTwoR = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 236 / (332 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 + 8
    ..anchorY = 33.0 - 21
    ..description = 'middle two'
    ..name = 'middleTwoR'
    ..handType = HandType.rightHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = true
      ..ring = true
      ..pinky = false
      ..count = 2).toBuilder()
    ..imageAsset = 'assets/images/grips/middle_two_R.png');

  static Grip backTwoL = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 219 / (322 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 25
    ..anchorY = 33.0 - 25
    ..description = 'back two'
    ..name = 'backTwoL'
    ..handType = HandType.leftHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = false
      ..ring = true
      ..pinky = true
      ..count = 2).toBuilder()
    ..imageAsset = 'assets/images/grips/back_two_L.png');

  static Grip backTwoR = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 219 / (332 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 + 17.0
    ..anchorY = 33.0 - 25
    ..description = 'back two'
    ..name = 'backTwoR'
    ..handType = HandType.rightHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = false
      ..ring = true
      ..pinky = true
      ..count = 2).toBuilder()
    ..imageAsset = 'assets/images/grips/back_two_R.png');

  static Grip frontThreeL = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 177 / (297 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 9.0
    ..anchorY = 33.0 - 24.0
    ..description = 'front three'
    ..name = 'frontThreeL'
    ..handType = HandType.leftHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = true
      ..middle = true
      ..ring = true
      ..pinky = false
      ..count = 3).toBuilder()
    ..imageAsset = 'assets/images/grips/front_three_L.png');

  static Grip frontThreeR = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 177 / (297 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 9
    ..anchorY = 33.0 - 24.0
    ..description = 'front three'
    ..name = 'frontThreeR'
    ..handType = HandType.rightHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = true
      ..middle = true
      ..ring = true
      ..pinky = false
      ..count = 3).toBuilder()
    ..imageAsset = 'assets/images/grips/front_three_R.png');

  static Grip backThreeL = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 241 / (292 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 5
    ..anchorY = 33.0 - 20
    ..description = 'back three'
    ..name = 'backThreeL'
    ..handType = HandType.leftHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = true
      ..ring = true
      ..pinky = true
      ..count = 3).toBuilder()
    ..imageAsset = 'assets/images/grips/back_three_L.png');

  static Grip backThreeR = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 241 / (292 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 + 18.0
    ..anchorY = 33.0 - 20.0
    ..description = 'back three'
    ..name = 'backThreeR'
    ..handType = HandType.rightHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = false
      ..middle = true
      ..ring = true
      ..pinky = true
      ..count = 3).toBuilder()
    ..imageAsset = 'assets/images/grips/back_three_R.png');

  static Grip openHandL = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 238 / (316 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 39.5
    ..anchorY = 10
    ..description = 'open hand'
    ..name = 'openHandL'
    ..handType = HandType.leftHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = true
      ..middle = true
      ..ring = true
      ..pinky = true
      ..count = 4).toBuilder()
    ..imageAsset = 'assets/images/grips/open_hand_L.png');

  static Grip openHandR = Grip((b) => b
    ..crimped = false
    ..imageAssetWidth = 238 / (316 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 51
    ..anchorY = 10
    ..description = 'open hand'
    ..name = 'openHandR'
    ..handType = HandType.rightHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = true
      ..middle = true
      ..ring = true
      ..pinky = true
      ..count = 4).toBuilder()
    ..imageAsset = 'assets/images/grips/open_hand_R.png');

  static Grip halfCrimpL = Grip((b) => b
    ..imageAssetWidth = 274 / (318 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0
    ..anchorY = 33.0 - 10
    ..description = 'half crimp'
    ..name = 'halfCrimpL'
    ..handType = HandType.leftHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = true
      ..middle = true
      ..ring = true
      ..pinky = true
      ..count = 4).toBuilder()
    ..crimped = true
    ..imageAsset = 'assets/images/grips/half_crimp_L.png');

  static Grip halfCrimpR = Grip((b) => b
    ..imageAssetWidth = 274 / (318 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 + 16.0
    ..anchorY = 33.0 - 10.0
    ..description = 'half crimp'
    ..name = 'halfCrimpR'
    ..handType = HandType.rightHand
    ..fingers = Fingers((b) => b
      ..thumb = false
      ..index = true
      ..middle = true
      ..ring = true
      ..pinky = true
      ..count = 4).toBuilder()
    ..crimped = true
    ..imageAsset = 'assets/images/grips/half_crimp_R.png');

  static Grip fullCrimpL = Grip(
    (b) => b
      ..imageAssetWidth = 177 / (282 / 120)
      ..imageAssetHeight = 120
      ..anchorX = 45.0 - 6
      ..anchorY = 33.0 - 7
      ..description = 'full crimp'
      ..name = 'fullCrimpL'
      ..handType = HandType.leftHand
      ..fingers = Fingers((b) => b
        ..thumb = true
        ..index = true
        ..middle = true
        ..ring = true
        ..pinky = true
        ..count = 5).toBuilder()
      ..crimped = true
      ..imageAsset = 'assets/images/grips/full_crimp_L.png',
  );
  static Grip fullCrimpR = Grip((b) => b
    ..imageAssetWidth = 177 / (282 / 120)
    ..imageAssetHeight = 120
    ..anchorX = 45.0 - 6
    ..anchorY = 33.0 - 7
    ..description = 'full crimp'
    ..name = 'fullCrimpR'
    ..handType = HandType.rightHand
    ..fingers = Fingers((b) => b
      ..thumb = true
      ..index = true
      ..middle = true
      ..ring = true
      ..pinky = true
      ..count = 5).toBuilder()
    ..crimped = true
    ..imageAsset = 'assets/images/grips/full_crimp_R.png');

  static List<Grip> left = [
    Grips.pinchL,
    Grips.fullCrimpL,
    Grips.halfCrimpL,
    Grips.chiselL,
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
  static List<Grip> right = [
    Grips.pinchR,
    Grips.fullCrimpR,
    Grips.halfCrimpR,
    Grips.chiselR,
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

  static final Map<int, Grip> _standardGripsL = {
    5: Grips.openHandL,
    4: Grips.openHandL,
    3: Grips.frontThreeL,
    2: Grips.frontTwoL,
    1: Grips.monoIndexL
  };
  static final Map<int, Grip> _standardGripsR = {
    5: Grips.openHandR,
    4: Grips.openHandR,
    3: Grips.frontThreeR,
    2: Grips.frontTwoR,
    1: Grips.monoIndexR
  };

  static Grip matchSupportedFingersL(int supportedFingers) {
    if (supportedFingers == null) {
      return _standardGripsL[5];
    } else {
      return _standardGripsL[supportedFingers];
    }
  }

  static Grip matchSupportedFingersR(int supportedFingers) {
    if (supportedFingers == null) {
      return _standardGripsR[5];
    } else {
      return _standardGripsR[supportedFingers];
    }
  }
}
