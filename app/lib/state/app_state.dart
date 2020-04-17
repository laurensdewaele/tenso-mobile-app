import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/services/persistence.dart';

class AppState extends ChangeNotifier {
  AppState(PersistenceService persistenceService) {
    _persistenceService = persistenceService;
    _initializeState();
  }

  PersistenceService _persistenceService;

  Settings _settings;
  Settings get settings => _settings;

  DeviceInfo _deviceInfo;
  DeviceInfo get deviceInfo => _deviceInfo;

  void setSettings(Settings settings) {
    _settings = settings;
    notifyListeners();
  }

  void saveSettings(Settings settings) {
    _persistenceService.saveSettings(settings);
  }

  void _initializeState() async {
    _settings = await _persistenceService.getSettings();
    _deviceInfo = await _persistenceService.getDeviceInfo();
    if (_deviceInfo.firstLaunch == true) {
      _persistenceService
          .saveDeviceInfo(deviceInfo.rebuild((b) => b.firstLaunch = false));
    }
    setSettings(_settings);
    notifyListeners();
  }
}
