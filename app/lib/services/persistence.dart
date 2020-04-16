import 'dart:io';

import 'package:app/data/basic_settings.dart';
import 'package:app/data/basic_workout.dart';
import 'package:app/models/models.dart';
import 'package:path_provider/path_provider.dart';

// TODO: PersistenceService should not be the one that sets defaultSettings and d defaultWorkout etc...
class PersistenceService {
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

  Future<File> get _localWorkoutsFile async {
    final path = await _localPath;
    return File('$path/workouts.txt');
  }

  Future<File> get _localCompletedWorkoutsFile async {
    final path = await _localPath;
    return File('$path/completed_workouts.txt');
  }

  Future<File> get _localSettingsFile async {
    final path = await _localPath;
    return File('$path/settings.txt');
  }

  Future<File> get _localDeviceInfoFile async {
    final path = await _localPath;
    return File('$path/device_info.txt');
  }

  Future<DeviceInfo> getDeviceInfo() async {
    DeviceInfo deviceInfo;
    try {
      final file = await _localDeviceInfoFile;
      String contents = await file.readAsString();
      deviceInfo = DeviceInfo.fromJson(contents);
    } catch (e) {
      print(e);
      // TODO: Error handling.
    }
    return deviceInfo == null
        ? DeviceInfo((b) => b..firstLaunch = true)
        : deviceInfo;
  }

  void saveDeviceInfo(DeviceInfo info) async {
    try {
      final file = await _localDeviceInfoFile;
      file.writeAsString(info.toJson().toString());
    } catch (e) {
      print(e);
      // TODO: Error handling
    }
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
    return workouts == null ? basicWorkouts : workouts;
  }

  void saveCompletedWorkouts(CompletedWorkouts completedWorkouts) async {
    try {
      final file = await _localCompletedWorkoutsFile;
      file.writeAsString(completedWorkouts.toJson().toString());
    } catch (e) {
      print(e);
      // TODO: Error handling.
    }
  }

  Future<CompletedWorkouts> getCompletedWorkouts() async {
    CompletedWorkouts completedWorkouts;
    try {
      final file = await _localCompletedWorkoutsFile;
      String contents = await file.readAsString();
      completedWorkouts = CompletedWorkouts.fromJson(contents);
    } catch (e) {
      print(e);
      // TODO: Error handling.
    }
    return completedWorkouts == null ? CompletedWorkouts() : completedWorkouts;
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
