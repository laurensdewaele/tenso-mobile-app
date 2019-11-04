import 'dart:ui';

abstract class Colors {
  static const Color black = Color.fromRGBO(0, 0, 0, .75);
  static const Color primary = Color.fromRGBO(220, 88, 88, 1);
  static const Color bgGrayStart = Color.fromRGBO(243, 243, 243, 1);
  static const Color bgGrayStop = Color.fromRGBO(232, 232, 232, 1);
  static const Color bgRedStart = primary;
  static const Color bgRedStop = Color.fromRGBO(185, 51, 51, 1);
  static const Color bgCardOverview = Color.fromRGBO(1, 1, 1, 1);
  static const Color strokeMenu = Color.fromRGBO(237, 237, 237, 1);
  static const Color difficulyYellow = Color.fromRGBO(241, 196, 15, 1);
  static const Color difficultyOrange = Color.fromRGBO(230, 126, 34, 1);
  static const Color difficultyBlue = Color.fromRGBO(52, 152, 219, 1);
  static const Color difficultyRed = primary;
  static const Color difficultyBlack = black;
}

abstract class Spacings {
  static const double small = 10.0;
  static const double regular = 20.0;
  static const double medium = 30.0;
  static const double large = 50.0;
}
