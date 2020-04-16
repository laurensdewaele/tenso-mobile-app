import 'package:app/helpers/unique_id.dart';
import 'package:app/models/models.dart';
import 'package:app/services/error.dart';
import 'package:app/services/toast.dart';
import 'package:app/state/app_state.dart';

class RateWorkoutViewModel {
  RateWorkoutViewModel(AppState appState, ToastService toastService) {
    _appState = appState;
    _toastService = toastService;
  }

  ToastService _toastService;
  AppState _appState;

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

  bool completeWorkout(Workout workout) {
    if (_validateAll() == false) {
      return false;
    } else {
      _saveCompletedWorkout(workout);
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

  void _saveCompletedWorkout(Workout workout) {
    final TempUnit _tempUnit = _appState?.settings?.tempUnit;

    final CompletedWorkout completedWorkout = CompletedWorkout((b) => b
      ..workout = workout.toBuilder()
      ..perceivedExertion = _perceivedExertion
      ..bodyWeight = _bodyWeight
      ..temperature = _temperature
      ..tempUnit = _tempUnit
      ..humidity = _humidity
      ..comments = _comments
      ..completedDate = DateTime.now().toUtc()
      ..id = generateUniqueId());

    final _completedWorkouts = _appState.completedWorkouts
        .rebuild((b) => b..completedWorkouts.add(completedWorkout));
    _setAndSaveCompletedWorkouts(_completedWorkouts);
  }

  void _setAndSaveCompletedWorkouts(CompletedWorkouts completedWorkouts) {
    _appState.setCompletedWorkouts(completedWorkouts);
    _appState.saveCompletedWorkouts(completedWorkouts);
  }

  // TODO: Redo
  void _formatException(String variable) {
    _toastService.add(ErrorMessages.inputNotANumber());
  }

  void _smallerThanZeroException(String inputField) {
    _toastService
        .add(ErrorMessages.inputSmallerThanZero(inputField: inputField));
  }

  void _largerThanException(int max, String inputField) {
    _toastService
        .add(ErrorMessages.inputLargerThan(max: max, inputField: inputField));
  }
}
