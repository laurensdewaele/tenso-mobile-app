import 'package:rxdart/rxdart.dart';

import 'package:app/data/basic_workout.dart';
import 'package:app/helpers/unique_id.dart';
import 'package:app/models/models.dart';
import 'package:app/services/persistence.dart';

class WorkoutsState {
  PersistenceService _persistenceService;
  BehaviorSubject<Workouts> _workouts$;
  List<Workout> get workoutList => _workouts$.value.workouts.toList();
  Stream<List<Workout>> get workoutList$ =>
      _workouts$.stream.map((Workouts w) => w.workouts.toList());

  WorkoutsState._();
  static final WorkoutsState _workoutState = WorkoutsState._();
  factory WorkoutsState() => _workoutState;

  Future<void> init() async {
    _persistenceService = PersistenceService();
    final Workouts _workouts = await _getWorkouts();
    _workouts$ = BehaviorSubject.seeded(_workouts ?? basicWorkouts);
    return Future.value();
  }

  Future<Workouts> _getWorkouts() async {
    final Workouts _workouts = await _persistenceService.getWorkouts();
    return _workouts;
  }

  void _saveWorkouts(Workouts workouts) {
    _persistenceService.saveWorkouts(workouts);
  }

  void _setAndSaveWorkoutList(List<Workout> newWorkoutList) {
    final Workouts _newWorkouts =
        _workouts$.value.rebuild((b) => b..workouts.replace(newWorkoutList));
    _workouts$.add(_newWorkouts);
    _saveWorkouts(_newWorkouts);
  }

  void addWorkout(Workout workout) {
    final List<Workout> _newWorkoutList = []
      ..addAll(workoutList)
      ..add(workout.rebuild((b) => b..id = generateUniqueId()));

    _setAndSaveWorkoutList(_newWorkoutList);
  }

  void deleteWorkout(Workout workout) {
    final List<Workout> _newWorkoutList = []..addAll(workoutList);
    _newWorkoutList.removeWhere((w) => w.id == workout.id);
    _setAndSaveWorkoutList(_newWorkoutList);
  }

  void editWorkout(Workout workout) {
    final int _originalWorkoutIndex =
        workoutList.indexWhere((w) => w.id == workout.id);
    final List<Workout> _newWorkoutList = []..addAll(workoutList);
    _newWorkoutList[_originalWorkoutIndex] = workout;

    _setAndSaveWorkoutList(_newWorkoutList);
  }

  void copyWorkout(Workout workout) {
    final List<Workout> _newWorkoutList = []
      ..addAll(workoutList)
      ..add(workout.rebuild((b) => b
        ..id = generateUniqueId()
        ..name = '${workout.name} copy'));

    _setAndSaveWorkoutList(_newWorkoutList);
  }

  dispose() {
    _workouts$.close();
  }
}
