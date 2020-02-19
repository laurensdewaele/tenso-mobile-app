import 'package:flutter/cupertino.dart';

import 'package:app/helpers/total_hangs.dart';
import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/workout.dart';
import 'package:app/styles/styles.dart' as styles;

abstract class Titles {
  static const String preparation = 'preparation';
  static const String hang = 'hang';
  static const String restBetweenHolds = 'rest between holds';
  static const String restBetweenSets = 'rest between sets';
}

abstract class HoldLabels {
  static const String nextUp = 'next up';
  static const String hang = 'hang';
}

class SequenceModel {
  SequenceModel(
      {@required this.color,
      @required this.title,
      @required this.duration,
      @required this.holdLabel,
      @required this.board,
      @required this.leftGrip,
      @required this.rightGrip,
      @required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.totalSets,
      @required this.currentSet,
      @required this.totalHangsPerSet,
      @required this.currentHang});

  final Color color;
  final String title;
  final int duration;
  final String holdLabel;
  final Board board;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final int totalSets;
  final int currentSet;
  final int totalHangsPerSet;
  final int currentHang;
}

class CountdownViewModel extends ChangeNotifier {
  CountdownViewModel(Workout workout, Settings settings) {
    _workout = workout;
    _settings = settings;
    _initialize();
  }

  Workout _workout;
  Settings _settings;
  List<SequenceModel> _sequence;

  Color color;
  String title;
  int remainingSeconds;
  String holdLabel;
  Board board;
  Grip leftGrip;
  Grip rightGrip;
  BoardHold leftGripBoardHold;
  BoardHold rightGripBoardHold;
  int totalSets;
  int currentSet;
  int totalHangsPerSet;
  int currentHang;

  void _initialize() {
    _addPreparationSequence();
    // Secondly, we need to generate all holds to need to be done.
    // This means looping over sets, than all the holds and we also need to
    // include the repetitions per hold.
    int _currentHang = 1;
    for (var _currentSet = 1; _currentSet <= _workout.sets; _currentSet++) {
      for (var _currentHold = 0;
          _currentHold < _workout.holds.length;
          _currentHold++) {
        for (var _currentRepetitionPerHold = 1;
            _currentRepetitionPerHold <=
                _workout.holds[_currentHold].repetitions;
            _currentRepetitionPerHold++) {
          _addHoldSequence(_currentSet, _currentHold, _currentHang);

          // Only add a rest between repetitions if there's:
          // - More than 1 rep
          // - Not the last rep
          if (_workout.holds[_currentHold].repetitions > 1 &&
              _currentRepetitionPerHold <
                  _workout.holds[_currentHold].repetitions) {
            _addHoldRepetitionRestSequence(
                _currentSet, _currentHold, _currentHang);
          }

          _currentHang++;
        }

        // At this point we've added all the hold reps and their rest
        // (restBetweenRepetitions)

        // Now we need to add a rest between holds.
        // Only add a rest between holds if there's:
        // - More than 1 hold
        // - Not the last hold

        if (_workout.holds.length > 1 &&
            _currentHold < _workout.holds.length - 1) {
          _addHoldRestSequence(_currentSet, _currentHold, _currentHang);
        }
      }

      // Now we need to add a rest between sets.
      // Only add a rest between sets if there's:
      // - More than 1 set
      // - Not the last set

      if (_workout.sets > 1 && _currentSet < _workout.sets) {
        _addSetRestSequence(_currentSet, _currentHang);
      }
    }

    _initializeSequence();
  }

  void stop() {}
  void pause() {}
  void start() {}

  void _initializeSequence() {
    // I need the timer to be accessible to other methods
    // When countdown reaches zero it must trigger a method that
    // resets the timer and continues on the sequence.
    // Not going to figure this out myself => WIFI (plane now)
  }

  void _addPreparationSequence() {
    _sequence.add(
      SequenceModel(
          color: styles.Colors.blue,
          title: Titles.preparation,
          duration: _settings.preparationTimer,
          holdLabel: HoldLabels.nextUp,
          board: _workout.board,
          leftGrip: _workout.holds[0].leftGrip,
          rightGrip: _workout.holds[0].rightGrip,
          leftGripBoardHold: _workout.holds[0].leftGripBoardHold,
          rightGripBoardHold: _workout.holds[0].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: 1,
          currentHang: 1,
          totalHangsPerSet: getTotalHangs(_workout.holds.toList())),
    );
  }

  void _addHoldSequence(int _currentSet, int _currentHold, int _currentHang) {
    _sequence.add(
      SequenceModel(
          color: styles.Colors.primary,
          title: Titles.hang,
          duration: _workout.holds[_currentHold].hangTime,
          holdLabel: HoldLabels.hang,
          board: _workout.board,
          leftGrip: _workout.holds[_currentHold].leftGrip,
          rightGrip: _workout.holds[_currentHold].rightGrip,
          leftGripBoardHold: _workout.holds[_currentHold].leftGripBoardHold,
          rightGripBoardHold: _workout.holds[_currentHold].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHang,
          totalHangsPerSet: getTotalHangs(_workout.holds.toList())),
    );
  }

  void _addHoldRepetitionRestSequence(
      int _currentSet, int _currentHold, int _currentHang) {
    _sequence.add(
      SequenceModel(
          color: styles.Colors.blue,
          title: Titles.restBetweenHolds,
          duration: _workout.holds[_currentHold].restBetweenRepetitions,
          holdLabel: HoldLabels.nextUp,
          board: _workout.board,
          leftGrip: _workout.holds[_currentHold].leftGrip,
          rightGrip: _workout.holds[_currentHold].rightGrip,
          leftGripBoardHold: _workout.holds[_currentHold].leftGripBoardHold,
          rightGripBoardHold: _workout.holds[_currentHold].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHang,
          totalHangsPerSet: getTotalHangs(_workout.holds.toList())),
    );
  }

  void _addHoldRestSequence(
      int _currentSet, int _currentHold, int _currentHang) {
    _sequence.add(
      SequenceModel(
          color: styles.Colors.blue,
          title: Titles.restBetweenHolds,
          duration: _workout.restBetweenHolds,
          holdLabel: HoldLabels.nextUp,
          board: _workout.board,
          leftGrip: _workout.holds[_currentHold + 1].leftGrip,
          rightGrip: _workout.holds[_currentHold + 1].rightGrip,
          leftGripBoardHold: _workout.holds[_currentHold + 1].leftGripBoardHold,
          rightGripBoardHold:
              _workout.holds[_currentHold + 1].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHang,
          totalHangsPerSet: getTotalHangs(_workout.holds.toList())),
    );
  }

  void _addSetRestSequence(int _currentSet, int _currentHang) {
    _sequence.add(
      SequenceModel(
          color: styles.Colors.blue,
          title: Titles.restBetweenSets,
          duration: _workout.restBetweenSets,
          holdLabel: HoldLabels.nextUp,
          board: _workout.board,
          leftGrip: _workout.holds[0].leftGrip,
          rightGrip: _workout.holds[0].rightGrip,
          leftGripBoardHold: _workout.holds[0].leftGripBoardHold,
          rightGripBoardHold: _workout.holds[0].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHang,
          totalHangsPerSet: getTotalHangs(_workout.holds.toList())),
    );
  }
}
