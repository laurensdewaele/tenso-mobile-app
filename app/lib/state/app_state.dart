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

  Workout _workout;
  Workout get workout => _workout;
  void saveWorkout(Workout workout) {
    _workout = workout;
    _persistenceService.saveWorkout(workout);
    notifyListeners();
  }

  void saveNewWorkout(Workout workout) {
    saveWorkout(workout);
    print('---AppState saving NEW workout----');
  }

  void saveEditWorkout(Workout workout) {
    print('---AppState saving EDIT workout----');
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
    _workout = basicWorkout;
    _workouts = Workouts((b) => b);
    _settings = basicSettings;
    notifyListeners();
  }

  void _initializePersistence() async {
    _workout = await _persistenceService.getWorkout();
    _workouts = await _persistenceService.getWorkouts();
    _settings = await _persistenceService.getSettings();
    notifyListeners();
  }
}
