import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/state/app_state.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel();
  AppState _appState;

  int preparationTimerInitial;

  bool isMetricActive;
  bool isImperialActive;

  bool isCelsiusActive;
  bool isFahrenheitActive;

  void update(AppState appState) {
    if (preparationTimerInitial == null) {
      preparationTimerInitial = appState.settings.preparationTimer;
    }
    _appState = appState;
    _setRadioButtons();
  }

  void _setRadioButtons() {
    isMetricActive = _appState.settings.weightUnit == WeightUnit.metric;
    isImperialActive = _appState.settings.weightUnit == WeightUnit.imperial;
    isCelsiusActive = _appState.settings.tempUnit == TempUnit.celsius;
    isFahrenheitActive = _appState.settings.tempUnit == TempUnit.fahrenheit;
    notifyListeners();
  }

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
