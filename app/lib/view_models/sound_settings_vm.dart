import 'package:app/models/sound.dart';
import 'package:app/state/app_state.dart';

// ignore_for_file: unnecessary_getters_setters
// Setters and getters are needed for Provider classes.
// Otherwise, we cannot make a call to notifyListeners() when setting as value.

class SoundSettingsViewModel {
  SoundSettingsViewModel(AppState appState) {
    appState = appState;
  }

  AppState appState;

  void setHangSound(Sound sound) {
    appState.setSettings(
        appState.settings.rebuild((b) => b..hangSound = sound.toBuilder()));
  }

  void setRestSound(Sound sound) {
    appState.setSettings(
        appState.settings.rebuild((b) => b..restSound = sound.toBuilder()));
  }

  void setBeepSound(Sound sound) {
    appState.setSettings(
        appState.settings.rebuild((b) => b..beepSound = sound.toBuilder()));
  }

  void setBeepsBeforeHang(int amount) {
    appState.setSettings(
        appState.settings.rebuild((b) => b..beepsBeforeHang = amount));
  }

  void setBeepsBeforeRest(int amount) {
    appState.setSettings(
        appState.settings.rebuild((b) => b..beepsBeforeRest = amount));
  }
}
