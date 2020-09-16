import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/completed_workout.model.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/completed_workout/edit_completed_workout_state.vm.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/services/parser.service.dart';
import 'package:tenso_app/services/validation.service.dart';
import 'package:tenso_app/state/completed_workouts.state.dart';

class EditCompletedWorkoutViewModel {
  CompletedWorkout _completedWorkout;
  CompletedWorkoutsState _completedWorkoutsState;
  NavigationService _navigationService;
  EditCompletedWorkoutViewModelState _state;
  EditCompletedWorkoutViewModelState get state => _state;

  EditCompletedWorkoutViewModel({CompletedWorkout completedWorkout}) {
    _completedWorkoutsState = CompletedWorkoutsState();
    _navigationService = NavigationService();
    _completedWorkout = completedWorkout;
    _state = EditCompletedWorkoutViewModelState(
        comments:
            completedWorkout.comments == null ? '' : completedWorkout.comments,
        commentsInput:
            completedWorkout.comments == null ? '' : completedWorkout.comments,
        bodyWeight: completedWorkout.bodyWeight,
        bodyWeightInput: completedWorkout.bodyWeight?.toString(),
        humidity: completedWorkout.humidity,
        humidityInput: completedWorkout.humidity?.toString(),
        tempUnit: completedWorkout.tempUnit,
        temperature: completedWorkout.temperature,
        temperatureInput: completedWorkout.temperature?.toString(),
        perceivedExertion: completedWorkout.perceivedExertion);
  }

  handleBodyWeightChanged(String bodyWeightInput) {
    _state = state.copyWith(bodyWeightInput: bodyWeightInput);
  }

  handleCommentsChanged(String commentsInput) {
    _state = state.copyWith(commentsInput: commentsInput);
  }

  handleHumidityChanged(String humidityInput) {
    _state = state.copyWith(humidityInput: humidityInput);
  }

  handlePerceivedExertionChanged(int perceivedExertion) {
    _state = state.copyWith(perceivedExertion: perceivedExertion);
  }

  handleTemperatureChanged(String temperatureInput) {
    _state = state.copyWith(temperatureInput: temperatureInput);
  }

  void handleBackNavigation() {
    handleCompleteTap();
  }

  Future<bool> handleCompleteTap() {
    return Future.sync(() async {
      final bool _isValid = _validateAll();
      if (_isValid == true) {
        _saveEditedCompletedWorkout();
        _navigationService.pop();
      }
      return _isValid;
    });
  }

  void _saveEditedCompletedWorkout() {
    final CompletedWorkout _editedCompletedWorkout =
        _completedWorkout.rebuild((b) => b
          ..comments = state.comments
          ..humidity = state.humidity
          ..temperature = state.temperature
          ..bodyWeight = state.bodyWeight
          ..perceivedExertion = state.perceivedExertion
          ..tempUnit = state.tempUnit);
    _completedWorkoutsState.editCompletedWorkout(_editedCompletedWorkout);
  }

  bool _validateAll() {
    final List<bool> _validations = [];

    if (state.bodyWeightInput != null && state.bodyWeightInput != '') {
      final double _bodyWeight = InputParsers.parseToDouble(
          string: state.bodyWeightInput, inputField: 'body weight');
      _state = state.copyWith(bodyWeight: Nullable(_bodyWeight));
      _validations.add(Validators.biggerThanZero(
          value: _bodyWeight, inputField: 'body weight'));
    } else {
      _state = state.copyWith(bodyWeight: Nullable(null));
    }

    if (state.temperatureInput != null && state.temperatureInput != '') {
      final double _temperature = InputParsers.parseToDouble(
          string: state.temperatureInput, inputField: 'temperature');
      _state = state.copyWith(temperature: Nullable(_temperature));
      _validations.add(Validators.betweenRange<double>(
          min: -1000,
          max: 1000,
          value: _temperature,
          inputField: 'temperature'));
    } else {
      _state = state.copyWith(temperature: Nullable(null));
    }

    if (state.humidityInput != null && state.humidityInput != '') {
      final double _humidity = InputParsers.parseToDouble(
          string: state.humidityInput, inputField: 'humidity');
      _state = state.copyWith(humidity: Nullable(_humidity));
      _validations.add(Validators.betweenRange<double>(
          min: 0, max: 100, value: _humidity, inputField: 'humidity'));
    } else {
      _state = state.copyWith(humidity: Nullable(null));
    }

    if (state.commentsInput != null && state.commentsInput != '') {
      final String _comments =
          InputParsers.parseString(string: state.commentsInput);
      _state = state.copyWith(comments: Nullable(_comments));
    } else {
      _state = state.copyWith(comments: Nullable(null));
    }

    return _validations.fold(true, (a, b) => a && b);
  }
}
