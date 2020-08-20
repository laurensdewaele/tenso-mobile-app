import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/completed_workout.model.dart';
import 'package:tenso_app/models/models.dart';

class EditCompletedWorkoutViewModelState {
  final String comments;
  final double humidity;
  final TempUnit tempUnit;
  final double temperature;
  final double bodyWeight;
  final int perceivedExertion;

  const EditCompletedWorkoutViewModelState(
      {@required this.comments,
      @required this.humidity,
      @required this.tempUnit,
      @required this.temperature,
      @required this.bodyWeight,
      @required this.perceivedExertion});
}

class EditCompletedWorkoutViewModel {
  CompletedWorkout _completedWorkout;
  EditCompletedWorkoutViewModelState _state;
  EditCompletedWorkoutViewModelState get state => _state;

  EditCompletedWorkoutViewModel({CompletedWorkout completedWorkout}) {
    _completedWorkout = completedWorkout;
    _state = EditCompletedWorkoutViewModelState(
        comments: completedWorkout.comments,
        humidity: completedWorkout.humidity,
        tempUnit: completedWorkout.tempUnit,
        temperature: completedWorkout.temperature,
        bodyWeight: completedWorkout.bodyWeight,
        perceivedExertion: completedWorkout.perceivedExertion);
  }

  handleBodyWeightChanged(String bodyWeightInput) {}
  handleCommentsChanged(String commentsInput) {}
  handleHumidityChanged(String humidityInput) {}
  handlePerceivedExertionChanged(int perceivedExertion) {}
  handleTemperatureChanged(String temperatureInput) {}
  handleCompleteTap() {}
}
