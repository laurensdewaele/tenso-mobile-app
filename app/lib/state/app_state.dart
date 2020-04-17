import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/services/persistence.dart';

class AppState extends ChangeNotifier {
  AppState(PersistenceService persistenceService) {
    _persistenceService = persistenceService;
    _initializeState();
  }

  PersistenceService _persistenceService;

  DeviceInfo _deviceInfo;
  DeviceInfo get deviceInfo => _deviceInfo;

  void _initializeState() async {
    _deviceInfo = await _persistenceService.getDeviceInfo();
    if (_deviceInfo.firstLaunch == true) {
      _persistenceService
          .saveDeviceInfo(deviceInfo.rebuild((b) => b.firstLaunch = false));
    }
    notifyListeners();
  }
}
