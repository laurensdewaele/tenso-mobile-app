import 'dart:io';

import 'package:app/data/basic_workout.dart';
import 'package:app/models/workout.dart';
import 'package:path_provider/path_provider.dart';

class PersistenceService {
  // Creates a singleton.
  PersistenceService._();
  static final PersistenceService _persistenceService = PersistenceService._();
  factory PersistenceService() {
    return _persistenceService;
  }

  String __localPath;
  File __localFile;

  Future<String> get _localPath async {
    if (__localPath == null) {
      final directory = await getApplicationDocumentsDirectory();
      __localPath = directory.path;
    }
    return __localPath;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/workouts.txt');
  }

  // TODO: Refact ofc.
  Future<Workout> fetchLatestCreatedWorkout() {
    return Future.delayed(Duration(milliseconds: 20), () => basicWorkout);
  }

  void saveWorkout(Workout workout) async {
    try {
      final file = await _localFile;
      file.writeAsString(workout.toJson().toString());
    } catch (e) {
      print(e);
      // TODO: Error handling
    }
  }

  // TODO: Get latest workout
  Future<Workout> getWorkout() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return Workout.fromJson(contents);
    } catch (e) {
      // TODO: Error handling.
    }
  }

  Future<File> writeWorkouts(List<Workout> workouts) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString('$workouts');
  }

  Future<List<Workout>> readWorkouts() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      print(contents);
    } catch (e) {
      // TODO: Error handling.
    }
  }

  Future<List<Workout>> getWorkouts() {}
}
