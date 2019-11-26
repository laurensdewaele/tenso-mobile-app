import 'package:flutter/cupertino.dart';

import 'package:app/models/grips.dart';

class WorkoutSection {
  WorkoutSection({this.title, this.workoutElements});

  final String title;
  final List<WorkoutElement> workoutElements;
}

class WorkoutElement {
  WorkoutElement(
      {this.generalWorkoutConfigurationProperty,
      this.holdWorkoutConfigurationProperty,
      this.extraWorkoutConfigurationProperty,
      this.workoutInputType,
      this.initialIntValue,
      this.minIntValue,
      this.maxIntValue,
      this.initialStringValue,
      this.initialGripPickerValue,
      this.initialHoldPickerValue,
      this.description,
      this.handleValueChanged});

  final WorkoutInputTypes workoutInputType;
  final int minIntValue;
  final int maxIntValue;
  final int initialIntValue;
  final String initialStringValue;
  final Grips initialGripPickerValue;
  final HoldPickerValue initialHoldPickerValue;
  final String description;
  final GeneralWorkoutConfigurationProperties
      generalWorkoutConfigurationProperty;
  final HoldWorkoutConfigurationProperties holdWorkoutConfigurationProperty;
  final ExtraWorkoutConfigurationProperties extraWorkoutConfigurationProperty;
  final VoidCallback handleValueChanged;
}

enum WorkoutInputTypes { number, gripPicker, holdPicker, text }

class HoldPickerValue {
  HoldPickerValue(
      {this.grip,
      this.pockets,
      this.twoHanded,
      this.oneHandLeft,
      this.oneHandRight});

  final Grips grip;
  final List<int> pockets;
  final bool twoHanded;
  final bool oneHandLeft;
  final bool oneHandRight;
}

final List<WorkoutSection> basicGeneralConfiguration = [
  WorkoutSection(title: 'Basics', workoutElements: [
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.holdAmount,
        workoutInputType: WorkoutInputTypes.number,
        description: 'different holds',
        initialIntValue: 5),
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.repetitions,
        workoutInputType: WorkoutInputTypes.number,
        description: 'repetitions per hold',
        initialIntValue: 5),
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.sets,
        workoutInputType: WorkoutInputTypes.number,
        description: 'sets',
        initialIntValue: 3),
  ]),
  WorkoutSection(title: 'Timers', workoutElements: [
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.restBetweenRepetitions,
        workoutInputType: WorkoutInputTypes.number,
        description: 'rest seconds between repetitions',
        initialIntValue: 30),
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.restBetweenSets,
        workoutInputType: WorkoutInputTypes.number,
        description: 'rest seconds between sets',
        initialIntValue: 120),
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.hangTime,
        workoutInputType: WorkoutInputTypes.number,
        description: 'hang time seconds',
        initialIntValue: 7),
  ])
];

enum GeneralWorkoutConfigurationProperties {
  holdAmount,
  repetitions,
  sets,
  restBetweenRepetitions,
  restBetweenSets,
  board,
  hangTime
}

enum HoldWorkoutConfigurationProperties {
  basicGrips,
  advancedGrips,
  twoHanded,
  oneHandLeft,
  oneHandRight,
  pockets,
  repetitions,
  hangTime,
  restBetweenRepetitions,
  restBetweenHolds,
  addedWeight
}

enum ExtraWorkoutConfigurationProperties { difficulty, name }

//
//final GeneralConfiguration basicGeneralConfiguration = GeneralConfiguration(
//    holdAmount: true,
//    repetitions: true,
//    sets: true,
//    restBetweenRepetitions: true,
//    restBetweenSets: true,
//    hangTime: true);
//
//final HoldConfiguration basicHoldConfiguration =
//HoldConfiguration(basicGrips: true, pockets: true);
//
//final ExtraConfiguration basicExtraConfiguration =
//ExtraConfiguration(difficulty: true, name: true);
//
//
//class NewWorkoutUIConfiguration {
//  NewWorkoutUIConfiguration._();
//
//  GeneralConfiguration _generalConfiguration = basicGeneralConfiguration;
//  HoldConfiguration _holdConfiguration = basicHoldConfiguration;
//  ExtraConfiguration _extraConfiguration = basicExtraConfiguration;
//
//  GeneralConfiguration get generalConfiguration => _generalConfiguration;
//  HoldConfiguration get holdConfiguration => _holdConfiguration;
//  ExtraConfiguration get extraConfiguration => _extraConfiguration;
//
//  void toggleGrips(bool advancedGrips) {
//    _holdConfiguration.basicGrips = !advancedGrips;
//    _holdConfiguration.advancedGrips = advancedGrips;
//  }
//
//  void toggleBoardSelection(bool board) {
//    _generalConfiguration.board = board;
//  }
//
//  void toggleAddedWeight(bool addedWeight) {
//    _holdConfiguration.addedWeight = addedWeight;
//  }
//
//  void toggleOneHanded(bool oneHanded) {
//    _holdConfiguration.oneHanded = oneHanded;
//  }
//
//  void toggleVariableRepetitions(bool variableRepetitions) {
//    _generalConfiguration.repetitions = !variableRepetitions;
//    _holdConfiguration.repetitions = variableRepetitions;
//  }
//
//  void toggleAdvancedTimers(bool advancedTimers) {
//    _generalConfiguration.hangTime = !advancedTimers;
//    _generalConfiguration.restBetweenRepetitions = !advancedTimers;
//
//    _holdConfiguration.hangTime = advancedTimers;
//    _holdConfiguration.restBetweenRepetitions = advancedTimers;
//    _holdConfiguration.restBetweenHolds = advancedTimers;
//  }
//}

