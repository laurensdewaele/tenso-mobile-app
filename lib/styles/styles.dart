library styles;

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/colors.dart';
import 'package:tenso_app/styles/measurements.dart';

export 'package:tenso_app/styles/colors.dart';
export 'package:tenso_app/styles/measurements.dart';
export 'package:tenso_app/styles/typography.dart';

const double kStandardButtonHeight = 55;
const double kSmallButtonHeight = 40;
const double kLandscapeDialogWidth = 450;
const double kSmallDialogWidth = Measurements.xxl * 6;
const double kBorderRadiusValue = 5.0;
const Radius kBorderRadius = Radius.circular(kBorderRadiusValue);
const BorderRadius kBorderRadiusAll =
    BorderRadius.all(Radius.circular(kBorderRadiusValue));
const Offset kShadowOffset = Offset(0, 4);
const double kShadowBlurRadius = 4.0;
const BoxShadow kBoxShadow = BoxShadow(
    color: Colors.shadow, offset: kShadowOffset, blurRadius: kShadowBlurRadius);

const double kDialogBackdropBlurAmount = 20.0;
const BoxDecoration kDialogBlurOverlayDecoration = BoxDecoration(
  color: Colors.bgWhite,
  backgroundBlendMode: BlendMode.overlay,
);
