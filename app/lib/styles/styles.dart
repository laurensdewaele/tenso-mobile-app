library styles;

import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class Colors {
  Colors._();

  static const Color primary = const Color.fromRGBO(220, 88, 88, 1);
  static const Color white = const Color.fromRGBO(255, 255, 255, 1);
  static const Color gray = const Color.fromRGBO(0, 0, 0, 0.6);
  static const Color black = const Color.fromRGBO(0, 0, 0, .75);
  static const Color shadow = const Color.fromRGBO(0, 0, 0, 0.05);
  static const Color bgWhite = const Color.fromRGBO(255, 255, 255, 0.9);
  static const Color bgGrayStart = const Color.fromRGBO(243, 243, 243, 1);
  static const Color bgGrayStop = const Color.fromRGBO(232, 232, 232, 1);
  static const Color bgRedStop = const Color.fromRGBO(185, 51, 51, 1);
  static const Color bgCardOverview = const Color.fromRGBO(1, 1, 1, 1);
  static const Color strokeMenu = const Color.fromRGBO(237, 237, 237, 1);
  static const Color difficultyYellow = const Color.fromRGBO(241, 196, 15, 1);
  static const Color difficultyOrange = const Color.fromRGBO(230, 126, 34, 1);
  static const Color difficultyBlue = const Color.fromRGBO(52, 152, 219, 1);
}

class Spacings {
  Spacings._();

  static const double xs = 10.0;
  static const double s = 15.0;
  static const double m = 20.0;
  static const double l = 30.0;
  static const double xl = 40.0;
  static const double xxl = 50.0;
}

class Typography {
  Typography._();

  static TextStyle title = TextStyle(
    fontFamily: 'Staatliches',
    fontSize: 28,
    color: Colors.black,
  );
  static TextStyle subtitle =
      TextStyle(fontFamily: 'Staatliches', fontSize: 18, color: Colors.gray);
  static TextStyle difficulty = TextStyle(
    fontFamily: 'Staatliches',
    fontSize: 26,
    color: Colors.white,
  );
  static TextStyle button =
      TextStyle(fontFamily: 'Staatliches', fontSize: 28, color: Colors.white);
  static TextStyle indicatorWhite =
      TextStyle(fontFamily: 'Staatliches', fontSize: 20, color: Colors.white);
  static TextStyle indicatorBlack =
      TextStyle(fontFamily: 'Staatliches', fontSize: 20, color: Colors.black);
  static TextStyle text =
      TextStyle(fontFamily: 'Lato', fontSize: 16, color: Colors.gray);
}

const BorderRadius kAppBorderRadius = BorderRadius.all(Radius.circular(5.0));
const BoxShadow kAppBoxShadow =
    BoxShadow(color: Colors.shadow, offset: Offset(0, 4), blurRadius: 4.0);
