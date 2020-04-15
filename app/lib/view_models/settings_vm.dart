import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/state/app_state.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel();
  AppState _appState;

  int _preparationTimer;
  int get preparationTimerInitial => _preparationTimer;
  String _preparationTimerInput;

  bool isMetricActive;
  bool isImperialActive;

  bool isCelsiusActive;
  bool isFahrenheitActive;

  void update(AppState appState) {
    _appState = appState;
    _preparationTimer = _appState?.settings?.preparationTimer;
    _setRadioButtons();
  }

  void handlePreparationTimerInput(String s) {
    _preparationTimerInput = s;
  }

  Future<bool> canNavigate() {
    return Future.value(_validateAndSet());
  }

  bool _validateAndSet() {
    _preparationTimer = InputParsers.parseToInt(
        string: _preparationTimerInput, inputField: 'Preparation timer');

    final bool _isPreparationTimerValid = Validators.biggerThanZero(
        value: _preparationTimer, inputField: 'Preparation timer');

    if (_isPreparationTimerValid == true) {
      _setPreparationTimer(_preparationTimer);
    }

    return _isPreparationTimerValid;
  }

  void _setRadioButtons() {
    isMetricActive = _appState.settings?.weightUnit == WeightUnit.metric;
    isImperialActive = _appState.settings?.weightUnit == WeightUnit.imperial;
    isCelsiusActive = _appState.settings?.tempUnit == TempUnit.celsius;
    isFahrenheitActive = _appState.settings?.tempUnit == TempUnit.fahrenheit;
    notifyListeners();
  }

  void setDefaultBoard(Board defaultBoard) {
    final _settings = _appState?.settings
        ?.rebuild((b) => b..defaultBoard = defaultBoard.toBuilder());
    _setAndSaveSettings(_settings);
  }

  void _setPreparationTimer(int seconds) {
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
