import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/settings.dart';
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
    final _settings = _appState.settings
        .rebuild((b) => b..defaultBoard = defaultBoard.toBuilder());
    _setAndSaveSettings(_settings);
  }

  void setPreparationTimer(int seconds) {
    final _settings =
        _appState.settings.rebuild((b) => b..preparationTimer = seconds);
    _setAndSaveSettings(_settings);
  }

  void setUnit(Unit unit) {
    final _settings = _appState.settings.rebuild((b) => b..unit = unit);
    _setAndSaveSettings(_settings);
  }

  void _setAndSaveSettings(Settings settings) {
    _appState.setSettings(settings);
    _appState.saveSettings(settings);
  }
}
