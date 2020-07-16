import 'package:flutter/foundation.dart';
import 'package:tenso_app/helpers/unique_id.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/services/toast.service.dart';
import 'package:tenso_app/state/completed_workouts.state.dart';
import 'package:tenso_app/state/settings.state.dart';
import 'package:tenso_app/widgets/toast_message.dart';

class RateWorkoutViewModel {
  RateWorkoutViewModel() {
    _completedWorkoutsState = CompletedWorkoutsState();
    _tempUnit = SettingsState().settings.tempUnit;
    _toastService = ToastService();
  }

  CompletedWorkoutsState _completedWorkoutsState;
  TempUnit _tempUnit;
  TempUnit get tempUnit => _tempUnit;
  ToastService _toastService;

  int _perceivedExertion;
  double _bodyWeight;
  String _bodyWeightInput;
  double _temperature;
  String _temperatureInput;
  double _humidity;
  String _humidityInput;
  String _comments;
  String _commentsInput;

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

  bool completeWorkout({@required Workout workout, @required History history}) {
    if (_validateAll() == false) {
      return false;
    } else {
      _saveCompletedWorkout(workout, history);
      return true;
    }
  }

  bool _validateAll() {
    if (_validateBodyWeight() == false) {
      return false;
    }
    if (_validateTemperature() == false) {
      return false;
    }
    if (_validateHumidity() == false) {
      return false;
    }
    if (_validateComments() == false) {
      return false;
    }
    return true;
  }

  bool _validateBodyWeight() {
    // Empty or > 0
    if (_bodyWeightInput == null || _bodyWeightInput.trim() == '') {
      _bodyWeight = null;
      return true;
    } else {
      _bodyWeight = _parseStringToDouble(_bodyWeightInput, 'body weight');
      if (_bodyWeight == null) {
        return false;
      }
      if (_bodyWeight == 0) {
        _bodyWeight = null;
        return true;
      }
      if (_bodyWeight < 0) {
        _smallerThanZeroException('body weight');
        return false;
      }
      return true;
    }
  }

  bool _validateTemperature() {
    // Empty or any value
    if (_temperatureInput == null || _temperatureInput.trim() == '') {
      _temperature = null;
      return true;
    } else {
      _temperature = _parseStringToDouble(_temperatureInput, 'temperature');
      if (_temperature == null) {
        return false;
      }
      return true;
    }
  }

  bool _validateHumidity() {
    // Humidity => 0 - 100  or empty
    if (_humidityInput == null || _humidityInput.trim() == '') {
      _humidity = null;
      return true;
    } else {
      _humidity = _parseStringToDouble(_humidityInput, 'humidity');
      if (_humidity == null) {
        return false;
      }
      if (_humidity < 0) {
        _smallerThanZeroException('humdity');
        return false;
      }
      if (_humidity > 100) {
        _largerThanException(100, 'humdity');
        return false;
      }
      return true;
    }
  }

  bool _validateComments() {
    if (_commentsInput == null || _commentsInput.trim() == '') {
      _comments = null;
      return true;
    } else {
      _comments = _commentsInput;
      return true;
    }
  }

  double _parseStringToDouble(String s, String variable) {
    double value;
    try {
      value = double.parse(s.trim());
    } on FormatException catch (_) {
      _formatException(variable);
    }
    return value;
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

  void _formatException(String variable) {
    _toastService.add(ToastMessages.inputNotANumber());
  }

  void _smallerThanZeroException(String inputField) {
    _toastService
        .add(ToastMessages.inputSmallerThanZero(inputField: inputField));
  }

  void _largerThanException(int max, String inputField) {
    _toastService
        .add(ToastMessages.inputLargerThan(max: max, inputField: inputField));
  }
}
