import 'package:flutter/cupertino.dart';
import 'package:tenso_app/data/sounds.data.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/services/audio_player.service.dart';
import 'package:tenso_app/services/parser.service.dart';
import 'package:tenso_app/services/validation.service.dart';
import 'package:tenso_app/state/settings.state.dart';

class SoundSettingsViewModel extends ChangeNotifier {
  AudioPlayerService _audioPlayerService;
  SettingsState _settingsState;
  Settings _settings;

  SoundSettingsViewModel() {
    _audioPlayerService = AudioPlayerService();
    _settingsState = SettingsState();
    _settings = _settingsState.settings;
    _settingsState.settings$.listen((s) {
      _settings = s;
      _setRadioButtons();
    });
    _setRadioButtons();
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
  bool isHangSoundOffActive;
  bool isWomanHangActive;
  // Rest sound
  bool isMetalHitSmallActive;
  bool isMetalHitLargeActive;
  bool isGongActive;
  bool isRestSoundOffActive;
  bool isWomanRelaxActive;
  bool isWomanRelaxSensualActive;
  // Beep sound
  bool isHitLightSoftActive;
  bool isHitLightHardActive;
  bool isBeepSoundOffActive;

  void _playSound(Sound sound) {
    if (sound.muted != true) {
      _audioPlayerService.play(sound.filename);
    }
  }

  void _setInitial() {
    _beepsBeforeHang = _settings.beepsBeforeHang;
    _beepsBeforeRest = _settings.beepsBeforeRest;
    _beepsBeforeHangInput = _settings.beepsBeforeHang.toString();
    _beepsBeforeRestInput = _settings.beepsBeforeRest.toString();
  }

  void _setRadioButtons() {
    isThudDeepActive = _settings.hangSound == Sounds.thudDeep;
    isHangSoundOffActive = _settings.hangSound == Sounds.off;
    isWomanHangActive = _settings.hangSound == Sounds.femaleHang;
    isGongActive = _settings.restSound == Sounds.gong;
    isRestSoundOffActive = _settings.restSound == Sounds.off;
    isWomanRelaxActive = _settings.restSound == Sounds.femaleRelax;
    isWomanRelaxSensualActive =
        _settings.restSound == Sounds.femaleRelaxSensual;
    isHitLightSoftActive = _settings.beepSound == Sounds.hitLightSoft;
    isHitLightHardActive = _settings.beepSound == Sounds.hitLightHard;
    isBeepSoundOffActive = _settings.beepSound == Sounds.off;
    notifyListeners();
  }

  void setAndPlayHangSound(Sound hangSound) {
    _settingsState.setHangSound(hangSound);
    _playSound(hangSound);
  }

  void setAndPlayRestSound(Sound restSound) {
    _settingsState.setRestSound(restSound);
    _playSound(restSound);
  }

  void setAndPlayBeepSound(Sound beepSound) {
    _settingsState.setBeepSound(beepSound);
    _playSound(beepSound);
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
    final bool _isBeepsBeforeHangValid = Validators.biggerOrEqualToZero(
        value: _beepsBeforeHang, inputField: 'Beeps before hang');
    final bool _isBeepsBeforeRestValid = Validators.biggerOrEqualToZero(
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
