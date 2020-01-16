import 'package:app/models/grades.dart';
import 'package:flutter/foundation.dart';

import 'package:app/models/board.dart';
import 'package:app/models/sound.dart';

class Settings {
  Settings(
      {@required this.defaultBoard,
      @required this.gradeType,
      @required this.hangSound,
      @required this.preparationTimer,
      @required this.restSound,
      @required this.unit});

  Board defaultBoard;
  int preparationTimer;
  Sound hangSound;
  Sound restSound;
  Units unit;
  GradeTypes gradeType;
}

enum Units { imperial, metric }
