import 'package:flutter/cupertino.dart';

import 'package:app/data/basic_settings.dart';
import 'package:app/data/basic_workout.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workouts.dart';
import 'package:app/services/persistence.dart';

class AppState extends ChangeNotifier {
  AppState(PersistenceService persistenceService) {
    _persistenceService = persistenceService;
    // TODO: Think about something to replace this.
    _initializeBasicState();
    _initializePersistence();
  }

  PersistenceService _persistenceService;

  Workout _newWorkout;
  Workout get newWorkout => _newWorkout;
  void saveNewWorkout(Workout newWorkout) {
    _newWorkout = newWorkout;
    _persistenceService.saveWorkout(newWorkout);
    notifyListeners();
  }

  Workout _editWorkout;
  Workout get editWorkout => _editWorkout;
  void saveEditWorkout(Workout editWorkout) {
    // TODO: Further logic of course.
    _editWorkout = editWorkout;
    notifyListeners();
  }

  Workouts _workouts;
  Workouts get workouts => _workouts;
  void saveWorkouts(Workouts workouts) {
    _workouts = workouts;
    _persistenceService.saveWorkouts(workouts);
    notifyListeners();
  }

  Settings _settings;
  Settings get settings => _settings;
  void setSettings(Settings settings) {
    _settings = settings;
    _persistenceService.saveSettings(settings);
    notifyListeners();
  }

  void _initializeBasicState() {
    _newWorkout = basicWorkout;
    _workouts = Workouts((b) => b);
    _settings = basicSettings;
    _editWorkout = basicEditWorkout;
    notifyListeners();
  }

  void _initializePersistence() async {
    _newWorkout = await _persistenceService.getNewWorkout();
    _workouts = await _persistenceService.getWorkouts();
    _settings = await _persistenceService.getSettings();
    notifyListeners();
  }
}
