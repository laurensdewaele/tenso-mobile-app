import 'package:app/data/basic_workout.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/models/workout.dart';
import 'package:app/services/persistence.dart';

class WorkoutState extends ChangeNotifier {
  WorkoutState(this._persistenceService) {
    _fetchLatestCreatedWorkout();
  }
  PersistenceService _persistenceService;

  void _fetchLatestCreatedWorkout() async {
    _workout = await _persistenceService.fetchLatestCreatedWorkout();
  }

  Workout _workout;
  Workout get workout {
    if (_workout == null) {
      _workout = basicWorkout;
    }
    return _workout;
  }
  void setWorkout(Workout workout) {
    _workout = workout;
    notifyListeners();
  }
}
