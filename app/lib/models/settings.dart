import 'package:flutter/foundation.dart';

import 'package:app/data/boards/beastmaker_1000.dart';
import 'package:app/models/grades.dart';
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
