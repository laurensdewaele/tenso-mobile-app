import 'package:app/models/workout.dart';
import 'package:app/services/persistence.dart';
import 'package:flutter/material.dart';

class WorkoutsViewModel extends ChangeNotifier {
  WorkoutsViewModel({PersistenceService persistenceService})
      : this._persistenceService = persistenceService;

  final PersistenceService _persistenceService;

  List<Workout> _workouts;
  Future<List<Workout>> get workouts async {
    if (_workouts == null) {
      _workouts = await this._persistenceService.getWorkouts();
    }
    return _workouts;
  }
}
