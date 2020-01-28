import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/sound.dart';
import 'package:app/models/unit.dart';

// ignore_for_file: unnecessary_getters_setters

// Setters and getters are needed for Provider classes.
// Otherwise, we cannot make a call to notifyListeners() when setting as value.

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel(Board defaultBoard, int preparationTimer, Sound hangSound,
      Sound restSound, Unit unit) {
    this._defaultBoard = defaultBoard;
    this._preparationTimer = preparationTimer;
    this._hangSound = hangSound;
    this._restSound = restSound;
    this._unit = unit;
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

  Unit _unit;
  Unit get unit => _unit;
  void setUnit(Unit unit) {
    _unit = unit;
    notifyListeners();
  }
}
