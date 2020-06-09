import 'package:app/data/grips.data.dart';
import 'package:app/helpers/nullable.dart';
import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/workout_2.screen.dart';
import 'package:app/services/navigation.service.dart';
import 'package:app/services/parser.service.dart';
import 'package:app/services/validation.service.dart';
import 'package:app/view_models/workout/group_state.vm.dart';
import 'package:app/view_models/workout/workout.vm.dart';
import 'package:flutter/cupertino.dart';

class GroupViewModel extends ChangeNotifier {
  Group _group;

  NavigationService _navigationService;

  GroupState _state;
  GroupState get state => _state;

  GroupViewModel(
      {Group group, WorkoutTypes workoutType, WeightSystem weightSystem}) {
    _group = group;
    _navigationService = NavigationService();

    GroupState _initialState;
    switch (workoutType) {
      case WorkoutTypes.newWorkout:
        _initialState = GroupState.addGroup(group, weightSystem);
        break;
      case WorkoutTypes.editWorkout:
        _initialState = GroupState.editGroup(group, weightSystem);
        break;
      case WorkoutTypes.viewWorkout:
        _initialState = GroupState.viewGroup(group, weightSystem);
        break;
    }
    _state = _initialState;
  }

  Future<bool> _validateAndNavigate() {
    return Future.sync(() {
      final _isValid = _validate();
      if (_isValid == true) {
        _navigationService.pushNamed(Routes.workoutScreen,
            arguments: WorkoutScreenGroupArguments(
                group: _group.rebuild((b) => b
                  ..board = state.board.toBuilder()
                  ..handHold = state.handHold
                  ..leftGrip = state.leftGrip.toBuilder()
                  ..rightGrip = state.rightGrip.toBuilder()
                  ..leftGripBoardHold = state.leftGripBoardHold.toBuilder()
                  ..rightGripBoardHold = state.rightGripBoardHold.toBuilder()
                  ..repeaters = state.repeaters
                  ..repetitions = state.repetitions
                  ..hangTimeS = state.hangTimeS
                  ..restBetweenRepsFixed = state.restBetweenRepsFixed
                  ..restBetweenRepsS = state.restBetweenRepsS
                  ..sets = state.sets
                  ..restBetweenSetsFixed = state.restBetweenSetsFixed
                  ..restBetweenSetsS = state.restBetweenSetsS
                  ..addedWeight = state.addedWeight)));
      }
      return _isValid;
    });
  }

  bool _validate() {
    final List<bool> _validations = [];

    final int _hangTimeS = InputParsers.parseToInt(
        string: state.hangTimeSInput, inputField: 'Hang time');
    _validations.add(Validators.biggerThanZero<int>(
        value: _hangTimeS, inputField: 'Hang time'));

    final int _repetitions = InputParsers.parseToInt(
        string: state.repetitionsInput, inputField: 'Repetitions');
    _validations.add(Validators.biggerThanZero<int>(
        value: _repetitions, inputField: 'Repetitions'));

    if (state.restBetweenRepsFixed == true) {
      final int _restBetweenRepsS = InputParsers.parseToInt(
          string: state.restBetweenRepsSInput,
          inputField: 'Rest between repetitions');
      _validations.add(Validators.biggerThanZero<int>(
          value: _restBetweenRepsS, inputField: 'Rest between repetitions'));
      _state = state.copyWith(restBetweenRepsS: _restBetweenRepsS);
    }

    if (state.repeaters == true) {
      final int _sets =
          InputParsers.parseToInt(string: state.setsInput, inputField: 'Sets');
      _validations.add(
          Validators.biggerThanZero<int>(value: _sets, inputField: 'Sets'));
      _state = state.copyWith(sets: _sets);
    }

    if (state.repeaters == true && state.restBetweenSetsFixed == true) {
      final int _restBetweenSetsS = InputParsers.parseToInt(
          string: state.restBetweenSetsSInput, inputField: 'Rest between sets');
      _validations.add(Validators.biggerThanZero<int>(
          value: _restBetweenSetsS, inputField: 'Rest between sets'));
      _state = state.copyWith(restBetweenSetsS: _restBetweenSetsS);
    }

    final double _addedWeight = InputParsers.parseToDouble(
        string: state.addedWeightInput, inputField: 'Added weight');
    _validations.add(_addedWeight != null);

    _state = state.copyWith(
        hangTimeS: _hangTimeS,
        repetitions: _repetitions,
        addedWeight: _addedWeight);

    return _validations.fold(true, (a, b) => a && b);
  }

  void setBoard(Board board) {
    _state = state.copyWith(board: board);
    notifyListeners();
  }

  void handleOneHandedTap(HandHold handHold) {
    if (handHold == HandHold.oneHandedRight) {
      setLeftGrip(null);
      setLeftGripBoardHold(null);
    }
    if (handHold == HandHold.oneHandedLeft) {
      setRightGrip(null);
      setRightGripBoardHold(null);
    }
    setHandHold(handHold);
  }

