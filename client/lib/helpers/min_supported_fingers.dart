import 'dart:math';

import 'package:app/models/models.dart';

int calculateMinSupportedFingers(List<BoardHold> boardHolds) {
  final List<int> _supportedFingers = boardHolds
      .map((BoardHold boardHold) => boardHold.supportedFingers)
      .toList();
  _supportedFingers.removeWhere((f) => f == null);
  return _supportedFingers != null && _supportedFingers.length > 0
      ? _supportedFingers.reduce(min)
      : 5;
}
