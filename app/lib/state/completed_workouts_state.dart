import 'package:rxdart/rxdart.dart';

import 'package:app/models/models.dart';
import 'package:app/services/persistence.dart';

class CompletedWorkoutsState {
  PersistenceService _persistenceService;

  BehaviorSubject<CompletedWorkouts> _completedWorkouts$;
  List<CompletedWorkout> get completedWorkoutList =>
      _completedWorkouts$.value.completedWorkouts.toList();
  Stream<List<CompletedWorkout>> get completedWorkoutList$ =>
      _completedWorkouts$.stream.map((c) => c.completedWorkouts.toList());

  CompletedWorkoutsState._();
  static final CompletedWorkoutsState _completedWorkoutsState =
      CompletedWorkoutsState._();
  factory CompletedWorkoutsState() => _completedWorkoutsState;

  Future<void> init() async {
    _persistenceService = PersistenceService();
    final CompletedWorkouts _completedWorkouts = await _getCompletedWorkouts();
    _completedWorkouts$ =
        BehaviorSubject.seeded(_completedWorkouts ?? CompletedWorkouts());
    return Future.value();
  }

  Future<CompletedWorkouts> _getCompletedWorkouts() async {
    final CompletedWorkouts _completedWorkouts =
        await _persistenceService.getCompletedWorkouts();
    return _completedWorkouts;
  }

  void _saveCompletedWorkouts(CompletedWorkouts completedWorkouts) {
    _persistenceService.saveCompletedWorkouts(completedWorkouts);
  }

  void _setAndSaveCompletedWorkoutList(
      List<CompletedWorkout> newCompletedWorkoutList) {
    final CompletedWorkouts _newCompletedWorkouts = _completedWorkouts$.value
        .rebuild((b) => b..completedWorkouts.replace(newCompletedWorkoutList));
    _completedWorkouts$.add(_newCompletedWorkouts);
    _saveCompletedWorkouts(_newCompletedWorkouts);
  }

  void addCompletedWorkout(CompletedWorkout completedWorkout) {
    final List<CompletedWorkout> _newCompletedWorkoutList = []
      ..addAll(completedWorkoutList)
      ..add(completedWorkout);

    _setAndSaveCompletedWorkoutList(_newCompletedWorkoutList);
  }

  void deleteCompletedWorkout(CompletedWorkout completedWorkout) {
    final List<CompletedWorkout> _newCompletedWorkoutList = []
      ..addAll(completedWorkoutList);
    _newCompletedWorkoutList.removeWhere((c) => c.id == completedWorkout.id);
    _setAndSaveCompletedWorkoutList(_newCompletedWorkoutList);
  }

  dispose() {
    _completedWorkouts$.close();
  }
}
