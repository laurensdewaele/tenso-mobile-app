import 'package:flutter/foundation.dart';

import 'package:app/models/hold.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workout_config.dart';

/// This

class WorkoutUIConfig {
  WorkoutUIConfig.fromWorkoutConfig(WorkoutConfig workoutConfig) {
    this._generalConfig = _generateGeneralConfig(workoutConfig.generalConfig);
    this._holdConfig =
        _generateHoldConfig(workoutConfig.holdConfig, workoutConfig.settings);
    this._extraConfig =
        _generateExtraConfig(workoutConfig.extraConfig, workoutConfig.settings);
  }

  List<WorkoutSection> get generalConfig => _generalConfig;
  List<WorkoutSection> get holdConfig => _holdConfig;
  List<WorkoutSection> get extraConfig => _extraConfig;

  List<WorkoutSection> _generalConfig;
  List<WorkoutSection> _holdConfig;
  List<WorkoutSection> _extraConfig;

  static List<WorkoutSection> _generateGeneralConfig(
      GeneralConfig generalConfig) {

    final Map<String, Map<String, bool>> config = generalConfig.toSectionedMap();
    return config.map<String, List<WorkoutElement>

    return [
      WorkoutSection(title: 'Basics', workoutElements: [
        generalConfig.holdAmount
            ? WorkoutElement(
                isFirst: true,
                workoutProperty: WorkoutProperties.holdAmount,
                workoutInputType: WorkoutInputTypes.number,
                description: 'different holds',
                initialValue: 5)
            : null,
        generalConfig.repetitions
            ? WorkoutElement(
                workoutProperty: WorkoutProperties.repetitions,
                workoutInputType: WorkoutInputTypes.number,
                description: 'repetitions per hold',
                initialValue: 5)
            : null,
        generalConfig.sets
            ? WorkoutElement(
                workoutProperty: WorkoutProperties.sets,
                workoutInputType: WorkoutInputTypes.number,
                description: 'sets',
                initialValue: 3)
            : null
      ]),
      WorkoutSection(title: 'Timers', workoutElements: [
        generalConfig.hangTime
            ? WorkoutElement(
                workoutProperty: WorkoutProperties.holds,
                holdProperty: HoldProperties.hangTime,
                workoutInputType: WorkoutInputTypes.number,
                description: 'hang time seconds',
                initialValue: 7)
            : null,
        generalConfig.restBetweenRepetitions
            ? WorkoutElement(
                workoutProperty: WorkoutProperties.restBetweenRepetitions,
                workoutInputType: WorkoutInputTypes.number,
                description: 'rest seconds between repetitions',
                initialValue: 30)
            : null,
        generalConfig.restBetweenHolds
            ? WorkoutElement(
                workoutProperty: WorkoutProperties.restBetweenHolds,
                workoutInputType: WorkoutInputTypes.number,
                description: 'rest seconds between holds',
                initialValue: 30)
            : null,
        generalConfig.restBetweenSets
            ? WorkoutElement(
                workoutProperty: WorkoutProperties.restBetweenSets,
                workoutInputType: WorkoutInputTypes.number,
                description: 'rest seconds between sets',
                initialValue: 120)
            : null
      ]),
      generalConfig.board
          ? WorkoutSection(title: 'Board', workoutElements: [
              WorkoutElement(
                  workoutProperty: WorkoutProperties.board,
                  workoutInputType: WorkoutInputTypes.boardPicker,
                  initialValue: null)
            ])
          : null
    ];
  }

