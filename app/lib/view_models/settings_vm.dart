import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/unit.dart';
import 'package:app/state/app_state.dart';

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

  void setUnit(Unit unit) {
    _appState.saveSettings(_appState.settings.rebuild((b) => b..unit = unit));
  }
}
