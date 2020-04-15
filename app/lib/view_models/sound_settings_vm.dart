import 'package:flutter/cupertino.dart';

import 'package:app/data/sounds.dart';
import 'package:app/models/models.dart';
import 'package:app/state/app_state.dart';

class SoundSettingsViewModel extends ChangeNotifier {
  SoundSettingsViewModel();

  int beepsBeforeHangInitial;
  int beepsBeforeRestInitial;

  // Hang sound
  bool isThudDeepActive;
  bool isThudHollowActive;
  bool isThudSoftActive;
  bool isHangSoundOffActive;

  // Rest sound
  bool isMetalHitSmallActive;
  bool isMetalHitLargeActive;
  bool isGongActive;
  bool isRestSoundOffActive;

  // Beep sound
  bool isHitLightSoftActive;
  bool isHitLightHardActive;
  bool isBeepSoundOffActive;

  void update(AppState appState) {
    _appState = appState;
    beepsBeforeHangInitial = _appState.settings?.beepsBeforeHang;
    beepsBeforeRestInitial = _appState.settings?.beepsBeforeRest;
    _setRadioButtons();
  }

  AppState _appState;

  void _setRadioButtons() {
    isThudDeepActive = _appState.settings?.hangSound == Sounds.thudDeep;
    isThudHollowActive = _appState.settings?.hangSound == Sounds.thudHollow;
    isThudSoftActive = _appState.settings?.hangSound == Sounds.thudSoft;
    isHangSoundOffActive = _appState.settings?.hangSound == Sounds.off;
    isMetalHitSmallActive =
        _appState.settings?.restSound == Sounds.metalHitSmall;
    isMetalHitLargeActive =
        _appState.settings?.restSound == Sounds.metalHitLarge;
    isGongActive = _appState.settings?.restSound == Sounds.gong;
    isRestSoundOffActive = _appState.settings?.restSound == Sounds.off;
    isHitLightSoftActive = _appState.settings?.beepSound == Sounds.hitLightSoft;
    isHitLightHardActive = _appState.settings?.beepSound == Sounds.hitLightHard;
    isBeepSoundOffActive = _appState.settings?.beepSound == Sounds.off;
    notifyListeners();
  }

  void setHangSound(Sound sound) {
    final _settings =
        _appState?.settings?.rebuild((b) => b..hangSound = sound.toBuilder());
    _setAndSaveSettings(_settings);
  }

  void setRestSound(Sound sound) {
    final _settings =
        _appState?.settings?.rebuild((b) => b..restSound = sound.toBuilder());
    _setAndSaveSettings(_settings);
  }

  void setBeepSound(Sound sound) {
    final _settings =
        _appState?.settings?.rebuild((b) => b..beepSound = sound.toBuilder());
    _setAndSaveSettings(_settings);
  }

  void setBeepsBeforeHang(int amount) {
    final _settings =
        _appState?.settings?.rebuild((b) => b..beepsBeforeHang = amount);
    _setAndSaveSettings(_settings);
  }

  void setBeepsBeforeRest(int amount) {
    final _settings =
        _appState?.settings?.rebuild((b) => b..beepsBeforeRest = amount);
    _setAndSaveSettings(_settings);
  }

  void _setAndSaveSettings(Settings settings) {
    _appState?.setSettings(settings);
    _appState?.saveSettings(settings);
  }
}
