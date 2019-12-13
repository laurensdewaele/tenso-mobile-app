import 'package:flutter/foundation.dart';

import 'package:app/data/boards/beastmaker_1000.dart';
import 'package:app/models/board.dart';
import 'package:app/models/sound.dart';

class Settings {
  Settings(
      {@required this.controlSettings,
      @required this.defaultBoard,
      @required this.grade,
      @required this.hangSound,
      @required this.preparationTimer,
      @required this.restSound,
      @required this.unit});

  Settings.basic() {
    this.defaultBoard = beastmaker1000;
    this.preparationTimer = 35;
    this.hangSound = Sound();
    this.restSound = Sound();
    this.controlSettings = ControlSettings.basic();
    this.unit = Units.metric;
    this.grade = Grades.sportFrench;
  }

  Settings.advanced() {
    this.defaultBoard = beastmaker1000;
    this.preparationTimer = 35;
    this.hangSound = Sound();
    this.restSound = Sound();
    this.controlSettings = ControlSettings.advanced();
    this.unit = Units.metric;
    this.grade = Grades.sportFrench;
  }

  Board defaultBoard;
  int preparationTimer;
  Sound hangSound;
  Sound restSound;
  ControlSettings controlSettings;
  Units unit;
  List<String> grade;
}

class ControlSettings {
  ControlSettings(
      {@required this.oneHanded,
      @required this.addedWeight,
      @required this.allGrips,
      @required this.boardSelection,
      @required this.advancedTimers,
      @required this.variableRepetitions});

  ControlSettings.basic() {
    this.allGrips = false;
    this.oneHanded = false;
    this.boardSelection = false;
    this.advancedTimers = false;
    this.addedWeight = false;
    this.variableRepetitions = false;
  }

  ControlSettings.advanced() {
    this.allGrips = true;
    this.oneHanded = true;
    this.boardSelection = true;
    this.advancedTimers = true;
    this.addedWeight = true;
    this.variableRepetitions = true;
  }

  bool allGrips;
  bool boardSelection;
  bool addedWeight;
  bool oneHanded;
  bool advancedTimers;
  bool variableRepetitions;
}

enum Units { imperial, metric }

abstract class Grades {
  static const List<String> sportFrench = [
    '1',
    '2',
    '3',
    '4',
    '5a',
    '5a+',
    '5b',
    '5b+',
    '5c',
    '5c+',
    '6a',
    '6a+',
    '6b',
    '6b+',
    '6c',
    '6c+',
    '7a',
    '7a+',
    '7b',
    '7b+',
    '7c',
    '7c+',
    '8a',
    '8a+',
    '8b',
    '8b+',
    '8c',
    '8c+',
    '9a',
    '9a+',
    '9b',
    '9b+',
    '9c'
  ];
  static const List<String> sportUSA = [
    '5.0',
    '5.1',
    '5.2',
    '5.3',
    '5.4',
    '5.5',
    '5.6',
    '5.7',
    '5.8',
    '5.9',
    '5.10a',
    '5.10b',
    '5.10c',
    '5.10d',
    '5.11a',
    '5.11b',
    '5.11c',
    '5.11d',
    '5.12a',
    '5.12b',
    '5.12c',
    '5.12d',
    '5.13a',
    '5.13b',
    '5.13c',
    '5.13d',
    '5.14a',
    '5.14b',
    '5.14c',
    '5.14d',
    '5.15a',
    '5.15b',
    '5.15c',
    '5.15d'
  ];
  static const List<String> boulderVScale = [
    'V0',
    'V1',
    'V2',
    'V3',
    'V4',
    'V4',
    'V5',
    'V6',
    'V7',
    'V8',
    'V9',
    'V10',
    'V11',
    'V12',
    'V13',
    'V14',
    'V15',
    'V16'
  ];
  static const List<String> boulderFont = [
    '1',
    '2',
    '3',
    '4a',
    '4b',
    '4c',
    '5a',
    '5a+',
    '5b',
    '5b+',
    '5c',
    '5c+',
    '6a',
    '6a+',
    '6b',
    '6b+',
    '6c',
    '6c+',
    '7a',
    '7a+',
    '7b',
    '7b+',
    '7c',
    '7c+',
    '8a',
    '8a+',
    '8b',
    '8b+',
    '8c',
    '8c+'
  ];
}
