import 'package:flutter/cupertino.dart';

import 'package:app/models/label.dart';

abstract class Colors {
  static const Color primary = const Color.fromRGBO(220, 88, 88, 1);
  static const Color white = const Color.fromRGBO(255, 255, 255, 1);
  static const Color black = const Color.fromRGBO(52, 52, 52, 1);
  static const Color darkGray = const Color.fromRGBO(71, 71, 71, 1);
  static const Color gray = const Color.fromRGBO(102, 102, 102, 1);
  static const Color lightGray = const Color.fromRGBO(214, 214, 214, 1);
  static const Color lighestGray = const Color.fromRGBO(241, 241, 241, 1);
  static const Color translucent = const Color.fromRGBO(255, 255, 255, 0);
  static const Color shadow = const Color.fromRGBO(0, 0, 0, 0.05);
  static const Color bgBlack = const Color.fromRGBO(46, 46, 46, 1);
  static const Color bgWhite = const Color.fromRGBO(253, 253, 253, 1);
  static const Color bgGrayStart = const Color.fromRGBO(243, 243, 243, 1);
  static const Color bgGrayStop = const Color.fromRGBO(232, 232, 232, 1);
  static const Color yellow = const Color.fromRGBO(241, 196, 15, 1);
  static const Color orange = const Color.fromRGBO(230, 126, 34, 1);
  static const Color blue = const Color.fromRGBO(52, 152, 219, 1);
  static const Color green = const Color.fromRGBO(46, 204, 113, 1.0);
  static const Color turquoise = Color.fromRGBO(26, 188, 156, 1.0);
  static const Color purple = Color.fromRGBO(155, 89, 182, 1.0);
}

const Map<Label, Color> labelColors = {
  Label.black: Colors.black,
  Label.red: Colors.primary,
  Label.orange: Colors.orange,
  Label.yellow: Colors.yellow,
  Label.turquoise: Colors.turquoise,
  Label.blue: Colors.blue,
  Label.purple: Colors.purple,
};

const Map<int, Color> difficultyColors = {
  0: Colors.yellow,
  1: Colors.orange,
  2: Colors.blue,
  3: Colors.primary,
  4: Colors.black
};
