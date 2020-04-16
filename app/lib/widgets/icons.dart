library icons;

import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/icon.dart';

const editIconWhiteXl = Icon(
    iconData: IconData(0xf417,
        fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
    size: styles.IconMeasurements.xl,
    color: styles.Colors.white);

const backIconBlack = Icon(
  iconData: CupertinoIcons.back,
  color: styles.Colors.black,
);

const backIconWhite = Icon(
  iconData: CupertinoIcons.back,
  color: styles.Colors.white,
);

const settingsIconBlackL = Icon(
    size: styles.IconMeasurements.l,
    iconData: IconData(0xf43d,
        fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
    color: styles.Colors.black);

const forwardIconBlackXl = Icon(
    iconData: CupertinoIcons.forward,
    size: styles.IconMeasurements.xl,
    color: styles.Colors.black);

const chartIconBlackS = Icon(
    size: styles.IconMeasurements.s,
    iconData: IconData(0xf484,
        fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
    color: styles.Colors.black);

const calendarIconBlackM = Icon(
    size: styles.IconMeasurements.m,
    iconData: IconData(0xf2d1,
        fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
    color: styles.Colors.black);

const editIconBlackS = Icon(
    size: styles.IconMeasurements.s,
    iconData: IconData(0xf2bf,
        fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
    color: styles.Colors.black);

const playIconBlackXl = Icon(
    iconData: IconData(0xf488,
        fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
    size: styles.IconMeasurements.xl,
    color: styles.Colors.black);

const plusIconWhiteXl = Icon(
    iconData: IconData(0xf489,
        fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
    size: styles.IconMeasurements.xl,
    color: styles.Colors.white);

const stopIconWhiteXl = Icon(
    iconData: IconData(0xf371,
        fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
    size: styles.IconMeasurements.xl,
    color: styles.Colors.white);

const downCaretBlack = Icon(
  iconData: IconData(0xf3d0,
      fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
  color: styles.Colors.black,
);

const downCaretBlackL = Icon(
  size: styles.IconMeasurements.l,
  iconData: IconData(0xf3d0,
      fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
  color: styles.Colors.black,
);

const playIconWhiteL = Icon(
    iconData: IconData(0xf488,
        fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
    size: styles.IconMeasurements.l,
    color: styles.Colors.white);

const infoIconBlackL = Icon(
  size: styles.IconMeasurements.l,
  iconData: IconData(0xf44c,
      fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
  color: styles.Colors.black,
);

const searchIconWhiteXl = Icon(
  size: styles.IconMeasurements.xl,
  iconData: IconData(0xf4a4,
      fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
  color: styles.Colors.white,
);

const copyIconWhiteXl = Icon(
  size: styles.IconMeasurements.xl,
  iconData: IconData(0xf220,
      fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
  color: styles.Colors.white,
);

const deleteIconWhiteXl = Icon(
  size: styles.IconMeasurements.xl,
  iconData: IconData(0xf4c4,
      fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
  color: styles.Colors.white,
);

Icon getRightChevronIconXl(Color color) => Icon(
    iconData: IconData(0xf3d1,
        fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
    size: styles.IconMeasurements.xl,
    color: color);

Icon getLeftChevronIconXl(Color color) => Icon(
    iconData: IconData(0xf3cf,
        fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
    size: styles.IconMeasurements.xl,
    color: color);
