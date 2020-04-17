import 'package:flutter/cupertino.dart';

import 'package:app/data/sounds.dart';
import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/state/settings_state.dart';

class SoundSettingsViewModel extends ChangeNotifier {
  SettingsState _settingsState;
  Settings _settings;

  SoundSettingsViewModel({SettingsState settingsState}) {
    _settingsState = settingsState;
    _settings = _settingsState.settings;
    _settingsState.settings$.listen((s) {
      _settings = s;
      _setRadioButtons();
    });
    _setInitial();
  }

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

  void _setInitial() {
    _beepsBeforeHang = _settings.beepsBeforeHang;
    _beepsBeforeRest = _settings.beepsBeforeRest;
    _beepsBeforeHangInput = _settings.beepsBeforeHang.toString();
    _beepsBeforeRestInput = _settings.beepsBeforeRest.toString();
  }

  void _setRadioButtons() {
    isThudDeepActive = _settings.hangSound == Sounds.thudDeep;
    isThudHollowActive = _settings.hangSound == Sounds.thudHollow;
    isThudSoftActive = _settings.hangSound == Sounds.thudSoft;
    isHangSoundOffActive = _settings.hangSound == Sounds.off;
    isMetalHitSmallActive = _settings.restSound == Sounds.metalHitSmall;
    isMetalHitLargeActive = _settings.restSound == Sounds.metalHitLarge;
    isGongActive = _settings.restSound == Sounds.gong;
    isRestSoundOffActive = _settings.restSound == Sounds.off;
    isHitLightSoftActive = _settings.beepSound == Sounds.hitLightSoft;
    isHitLightHardActive = _settings.beepSound == Sounds.hitLightHard;
    isBeepSoundOffActive = _settings.beepSound == Sounds.off;
    notifyListeners();
  }

  void setHangSound(Sound hangSound) {
    _settingsState.setHangSound(hangSound);
  }

  void setRestSound(Sound restSound) {
    _settingsState.setRestSound(restSound);
  }

  void setBeepSound(Sound beepSound) {
    _settingsState.setBeepSound(beepSound);
  }

  void handleBeepsBeforeRestInput(String s) {
    _beepsBeforeRestInput = s;
  }

  void handleBeepsBeforeHangInput(String s) {
    _beepsBeforeHangInput = s;
  }

  Future<bool> canNavigate() {
    // See https://dart.dev/guides/libraries/futures-error-handling#potential-problem-accidentally-mixing-synchronous-and-asynchronous-errors
    return Future.sync(_validateAndSet);
  }

  bool _validateAndSet() {
    _beepsBeforeHang = InputParsers.parseToInt(
        string: _beepsBeforeHangInput, inputField: 'Beeps before hang');
    _beepsBeforeRest = InputParsers.parseToInt(
        string: _beepsBeforeRestInput, inputField: 'Beeps before rest');
    final bool _isBeepsBeforeHangValid = Validators.biggerThanZero(
        value: _beepsBeforeHang, inputField: 'Beeps before hang');
    final bool _isBeepsBeforeRestValid = Validators.biggerThanZero(
        value: _beepsBeforeRest, inputField: 'Beeps before rest');

    final _isValid = [
      _isBeepsBeforeHangValid,
      _isBeepsBeforeRestValid,
    ].fold(true, (a, b) => a && b);

    if (_isValid == true) {
      _settingsState.setBeepsBeforeRest(_beepsBeforeRest);
      _settingsState.setBeepsBeforeHang(_beepsBeforeHang);
    }

    return _isValid;
  }
}
