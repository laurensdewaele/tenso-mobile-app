import 'package:flutter/cupertino.dart';

import 'package:app/data/sounds.dart';
import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/state/app_state.dart';

class SoundSettingsViewModel extends ChangeNotifier {
  SoundSettingsViewModel();

  int _beepsBeforeRest;
  int get beepsBeforeRestInitial => _beepsBeforeRest;
  int _beepsBeforeHang;
  int get beepsBeforeHangInitial => _beepsBeforeHang;
  String _beepsBeforeRestInput;
  String _beepsBeforeHangInput;

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
    _setInitial();
    _setRadioButtons();
  }

  void _setInitial() {
    _beepsBeforeHang = _appState.settings?.beepsBeforeHang;
    _beepsBeforeRest = _appState.settings?.beepsBeforeRest;
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

  void _setBeepsBeforeHang(int amount) {
    final _settings =
        _appState?.settings?.rebuild((b) => b..beepsBeforeHang = amount);
    _setAndSaveSettings(_settings);
  }

  void _setBeepsBeforeRest(int amount) {
    final _settings =
        _appState?.settings?.rebuild((b) => b..beepsBeforeRest = amount);
    _setAndSaveSettings(_settings);
  }

  void handleBeepsBeforeRestInput(String s) {
    _beepsBeforeRestInput = s;
  }

  void handleBeepsBeforeHangInput(String s) {
    _beepsBeforeHangInput = s;
  }

  bool canNavigate() {
    return _validateAndSet();
  }

  bool _validateAndSet() {
    _beepsBeforeHang = InputParsers.parseToInt(
        string: _beepsBeforeHangInput, inputField: 'Beeps before hang');
    _beepsBeforeRest = InputParsers.parseToInt(
        string: _beepsBeforeRestInput, inputField: 'Beeps before rest');
    final bool _isBeepsBeforeHangValid =
        Validators.biggerThanZero(value: _beepsBeforeHang, inputField: 'Beeps before hang');
    final bool _isBeepsBeforeRestValid =
        Validators.biggerThanZero(value: _beepsBeforeRest, inputField: 'Beeps before rest');

    final _isValid = [
      _isBeepsBeforeHangValid,
      _isBeepsBeforeRestValid,
    ].fold(true, (a, b) => a && b);

    if (_isValid == true) {
      _setBeepsBeforeHang(_beepsBeforeHang);
      _setBeepsBeforeRest(_beepsBeforeRest);
    }

    return _isValid;
  }

  void _setAndSaveSettings(Settings settings) {
    _appState?.setSettings(settings);
    _appState?.saveSettings(settings);
  }
}
