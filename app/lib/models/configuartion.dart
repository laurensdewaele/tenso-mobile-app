class Configuration {
  const Configuration({this.generalConfiguration, this.holdConfiguration});

  final GeneralConfiguration generalConfiguration;
  final HoldConfiguration holdConfiguration;
}

class GeneralConfiguration {
  const GeneralConfiguration(
      {this.holdAmount,
      this.repetitions,
      this.sets,
      this.restBetweenHolds,
      this.restBetweenRepetitions,
      this.restBetweenSets,
      this.board,
      this.hangTime,
      this.difficulty,
      this.name});

  // BASICS
  final bool holdAmount;
  final bool repetitions;
  final bool sets;

  // TIMERS
  final bool restBetweenHolds;
  final bool restBetweenRepetitions;
  final bool restBetweenSets;
  final bool hangTime;

  // BOARD
  final bool board;

  // DIFFICULTY
  final bool difficulty;

  // NAME
  final bool name;
}

class HoldConfiguration {
  const HoldConfiguration(
      {this.basicGrips,
      this.advancedGrips,
      this.pockets,
      this.repetitions,
      this.hangTime,
      this.restBetweenRepetitions,
      this.addedWeight});
  // GRIPS
  final bool basicGrips;
  final bool advancedGrips;

  // POCKETS
  final bool pockets;

  // BASICS
  final bool repetitions;

  // TIMERS
  final bool hangTime;
  final bool restBetweenRepetitions;

  // ADDED WEIGHT
  final bool addedWeight;
}
