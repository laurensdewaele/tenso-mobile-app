import 'package:app/models/sound.dart';
import 'package:app/state/app_state.dart';
import 'package:flutter/cupertino.dart';

// ignore_for_file: unnecessary_getters_setters
// Setters and getters are needed for Provider classes.
// Otherwise, we cannot make a call to notifyListeners() when setting as value.

class SoundSettingsViewModel extends ChangeNotifier {
  SoundSettingsViewModel();

  void update(AppState appState) {
    _appState = appState;
    notifyListeners();
  }

  AppState _appState;
  AppState get appState => _appState;

  void setHangSound(Sound sound) {
    _appState.saveSettings(
        _appState.settings.rebuild((b) => b..hangSound = sound.toBuilder()));
  }

  void setRestSound(Sound sound) {
    _appState.saveSettings(
        _appState.settings.rebuild((b) => b..restSound = sound.toBuilder()));
  }

  void setBeepSound(Sound sound) {
    _appState.saveSettings(
        _appState.settings.rebuild((b) => b..beepSound = sound.toBuilder()));
  }

  void setBeepsBeforeHang(int amount) {
    _appState.saveSettings(
        _appState.settings.rebuild((b) => b..beepsBeforeHang = amount));
  }

  void setBeepsBeforeRest(int amount) {
    _appState.saveSettings(
        _appState.settings.rebuild((b) => b..beepsBeforeRest = amount));
  }
}
