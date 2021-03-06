import 'package:flutter/cupertino.dart';

abstract class Colors {
  static const Color primary = const Color.fromRGBO(220, 88, 88, 1);
  static const Color white = const Color.fromRGBO(255, 255, 255, 1);
  static const Color whiteTranslucent = const Color.fromRGBO(255, 255, 255, .9);
  static const Color black = const Color.fromRGBO(52, 52, 52, 1);
  static const Color blackTranslucent = const Color.fromRGBO(52, 52, 52, .5);
  static const Color darkGray = const Color.fromRGBO(71, 71, 71, 1);
  static const Color darkGrayTranslucent = const Color.fromRGBO(71, 71, 71, .8);
  static const Color gray = const Color.fromRGBO(102, 102, 102, 1);
  static const Color lightGray = const Color.fromRGBO(214, 214, 214, 1);
  static const Color lighestGray = const Color.fromRGBO(241, 241, 241, 1);
  static const Color translucent = const Color.fromRGBO(255, 255, 255, 0);
  static const Color shadow = const Color.fromRGBO(0, 0, 0, 0.05);
  static const Color bgBlack = const Color.fromRGBO(46, 46, 46, 1);
  static const Color bgWhite = const Color.fromRGBO(253, 253, 253, 1);
  static const Color bgGray = const Color.fromRGBO(238, 238, 238, 1);
  static const Color yellow = const Color.fromRGBO(241, 196, 15, 1);
  static const Color orange = const Color.fromRGBO(230, 126, 34, 1);
  static const Color blue = const Color.fromRGBO(52, 152, 219, 1);
  static const Color green = const Color.fromRGBO(46, 204, 113, 1.0);
  static const Color turquoise = Color.fromRGBO(26, 188, 156, 1.0);
  static const Color purple = Color.fromRGBO(155, 89, 182, 1.0);
}

const Map<String, Color> labelColors = {
  'black': Colors.black,
  'red': Colors.primary,
  'orange': Colors.orange,
  'yellow': Colors.yellow,
  'turquoise': Colors.turquoise,
  'blue': Colors.blue,
  'purple': Colors.purple,
};

const Map<int, Color> difficultyColors = {
  0: Colors.yellow,
  1: Colors.orange,
  2: Colors.blue,
  3: Colors.primary,
  4: Colors.black
};
