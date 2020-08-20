import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/services/keyboard.service.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/services/parser.service.dart';
import 'package:tenso_app/services/validation.service.dart';
import 'package:tenso_app/state/settings.state.dart';

class SettingsViewModel extends ChangeNotifier {
  KeyboardService _keyboardService;
  SettingsState _settingsState;
  Settings _settings;
  StreamSubscription _sub;
  NavigationService _navigationService;

  SettingsViewModel() {
    _keyboardService = KeyboardService();
    _navigationService = NavigationService();
    _settingsState = SettingsState();
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

  void handleBackNavigation() async {
    if (await _canNavigate() == true) {
      _navigationService.pushNamed(Routes.workoutOverviewScreen);
    }
  }

  void handleSoundNavigation() async {
    if (await _canNavigate() == true) {
      _navigationService.pushNamed(Routes.soundSettingsScreen);
    }
  }

  void handleBoardNavigation() async {
    if (await _canNavigate() == true) {
      _navigationService.pushNamed(Routes.boardSettingsScreen);
    }
  }

  Future<bool> _canNavigate() {
    // See https://dart.dev/guides/libraries/futures-error-handling#potential-problem-accidentally-mixing-synchronous-and-asynchronous-errors
    return Future.sync(_validateAndSet);
  }

  bool _validateAndSet() {
    // This makes sure the input is not focused when returning from another screen.
    _keyboardService.handleScreenTap();

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
    isMetricActive = _settings.weightSystem == WeightSystem.metric;
    isImperialActive = _settings.weightSystem == WeightSystem.imperial;
    isCelsiusActive = _settings.tempUnit == TempUnit.celsius;
    isFahrenheitActive = _settings.tempUnit == TempUnit.fahrenheit;
  }

  void setDefaultBoard(Board defaultBoard) {
    _settingsState.setDefaultBoard(defaultBoard);
  }

  void _setPreparationTimer(int seconds) {
    _settingsState.setPreparationTimer(seconds);
  }

  void setWeightSystem(WeightSystem weightSystem) {
    _settingsState.setWeightSystem(weightSystem);
  }

  void setTempUnit(TempUnit tempUnit) {
    _settingsState.setTempUnit(tempUnit);
  }
}
