



// This probably does not belong here but should be part of the state management
class Configuration {
  Configuration._();

  GeneralConfiguration _generalConfiguration = basicGeneralConfiguration;
  HoldConfiguration _holdConfiguration = basicHoldConfiguration;

  GeneralConfiguration get generalConfiguration => _generalConfiguration;
  HoldConfiguration get holdConfiguration => _holdConfiguration;

  void toggleGrips(bool advancedGrips) {
    _holdConfiguration.basicGrips = !advancedGrips;
    _holdConfiguration.advancedGrips = advancedGrips;
  }

  void toggleBoardSelection(bool board) {
    _generalConfiguration.board = board;
  }

  void toggleAddedWeight(bool addedWeight) {
    _holdConfiguration.addedWeight = addedWeight;
  }

  void toggleOneHanded(bool oneHanded) {
    _holdConfiguration.oneHanded = oneHanded;
  }

  void toggleVariableRepetitions(bool variableRepetitions) {
    _generalConfiguration.repetitions = !variableRepetitions;
    _holdConfiguration.repetitions = variableRepetitions;
  }

  void toggleAdvancedTimers(bool advancedTimers) {
    _generalConfiguration.hangTime = !advancedTimers;
    _generalConfiguration.restBetweenRepetitions = !advancedTimers;

    _holdConfiguration.hangTime = advancedTimers;
    _holdConfiguration.restBetweenRepetitions = advancedTimers;
    _holdConfiguration.restBetweenHolds = advancedTimers;
  }
}

final GeneralConfiguration basicGeneralConfiguration = GeneralConfiguration(
    holdAmount: true,
    repetitions: true,
    sets: true,
    restBetweenRepetitions: true,
    restBetweenSets: true,
    hangTime: true);

final HoldConfiguration basicHoldConfiguration =
    HoldConfiguration(basicGrips: true, pockets: true);

class GeneralConfiguration {
  GeneralConfiguration(
      {this.holdAmount,
      this.repetitions,
      this.sets,
      this.restBetweenRepetitions,
      this.restBetweenSets,
      this.board,
      this.hangTime,
      this.difficulty,
      this.name});

  // BASICS
  bool holdAmount;
  bool repetitions;
  bool sets;

  // TIMERS
  bool restBetweenRepetitions;
  bool restBetweenSets;
  bool hangTime;

  // BOARD
  bool board;

  // DIFFICULTY
  bool difficulty;

  // NAME
  bool name;
}

class HoldConfiguration {
  HoldConfiguration(
      {this.basicGrips,
      this.advancedGrips,
      this.oneHanded,
      this.pockets,
      this.repetitions,
      this.hangTime,
      this.restBetweenRepetitions,
      this.restBetweenHolds,
      this.addedWeight});
  // GRIPS
  bool basicGrips;
  bool advancedGrips;
  bool oneHanded;

  // POCKETS
  bool pockets;

  // BASICS
  bool repetitions;

  // TIMERS
  bool hangTime;
  bool restBetweenRepetitions;
  bool restBetweenHolds;

  // ADDED WEIGHT
  bool addedWeight;
}
