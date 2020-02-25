import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/sound.dart';
import 'package:app/models/unit.dart';
import 'package:app/state/app_state.dart';

// ignore_for_file: unnecessary_getters_setters

// Setters and getters are needed for Provider classes.
// Otherwise, we cannot make a call to notifyListeners() when setting as value.

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel();

  void update(AppState appState) {
    _appState = appState;
    notifyListeners();
  }

  AppState _appState;
  AppState get appState => _appState;

  void setDefaultBoard(Board defaultBoard) {
    _appState.saveSettings(_appState.settings
        .rebuild((b) => b..defaultBoard = defaultBoard.toBuilder()));
  }

  void setPreparationTimer(int seconds) {
    _appState.saveSettings(
        _appState.settings.rebuild((b) => b..preparationTimer = seconds));
  }

  void setHangSound(Sound sound) {
    _appState.saveSettings(
        _appState.settings.rebuild((b) => b..hangSound = sound.toBuilder()));
  }

  void setRestSound(Sound sound) {
    _appState.saveSettings(
        _appState.settings.rebuild((b) => b..restSound = sound.toBuilder()));
  }

  void setUnit(Unit unit) {
    _appState.saveSettings(_appState.settings.rebuild((b) => b..unit = unit));
  }
}
