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

  Workout _newWorkout;
  Workout get newWorkout => _newWorkout;
  Workout _editWorkout;
  Workout get editWorkout => _editWorkout;
  Workout _viewWorkout;
  Workout get viewWorkout => _viewWorkout;

  Workouts _workouts;
  Workouts get workouts => _workouts;
  List<Workout> get workoutList => _workouts?.workouts?.toList();
  CompletedWorkouts _completedWorkouts;
  CompletedWorkouts get completedWorkouts => _completedWorkouts;

  Settings _settings;
  Settings get settings => _settings;

  DeviceInfo _deviceInfo;
  DeviceInfo get deviceInfo => _deviceInfo;

  void saveNewWorkout(Workout newWorkout) {
    _newWorkout = newWorkout;
    _persistenceService.saveWorkout(newWorkout);
    notifyListeners();
  }

  void saveEditWorkout(Workout editWorkout) {
    _editWorkout = editWorkout;
    saveEditWorkoutToWorkouts();
    notifyListeners();
  }

  void saveEditWorkoutToWorkouts() {
    final list = workoutList;
    final int index = list
        .indexWhere((workout) => _editWorkout.originalId == workout.originalId);
    list[index] = _editWorkout;
    saveWorkouts(workouts.rebuild((b) => b..workouts.replace(list)));
  }

  void setViewWorkout(Workout viewWorkout) {
    _viewWorkout = viewWorkout;
    notifyListeners();
  }

  void saveWorkouts(Workouts workouts) {
    _workouts = workouts;
    _persistenceService.saveWorkouts(workouts);
    notifyListeners();
  }

  void saveCompletedWorkouts(CompletedWorkouts completedWorkouts) {
    _completedWorkouts = completedWorkouts;
    _persistenceService.saveCompletedWorkouts(completedWorkouts);
    notifyListeners();
  }

  void saveSettings(Settings settings) {
    _settings = settings;
    _persistenceService.saveSettings(settings);
    notifyListeners();
  }

  void _initializePersistence() async {
    _newWorkout = await _persistenceService.getNewWorkout();
    _workouts = await _persistenceService.getWorkouts();
    _completedWorkouts = await _persistenceService.getCompletedWorkouts();
    _settings = await _persistenceService.getSettings();
    _deviceInfo = await _persistenceService.getDeviceInfo();
    if (_deviceInfo.firstLaunch == true) {
      _persistenceService
          .saveDeviceInfo(deviceInfo.rebuild((b) => b.firstLaunch = false));
    }
    saveNewWorkout(_newWorkout);
    saveWorkouts(_workouts);
    saveCompletedWorkouts(_completedWorkouts);
    saveSettings(_settings);
    notifyListeners();
  }
}
