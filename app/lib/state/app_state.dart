import 'package:flutter/cupertino.dart';

import 'package:uuid/uuid.dart';

import 'package:app/models/settings.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workouts.dart';
import 'package:app/services/persistence.dart';

class AppState extends ChangeNotifier {
  AppState(PersistenceService persistenceService) {
    _persistenceService = persistenceService;
    _uuid = Uuid();
    // TODO: Think about something to replace this.
    // So ideally you would want to load persistence,
    // If nothing is there, load the default ones.
    // Have spinners in place?
    _initializePersistence();
  }

  PersistenceService _persistenceService;
  Uuid _uuid;

  Workout _newWorkout;
  Workout get newWorkout => _newWorkout;
  void saveNewWorkout(Workout newWorkout) {
    _newWorkout = newWorkout;
    _persistenceService.saveWorkout(newWorkout);
    notifyListeners();
  }

  void addNewWorkoutToWorkouts() {
    final List<Workout> list = workoutList;
    list.add(newWorkout.rebuild((b) => b..id = _uuid.v4()));
    saveWorkouts(workouts.rebuild((b) => b..workouts.replace(list)));
  }

  Workout _editWorkout;
  Workout get editWorkout => _editWorkout;
  void saveEditWorkout(Workout editWorkout) {
    _editWorkout = editWorkout;
    saveEditWorkoutToWorkouts();
    notifyListeners();
  }

  void saveEditWorkoutToWorkouts() {
    final list = workoutList;
    final int index =
        list.indexWhere((workout) => _editWorkout.id == workout.id);
    list[index] = _editWorkout;
    saveWorkouts(workouts.rebuild((b) => b..workouts.replace(list)));
  }

  void deleteWorkout(Workout workout) {
    final list = workoutList;
    list.removeWhere((w) => w.id == workout.id);
    saveWorkouts(workouts.rebuild((b) => b..workouts.replace(list)));
  }

  Workout _viewWorkout;
  Workout get viewWorkout => _viewWorkout;
  void setViewWorkout(Workout viewWorkout) {
    _viewWorkout = viewWorkout;
    notifyListeners();
  }

  Workouts _workouts;
  Workouts get workouts => _workouts;
  List<Workout> get workoutList => _workouts?.workouts?.toList();
  void saveWorkouts(Workouts workouts) {
    _workouts = workouts;
    _persistenceService.saveWorkouts(workouts);
    notifyListeners();
  }

  Settings _settings;
  Settings get settings => _settings;
  void saveSettings(Settings settings) {
    _settings = settings;
    _persistenceService.saveSettings(settings);
    notifyListeners();
  }

  void _initializePersistence() async {
    _newWorkout = await _persistenceService.getNewWorkout();
    _workouts = await _persistenceService.getWorkouts();
    _settings = await _persistenceService.getSettings();
    saveNewWorkout(_newWorkout);
    saveWorkouts(_workouts);
    saveSettings(_settings);
    notifyListeners();
  }
}
