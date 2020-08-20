import 'package:flutter/foundation.dart';
import 'package:tenso_app/models/models.dart';

class EditCompletedWorkoutViewModelState {
  final String comments;
  final String commentsInput;
  final double humidity;
  final String humidityInput;
  final TempUnit tempUnit;
  final double temperature;
  final String temperatureInput;
  final double bodyWeight;
  final String bodyWeightInput;
  final int perceivedExertion;

  const EditCompletedWorkoutViewModelState({
    @required this.comments,
    @required this.commentsInput,
    @required this.humidity,
    @required this.humidityInput,
    @required this.tempUnit,
    @required this.temperature,
    @required this.temperatureInput,
    @required this.bodyWeight,
    @required this.bodyWeightInput,
    @required this.perceivedExertion,
  });

  EditCompletedWorkoutViewModelState copyWith({
    String comments,
    String commentsInput,
    double humidity,
    String humidityInput,
    TempUnit tempUnit,
    double temperature,
    String temperatureInput,
    double bodyWeight,
    String bodyWeightInput,
    int perceivedExertion,
  }) {
    if ((comments == null || identical(comments, this.comments)) &&
        (commentsInput == null ||
            identical(commentsInput, this.commentsInput)) &&
        (humidity == null || identical(humidity, this.humidity)) &&
        (humidityInput == null ||
            identical(humidityInput, this.humidityInput)) &&
        (tempUnit == null || identical(tempUnit, this.tempUnit)) &&
        (temperature == null || identical(temperature, this.temperature)) &&
        (temperatureInput == null ||
            identical(temperatureInput, this.temperatureInput)) &&
        (bodyWeight == null || identical(bodyWeight, this.bodyWeight)) &&
        (bodyWeightInput == null ||
            identical(bodyWeightInput, this.bodyWeightInput)) &&
        (perceivedExertion == null ||
            identical(perceivedExertion, this.perceivedExertion))) {
      return this;
    }

    return new EditCompletedWorkoutViewModelState(
      comments: comments ?? this.comments,
      commentsInput: commentsInput ?? this.commentsInput,
      humidity: humidity ?? this.humidity,
      humidityInput: humidityInput ?? this.humidityInput,
      tempUnit: tempUnit ?? this.tempUnit,
      temperature: temperature ?? this.temperature,
      temperatureInput: temperatureInput ?? this.temperatureInput,
      bodyWeight: bodyWeight ?? this.bodyWeight,
      bodyWeightInput: bodyWeightInput ?? this.bodyWeightInput,
      perceivedExertion: perceivedExertion ?? this.perceivedExertion,
    );
  }
}
