import 'package:app/data/basic_settings.data.dart';
import 'package:app/models/models.dart';
import 'package:app/services/persistence.service.dart';
import 'package:rxdart/rxdart.dart';

class SettingsState {
  SettingsState._();
  static final SettingsState _settingsState = SettingsState._();
  factory SettingsState() => _settingsState;

  PersistenceService _persistenceService = PersistenceService();

  BehaviorSubject<Settings> _settings$;
  Stream<Settings> get settings$ => _settings$;
  Settings get settings => _settings$.value;

  Future<void> init() async {
    final Settings _settings = await _persistenceService.getSettings();
    _settings$ = BehaviorSubject.seeded(_settings ?? basicSettings);
    return Future.value();
  }

  void dispose() {
    _settings$.close();
  }

  void setDefaultBoard(Board defaultBoard) {
    final Settings _newSettings =
        settings.rebuild((b) => b..defaultBoard = defaultBoard.toBuilder());
    _settings$.add(_newSettings);
    _saveSettings(_newSettings);
  }

  void _saveSettings(Settings settings) {
    _persistenceService.saveSettings(settings);
  }

  void setPreparationTimer(int seconds) {
    final Settings _newSettings =
        settings.rebuild((b) => b..preparationTimer = seconds);
    _settings$.add(_newSettings);
    _saveSettings(_newSettings);
  }

  void setWeightUnit(WeightUnit weightUnit) {
    final Settings _newSettings =
        settings.rebuild((b) => b..weightUnit = weightUnit);
    _settings$.add(_newSettings);
    _saveSettings(_newSettings);
  }

  void setTempUnit(TempUnit tempUnit) {
    final Settings _newSettings =
        settings.rebuild((b) => b..tempUnit = tempUnit);
    _settings$.add(_newSettings);
    _saveSettings(_newSettings);
  }

  void setHangSound(Sound hangSound) {
    final Settings _newSettings =
        settings.rebuild((b) => b..hangSound = hangSound.toBuilder());
    _settings$.add(_newSettings);
    _saveSettings(_newSettings);
  }

  void setRestSound(Sound restSound) {
    final Settings _newSettings =
        settings.rebuild((b) => b..restSound = restSound.toBuilder());
    _settings$.add(_newSettings);
    _saveSettings(_newSettings);
  }

  void setBeepSound(Sound beepSound) {
    final Settings _newSettings =
        settings.rebuild((b) => b..beepSound = beepSound.toBuilder());
    _settings$.add(_newSettings);
    _saveSettings(_newSettings);
  }

  void setBeepsBeforeRest(int beepsBeforeRest) {
    final Settings _newSettings =
        settings.rebuild((b) => b..beepsBeforeRest = beepsBeforeRest);
    _settings$.add(_newSettings);
    _saveSettings(_newSettings);
  }

  void setBeepsBeforeHang(int beepsBeforeHang) {
    final Settings _newSettings =
        settings.rebuild((b) => b..beepsBeforeHang = beepsBeforeHang);
    _settings$.add(_newSettings);
    _saveSettings(_newSettings);
  }
}