  void handleTwoHandedTap(HandHold handHold) {
    final BoardHold defaultLeftGripBoardHold = state.board.defaultLeftGripHold;
    final BoardHold defaultRightGripBoardHold =
        state.board.defaultRightGripHold;
    final _boardHolds = state.board.boardHolds.toList();

    if (state.leftGrip == null) {
      final BoardHold _inUseBoardHold = state.rightGripBoardHold;
      BoardHold _boardHold;
      if (_inUseBoardHold != defaultLeftGripBoardHold) {
        _boardHold = defaultLeftGripBoardHold;
      } else {
        _boardHold = _boardHolds
            .firstWhere((BoardHold boardHold) => boardHold != _inUseBoardHold);
      }
      setLeftGripBoardHold(_boardHold);
      setLeftGrip(Grips.matchSupportedFingersL(_boardHold.supportedFingers));
    }

    if (state.rightGrip == null) {
      final BoardHold _inUseBoardHold = state.leftGripBoardHold;
      BoardHold _boardHold;
      if (_inUseBoardHold != defaultRightGripBoardHold) {
        _boardHold = defaultRightGripBoardHold;
      } else {
        _boardHold = _boardHolds
            .firstWhere((BoardHold boardHold) => boardHold != _inUseBoardHold);
      }
      setRightGripBoardHold(_boardHold);
      setRightGrip(Grips.matchSupportedFingersR(_boardHold.supportedFingers));
    }
    setHandHold(handHold);
  }

  void handleLeftHandSelected(HandHold handHold) {
    if (handHold == HandHold.oneHandedLeft && state.leftGrip == null) {
      setLeftGrip(Grips.openHandL);
      setLeftGripBoardHold(state.board.defaultLeftGripHold);
    }
    if (handHold == HandHold.oneHandedLeft) {
      setRightGrip(null);
      setRightGripBoardHold(null);
    }
    setHandHold(handHold);
  }

  void handleRightHandSelected(HandHold handHold) {
    if (handHold == HandHold.oneHandedRight && state.rightGrip == null) {
      setRightGrip(Grips.openHandR);
      setRightGripBoardHold(state.board.defaultRightGripHold);
    }

    if (handHold == HandHold.oneHandedRight) {
      setLeftGrip(null);
      setLeftGripBoardHold(null);
    }
    setHandHold(handHold);
  }

  void handleRightGripSelected(Grip grip) async {
    final BoardHold _rightGripBoardHold = state.rightGripBoardHold;
    if (Validators.checkGripCompatibility(
            boardHold: _rightGripBoardHold, grip: grip) ==
        true) {
      setRightGrip(grip);
    }
    return Future.value();
  }

  void handleLeftGripSelected(Grip grip) async {
    final BoardHold _leftGripBoardHold = state.leftGripBoardHold;
    if (Validators.checkGripCompatibility(
            boardHold: _leftGripBoardHold, grip: grip) ==
        true) {
      setLeftGrip(grip);
    }
    return Future.value();
  }

  void setHandHold(HandHold handHold) {
    _state = state.copyWith(handHold: handHold);
    notifyListeners();
  }

  void setLeftGrip(Grip grip) {
    _state = state.copyWith(leftGrip: Nullable<Grip>(grip));
    notifyListeners();
  }

  void setRightGrip(Grip grip) {
    _state = state.copyWith(rightGrip: Nullable<Grip>(grip));
    notifyListeners();
  }

  void setLeftGripBoardHold(BoardHold boardHold) {
    _state = state.copyWith(leftGripBoardHold: Nullable<BoardHold>(boardHold));
    notifyListeners();
  }

  void setRightGripBoardHold(BoardHold boardHold) {
    _state = state.copyWith(rightGripBoardHold: Nullable<BoardHold>(boardHold));
    notifyListeners();
  }

  void toggleRepeaters(bool active) {
    if (active == true) {
      _state = state.copyWith(
        repeaters: true,
        restBetweenRepsFixed: true,
        restBetweenRepsS: 3,
        restBetweenRepsSInput: '3',
      );
    } else {
      _state = state.copyWith(
        repeaters: false,
        restBetweenRepsFixed: true,
        restBetweenRepsS: 180,
        restBetweenRepsSInput: '180',
      );
    }
    notifyListeners();
  }

  void setRepetitions(String repetitionsInput) {
    _state = state.copyWith(repetitionsInput: repetitionsInput);
  }

  void setHangTimeS(String hangTimeSInput) {
    _state = state.copyWith(hangTimeSInput: hangTimeSInput);
  }

  void setRestBetweenRepsFixed() {
    _state = state.copyWith(restBetweenRepsFixed: true);
    notifyListeners();
  }

  void setRestBetweenRepsVariable() {
    _state = state.copyWith(restBetweenRepsFixed: false);
    notifyListeners();
  }

  void setRestBetweenRepsS(String restBetweenRepsSInput) {
    _state = state.copyWith(restBetweenRepsSInput: restBetweenRepsSInput);
  }

  void setSets(String setsInput) {
    _state = state.copyWith(setsInput: setsInput);
  }

  void setRestBetweenSetsFixed() {
    _state = state.copyWith(restBetweenSetsFixed: true);
    notifyListeners();
  }

  void setRestBetweenSetsVariable() {
    _state = state.copyWith(restBetweenSetsFixed: false);
    notifyListeners();
  }

  void setRestBetweenSetsS(String restBetweenSetsSInput) {
    _state = state.copyWith(restBetweenSetsSInput: restBetweenSetsSInput);
  }

  void setAddedWeight(String addedWeightInput) {
    _state = state.copyWith(addedWeightInput: addedWeightInput);
  }
}
