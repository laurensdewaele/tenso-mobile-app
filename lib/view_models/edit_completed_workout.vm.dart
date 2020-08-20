import 'package:tenso_app/models/completed_workout.model.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/view_models/edit_completed_workout_state.vm.dart';

class EditCompletedWorkoutViewModel {
  CompletedWorkout _completedWorkout;
  EditCompletedWorkoutViewModelState _state;
  EditCompletedWorkoutViewModelState get state => _state;

  EditCompletedWorkoutViewModel({CompletedWorkout completedWorkout}) {
    _completedWorkout = completedWorkout;
    _state = EditCompletedWorkoutViewModelState(
        comments: completedWorkout.comments,
        commentsInput: completedWorkout.comments,
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

  handleCompleteTap() {}
}
