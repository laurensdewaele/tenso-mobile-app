import 'package:flutter/cupertino.dart';

import 'package:app/models/completed_workouts.dart';
import 'package:app/models/device_info.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workouts.dart';
import 'package:app/services/persistence.dart';

class AppState extends ChangeNotifier {
  AppState(PersistenceService persistenceService) {
    _persistenceService = persistenceService;
    _initializePersistence();
  }

  PersistenceService _persistenceService;

  // This can be used for either:
  // 1) Creating a new workout
  // 2) Editing a workout
  // 3) Viewing a workout (once completed)
  Workout _workout;
  Workout get workout => _workout;

  Workouts _workouts;
  Workouts get workouts => _workouts;
  List<Workout> get workoutList => _workouts?.workouts?.toList();
  CompletedWorkouts _completedWorkouts;
  CompletedWorkouts get completedWorkouts => _completedWorkouts;

  Settings _settings;
  Settings get settings => _settings;

  DeviceInfo _deviceInfo;
  DeviceInfo get deviceInfo => _deviceInfo;

  void setWorkout(Workout workout) {
    _workout = workout;
    notifyListeners();
  }

  void saveNewWorkout(Workout newWorkout) {
    _persistenceService.saveNewWorkout(newWorkout);
  }

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

  void _initializePersistence() async {
    _workout = await _persistenceService.getNewWorkout();
    _workouts = await _persistenceService.getWorkouts();
    _completedWorkouts = await _persistenceService.getCompletedWorkouts();
    _settings = await _persistenceService.getSettings();
    _deviceInfo = await _persistenceService.getDeviceInfo();
    if (_deviceInfo.firstLaunch == true) {
      _persistenceService
          .saveDeviceInfo(deviceInfo.rebuild((b) => b.firstLaunch = false));
    }
    setWorkout(_workout);
    setWorkouts(_workouts);
    setCompletedWorkouts(_completedWorkouts);
    setSettings(_settings);
    notifyListeners();
  }
}