//
//
//
//
//
//class NewWorkoutUIConfiguration {
//  NewWorkoutUIConfiguration._();
//
//  GeneralConfiguration _generalConfiguration = basicGeneralConfiguration;
//  HoldConfiguration _holdConfiguration = basicHoldConfiguration;
//  ExtraConfiguration _extraConfiguration = basicExtraConfiguration;
//
//  GeneralConfiguration get generalConfiguration => _generalConfiguration;
//  HoldConfiguration get holdConfiguration => _holdConfiguration;
//  ExtraConfiguration get extraConfiguration => _extraConfiguration;
//
//  void toggleGrips(bool advancedGrips) {
//    _holdConfiguration.basicGrips = !advancedGrips;
//    _holdConfiguration.advancedGrips = advancedGrips;
//  }
//
//  void toggleBoardSelection(bool board) {
//    _generalConfiguration.board = board;
//  }
//
//  void toggleAddedWeight(bool addedWeight) {
//    _holdConfiguration.addedWeight = addedWeight;
//  }
//
//  void toggleOneHanded(bool oneHanded) {
//    _holdConfiguration.oneHanded = oneHanded;
//  }
//
//  void toggleVariableRepetitions(bool variableRepetitions) {
//    _generalConfiguration.repetitions = !variableRepetitions;
//    _holdConfiguration.repetitions = variableRepetitions;
//  }
//
//  void toggleAdvancedTimers(bool advancedTimers) {
//    _generalConfiguration.hangTime = !advancedTimers;
//    _generalConfiguration.restBetweenRepetitions = !advancedTimers;
//
//    _holdConfiguration.hangTime = advancedTimers;
//    _holdConfiguration.restBetweenRepetitions = advancedTimers;
//    _holdConfiguration.restBetweenHolds = advancedTimers;
//  }
//}
//
//final GeneralConfiguration basicGeneralConfiguration = GeneralConfiguration(
//    holdAmount: true,
//    repetitions: true,
//    sets: true,
//    restBetweenRepetitions: true,
//    restBetweenSets: true,
//    hangTime: true);
//
//final HoldConfiguration basicHoldConfiguration =
//HoldConfiguration(basicGrips: true, pockets: true);
//
//final ExtraConfiguration basicExtraConfiguration =
//ExtraConfiguration(difficulty: true, name: true);
//
//class GeneralConfiguration {
//  GeneralConfiguration(
//      {this.holdAmount,
//        this.repetitions,
//        this.sets,
//        this.restBetweenRepetitions,
//        this.restBetweenSets,
//        this.board,
//        this.hangTime});
//
//
//
//  bool holdAmount;
//  bool repetitions;
//  bool sets;
//  bool restBetweenRepetitions;
//  bool restBetweenSets;
//  bool hangTime;
//  bool board;
//}
//
//class HoldConfiguration {
//  HoldConfiguration(
//      {this.basicGrips,
//        this.advancedGrips,
//        this.oneHanded,
//        this.pockets,
//        this.repetitions,
//        this.hangTime,
//        this.restBetweenRepetitions,
//        this.restBetweenHolds,
//        this.addedWeight});
//
//  bool basicGrips;
//  bool advancedGrips;
//  bool oneHanded;
//  bool pockets;
//  bool repetitions;
//  bool hangTime;
//  bool restBetweenRepetitions;
//  bool restBetweenHolds;
//  bool addedWeight;
//}
//
//class ExtraConfiguration {
//  ExtraConfiguration({this.difficulty, this.name});
//
//  bool difficulty;
//  bool name;
//}
