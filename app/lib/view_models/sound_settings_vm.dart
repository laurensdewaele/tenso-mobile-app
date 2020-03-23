import 'package:app/models/settings.dart';
import 'package:app/models/sound.dart';
import 'package:app/state/app_state.dart';
import 'package:flutter/cupertino.dart';

class SoundSettingsViewModel extends ChangeNotifier {
  SoundSettingsViewModel();

  void update(AppState appState) {
    _appState = appState;
    notifyListeners();
  }

  AppState _appState;
  AppState get appState => _appState;

  void setHangSound(Sound sound) {
    final _settings =
        _appState.settings.rebuild((b) => b..hangSound = sound.toBuilder());
    _setAndSaveSettings(_settings);
  }

  void setRestSound(Sound sound) {
    final _settings =
        _appState.settings.rebuild((b) => b..restSound = sound.toBuilder());
    _setAndSaveSettings(_settings);
  }

  void setBeepSound(Sound sound) {
    final _settings =
        _appState.settings.rebuild((b) => b..beepSound = sound.toBuilder());
    _setAndSaveSettings(_settings);
  }

  void setBeepsBeforeHang(int amount) {
    final _settings =
        _appState.settings.rebuild((b) => b..beepsBeforeHang = amount);
    _setAndSaveSettings(_settings);
  }

  void setBeepsBeforeRest(int amount) {
    final _settings =
        _appState.settings.rebuild((b) => b..beepsBeforeRest = amount);
    _setAndSaveSettings(_settings);
  }

  void _setAndSaveSettings(Settings settings) {
    _appState.setSettings(settings);
    _appState.saveSettings(settings);
  }
}
