import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/state/settings_state.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsState _settingsState;
  Settings _settings;
  StreamSubscription _sub;

  SettingsViewModel({SettingsState settingsState}) {
    _settingsState = settingsState;
    _settings = _settingsState.settings;
    _update(_settings);
    _sub = _settingsState.settings$.listen(_update);
  }

  void _update(Settings s) {
    _settings = s;
    _preparationTimer = _settings.preparationTimer;
    _preparationTimerInput = _settings.preparationTimer.toString();
    _setRadioButtons();
    notifyListeners();
  }

  int _preparationTimer;
  int get preparationTimerInitial => _preparationTimer;
  String _preparationTimerInput;

  bool isMetricActive;
  bool isImperialActive;

  bool isCelsiusActive;
  bool isFahrenheitActive;

  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  void handlePreparationTimerInput(String s) {
    _preparationTimerInput = s;
  }

  Future<bool> canNavigate() {
    // See https://dart.dev/guides/libraries/futures-error-handling#potential-problem-accidentally-mixing-synchronous-and-asynchronous-errors
    return Future.sync(_validateAndSet);
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
    isMetricActive = _settings.weightUnit == WeightUnit.metric;
    isImperialActive = _settings.weightUnit == WeightUnit.imperial;
    isCelsiusActive = _settings.tempUnit == TempUnit.celsius;
    isFahrenheitActive = _settings.tempUnit == TempUnit.fahrenheit;
  }

  void setDefaultBoard(Board defaultBoard) {
    _settingsState.setDefaultBoard(defaultBoard);
  }

  void _setPreparationTimer(int seconds) {
    _settingsState.setPreparationTimer(seconds);
  }

  void setWeightUnit(WeightUnit weightUnit) {
    _settingsState.setWeightUnit(weightUnit);
  }

  void setTempUnit(TempUnit tempUnit) {
    _settingsState.setTempUnit(tempUnit);
  }
}
