import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/temp_unit.dart';
import 'package:app/models/weight_unit.dart';
import 'package:app/state/app_state.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel();

  void update(AppState appState) {
    _appState = appState;
  }

  AppState _appState;

  void setDefaultBoard(Board defaultBoard) {
    final _settings = _appState?.settings
        ?.rebuild((b) => b..defaultBoard = defaultBoard.toBuilder());
    _setAndSaveSettings(_settings);
  }

  void setPreparationTimer(int seconds) {
    final _settings =
        _appState?.settings?.rebuild((b) => b..preparationTimer = seconds);
    _setAndSaveSettings(_settings);
  }

  void setWeightUnit(WeightUnit weightUnit) {
    final _settings =
        _appState?.settings?.rebuild((b) => b..weightUnit = weightUnit);
    _setAndSaveSettings(_settings);
  }

  void setTempUnit(TempUnit tempUnit) {
    final _settings =
        _appState?.settings?.rebuild((b) => b..tempUnit = tempUnit);
    _setAndSaveSettings(_settings);
  }

  void _setAndSaveSettings(Settings settings) {
    _appState?.setSettings(settings);
    _appState?.saveSettings(settings);
  }
}
