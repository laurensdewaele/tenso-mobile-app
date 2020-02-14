import 'dart:io';

import 'package:app/data/basic_settings.dart';
import 'package:app/data/basic_workout.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workouts.dart';
import 'package:path_provider/path_provider.dart';

// TODO: PersistenceService should not be the one that sets defaultSettings and d defaultWorkout etc...
class PersistenceService {
  // Creates a singleton.
  PersistenceService._();
  static final PersistenceService _persistenceService = PersistenceService._();
  factory PersistenceService() {
    return _persistenceService;
  }

  String __localPath;

  Future<String> get _localPath async {
    if (__localPath == null) {
      final directory = await getApplicationDocumentsDirectory();
      __localPath = directory.path;
    }
    return __localPath;
  }

  Future<File> get _localWorkoutFile async {
    final path = await _localPath;
    return File('$path/workout.txt');
  }

  Future<File> get _localWorkoutsFile async {
    final path = await _localPath;
    return File('$path/workouts.txt');
  }

  Future<File> get _localSettingsFile async {
    final path = await _localPath;
    return File('$path/settings.txt');
  }

  void saveWorkout(Workout workout) async {
    try {
      final file = await _localWorkoutFile;
      file.writeAsString(workout.toJson().toString());
    } catch (e) {
      print(e);
      // TODO: Error handling
    }
  }

  Future<Workout> getNewWorkout() async {
    Workout workout;
    try {
      final file = await _localWorkoutFile;
      String contents = await file.readAsString();
      workout = Workout.fromJson(contents);
    } catch (e) {
      print(e);
      // TODO: Error handling.
    }
    return workout == null ? basicWorkout : workout;
  }

  void saveWorkouts(Workouts workouts) async {
    try {
      final file = await _localWorkoutsFile;
      file.writeAsString(workouts.toJson().toString());
    } catch (e) {
      print(e);
      // TODO: Error handling.
    }
  }

  Future<Workouts> getWorkouts() async {
    Workouts workouts;
    try {
      final file = await _localWorkoutsFile;
      String contents = await file.readAsString();
      workouts = Workouts.fromJson(contents);
    } catch (e) {
      print(e);
      // TODO: Error handling.
    }
    return workouts == null ? Workouts() : workouts;
  }

  void saveSettings(Settings settings) async {
    try {
      final file = await _localSettingsFile;
      file.writeAsString(settings.toJson().toString());
    } catch (e) {
      print(e);
      // TODO: Error handling.
    }
  }

  Future<Settings> getSettings() async {
    Settings settings;
    try {
      final file = await _localSettingsFile;
      String contents = await file.readAsString();
      settings = Settings.fromJson(contents);
    } catch (e) {
      print(e);
      // TODO: Error handling.
    }
    return settings == null ? basicSettings : settings;
  }
}
