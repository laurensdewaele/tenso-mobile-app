import 'package:flutter/cupertino.dart';

import 'package:app/data/boards/beastmaker_1000.dart';
import 'package:app/models/board.dart';
import 'package:app/models/grades.dart';
import 'package:app/models/sound.dart';
import 'package:app/models/units.dart';

// ignore_for_file: unnecessary_getters_setters

// Setters and getters are needed for Provider classes.
// Otherwise, we cannot make a call to notifyListeners() when setting as value.

final SettingsModel defaultSettings = SettingsModel(
    beastmaker1000, 20, null, null, Units.metric, GradeTypes.sportFrench);

class SettingsModel extends ChangeNotifier {
  SettingsModel(Board defaultBoard, int preparationTimer, Sound hangSound,
      Sound restSound, Units unit, GradeTypes gradeType) {
    this._defaultBoard = defaultBoard;
    this._preparationTimer = preparationTimer;
    this._hangSound = hangSound;
    this._restSound = restSound;
    this._unit = unit;
    this._gradeType = gradeType;
  }

  Board _defaultBoard;
  Board get defaultBoard => _defaultBoard;
  void setDefaultBoard(Board board) {
    _defaultBoard = board;
    notifyListeners();
  }

  int _preparationTimer;
  int get preparationTimer => _preparationTimer;
  void setPreparationTimer(int seconds) {
    _preparationTimer = seconds;
    notifyListeners();
  }

  Sound _hangSound;
  Sound get hangSound => _hangSound;
  void setHangSound(Sound sound) {
    _hangSound = sound;
    notifyListeners();
  }

  Sound _restSound;
  Sound get restSound => _restSound;
  void setRestSound(Sound sound) {
    _restSound = sound;
    notifyListeners();
  }

  Units _unit;
  Units get unit => _unit;
  void setUnit(Units unit) {
    _unit = unit;
    notifyListeners();
  }

  GradeTypes _gradeType;
  GradeTypes get gradeType => _gradeType;
  void setGradeType(GradeTypes gradeType) {
    _gradeType = gradeType;
    notifyListeners();
  }
}