  static List<WorkoutSection> _generateHoldConfig(
      HoldConfig holdConfig, Settings settings) {
    final bool hasBasics = holdConfig.repetitions;
    final bool hasTimers = holdConfig.restBetweenHolds ||
        holdConfig.restBetweenRepetitions ||
        holdConfig.hangTime;
    final bool hasAddedWeight = holdConfig.addedWeight;
    return [
      WorkoutSection(title: 'Choose grip', workoutElements: [
        holdConfig.basicGrips
            ? WorkoutElement(
                isFirst: true,
                workoutProperty: WorkoutProperties.holds,
                holdProperty: HoldProperties.grip,
                workoutInputType: WorkoutInputTypes.basicGripPicker,
                initialValue: null)
            : null,
        holdConfig.advancedGrips
            ? WorkoutElement(
                workoutProperty: WorkoutProperties.holds,
                holdProperty: HoldProperties.grip,
                workoutInputType: WorkoutInputTypes.advancedGripPicker,
                initialValue: null)
            : null,
        holdConfig.oneHanded
            ? WorkoutElement(
                workoutProperty: WorkoutProperties.holds,
                holdProperty: HoldProperties.handHold,
                workoutInputType: WorkoutInputTypes.handHoldPicker,
                initialValue: HandHolds.twoHanded)
            : null
      ]),
      WorkoutSection(title: 'Drag to choose holds', workoutElements: [
        WorkoutElement(
            workoutProperty: WorkoutProperties.holds,
            holdProperty: HoldProperties.boardHolds,
            workoutInputType: WorkoutInputTypes.holdPicker,
            initialValue: null),
      ]),
      hasBasics
          ? WorkoutSection(title: 'Basics', workoutElements: [
              holdConfig.repetitions
                  ? WorkoutElement(
                      workoutProperty: WorkoutProperties.holds,
                      holdProperty: HoldProperties.repetitions,
                      workoutInputType: WorkoutInputTypes.number,
                      description: 'repetitions',
                      initialValue: 4)
                  : null
            ])
          : null,
      hasTimers
          ? WorkoutSection(title: 'Timers', workoutElements: [
              holdConfig.hangTime
                  ? WorkoutElement(
                      workoutProperty: WorkoutProperties.holds,
                      holdProperty: HoldProperties.hangTime,
                      workoutInputType: WorkoutInputTypes.number,
                      description: 'hang time seconds',
                      initialValue: 7)
                  : null,
              holdConfig.restBetweenRepetitions
                  ? WorkoutElement(
                      workoutProperty: WorkoutProperties.holds,
                      holdProperty: HoldProperties.restBetweenRepetitions,
                      workoutInputType: WorkoutInputTypes.number,
                      description: 'rest seconds between repetitions',
                      initialValue: 7)
                  : null,
              holdConfig.restBetweenHolds
                  ? WorkoutElement(
                      workoutProperty: WorkoutProperties.holds,
                      holdProperty: HoldProperties.restBeforeNextHold,
                      workoutInputType: WorkoutInputTypes.number,
                      description: 'rest seconds before next hold',
                      initialValue: 7)
                  : null,
            ])
          : null,
      hasAddedWeight
          ? WorkoutSection(title: 'Added weight', workoutElements: [
              WorkoutElement(
                  workoutProperty: WorkoutProperties.holds,
                  holdProperty: HoldProperties.addedWeight,
                  workoutInputType: WorkoutInputTypes.number,
                  description: settings.unit.toString(),
                  initialValue: 200)
            ])
          : null
    ];
  }

  static List<WorkoutSection> _generateExtraConfig(
      ExtraConfig extraConfig, Settings settings) {
    return [
      extraConfig.difficulty
          ? WorkoutSection(title: 'Difficulty', workoutElements: [
              WorkoutElement(
                  isFirst: true,
                  workoutProperty: WorkoutProperties.difficulty,
                  workoutInputType: WorkoutInputTypes.text,
                  initialValue: null)
            ])
          : null,
      extraConfig.name
          ? WorkoutSection(title: 'Name', workoutElements: [
              WorkoutElement(
                  isFirst: extraConfig.difficulty ? false : true,
                  workoutProperty: WorkoutProperties.name,
                  workoutInputType: WorkoutInputTypes.text,
                  initialValue: null)
            ])
          : null,
    ];
  }
}

class WorkoutSection {
  WorkoutSection({this.title, this.workoutElements});

  final String title;
  List<WorkoutElement> workoutElements;
}

class WorkoutElement {
  WorkoutElement({
    this.description,
    this.isFirst = false,
    @required this.initialValue,
    this.holdProperty,
    @required this.workoutInputType,
    @required this.workoutProperty,
  });

  final String description;
  final bool isFirst;
  final dynamic initialValue;
  final HoldProperties holdProperty;
  final WorkoutInputTypes workoutInputType;
  final WorkoutProperties workoutProperty;
}

enum WorkoutInputTypes {
  advancedGripPicker,
  basicGripPicker,
  boardPicker,
  handHoldPicker,
  holdPicker,
  number,
  text
}
