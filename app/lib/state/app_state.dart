import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/services/persistence.dart';

class AppState extends ChangeNotifier {
  AppState(PersistenceService persistenceService) {
    _persistenceService = persistenceService;
    _initializeState();
  }

  PersistenceService _persistenceService;

  Workouts _workouts;
  Workouts get workouts => _workouts;
  CompletedWorkouts _completedWorkouts;
  CompletedWorkouts get completedWorkouts => _completedWorkouts;

  Settings _settings;
  Settings get settings => _settings;

  DeviceInfo _deviceInfo;
  DeviceInfo get deviceInfo => _deviceInfo;

  void setWorkouts(Workouts workouts) {
    _workouts = workouts;
    notifyListeners();
  }

  void saveWorkouts(Workouts workouts) {
    _persistenceService.saveWorkouts(workouts);
  }

  void setCompletedWorkouts(CompletedWorkouts completedWorkouts) {
    _completedWorkouts = completedWorkouts;
    notifyListeners();
  }

  void saveCompletedWorkouts(CompletedWorkouts completedWorkouts) {
    _persistenceService.saveCompletedWorkouts(completedWorkouts);
  }

  void setSettings(Settings settings) {
    _settings = settings;
    notifyListeners();
  }

  void saveSettings(Settings settings) {
    _persistenceService.saveSettings(settings);
  }

  void _initializeState() async {
    _workouts = await _persistenceService.getWorkouts();
    _completedWorkouts = await _persistenceService.getCompletedWorkouts();
    _settings = await _persistenceService.getSettings();
    _deviceInfo = await _persistenceService.getDeviceInfo();
    if (_deviceInfo.firstLaunch == true) {
      _persistenceService
          .saveDeviceInfo(deviceInfo.rebuild((b) => b.firstLaunch = false));
    }
    setWorkouts(_workouts);
    setCompletedWorkouts(_completedWorkouts);
    setSettings(_settings);
    notifyListeners();
  }
}
