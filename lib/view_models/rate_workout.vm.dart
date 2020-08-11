import 'package:flutter/foundation.dart';
import 'package:tenso_app/helpers/unique_id.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/services/parser.service.dart';
import 'package:tenso_app/services/validation.service.dart';
import 'package:tenso_app/state/completed_workouts.state.dart';
import 'package:tenso_app/state/settings.state.dart';

class RateWorkoutViewModel {
  RateWorkoutViewModel({String comments}) {
    _navigationService = NavigationService();
    _commentsInput = comments;
    _completedWorkoutsState = CompletedWorkoutsState();
    _tempUnit = SettingsState().settings.tempUnit;
  }

  NavigationService _navigationService;
  CompletedWorkoutsState _completedWorkoutsState;
  TempUnit _tempUnit;
  TempUnit get tempUnit => _tempUnit;

  int _perceivedExertion;
  double _bodyWeight;
  String _bodyWeightInput;
  double _temperature;
  String _temperatureInput;
  double _humidity;
  String _humidityInput;
  String _comments;
  String _commentsInput;
  String get initialComments => _commentsInput;

  void setPerceivedExertion(int n) {
    _perceivedExertion = n;
  }

  void setBodyWeight(String s) {
    _bodyWeightInput = s;
  }

  void setTemperature(String s) {
    _temperatureInput = s;
  }

  void setHumidity(String s) {
    _humidityInput = s;
  }

  void setComments(String s) {
    _commentsInput = s;
  }

  Future<bool> completeWorkout(
      {@required Workout workout, @required History history}) {
    return Future.sync(() async {
      final bool _isValid = _validateAll();
      if (_isValid == true) {
        _saveCompletedWorkout(workout, history);
        _navigationService.pushNamed(Routes.workoutOverviewScreen);
      }
      return _isValid;
    });
  }

  bool _validateAll() {
    final List<bool> _validations = [];

    if (_bodyWeightInput != null && _bodyWeightInput != '') {
      _bodyWeight = InputParsers.parseToDouble(
          string: _bodyWeightInput, inputField: 'body weight');
      _validations.add(Validators.biggerThanZero(
          value: _bodyWeight, inputField: 'body weight'));
    }

    if (_temperatureInput != null && _temperatureInput != '') {
      _temperature = InputParsers.parseToDouble(
          string: _temperatureInput, inputField: 'temperature');
      _validations.add(Validators.betweenRange<double>(
          min: -1000,
          max: 1000,
          value: _temperature,
          inputField: 'temperature'));
    }

    if (_humidityInput != null && _humidityInput != '') {
      _humidity = InputParsers.parseToDouble(
          string: _humidityInput, inputField: 'humidity');
      _validations.add(Validators.betweenRange<double>(
          min: 0, max: 100, value: _humidity, inputField: 'humidity'));
    }

    if (_commentsInput != null) {
      _comments = InputParsers.parseString(string: _commentsInput);
    }

    return _validations.fold(true, (a, b) => a && b);
  }

  void _saveCompletedWorkout(Workout workout, History history) {
    final CompletedWorkout completedWorkout = CompletedWorkout((b) => b
      ..history = history.toBuilder()
      ..workout = workout.toBuilder()
      ..perceivedExertion = _perceivedExertion
      ..bodyWeight = _bodyWeight
      ..temperature = _temperature
      ..tempUnit = _tempUnit
      ..humidity = _humidity
      ..comments = _comments
      ..completedDate = DateTime.now().toUtc()
      ..id = generateUniqueId());

    _completedWorkoutsState.addCompletedWorkout(completedWorkout);
  }
}
