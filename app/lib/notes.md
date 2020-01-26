Sooo as for services: 

- I have a persistent service that persists my data to disk
  **persistenceService**
- I have a workouts view_models with all my workouts
  **workoutsViewModel**
- I have a an active workout view_models, that has the workout loaded onto it.
  **activeWorkoutViewModel** 
  This can be to start/edit/play a workout.

When the app starts:

- Read all the workouts saved to persistent storage.
- Write that in the workouts view_models.

independant
Provider: persistenceService

dependant
ProxyProvider<persistenceService, WorkoutsViewModel> WorkoutsViewModel
ProxyProvider<WorkoutsState, ActiveWorkout> ActiveWorkoutViewModel

ProxyChangeNotifierProvider? 

ActiveWorkoutState.fromLatestWorkout
ActiveWorkoutState.fromWorkoutId

Every widget it's own model?
GeneralTabModel
HoldTabModel
ExtraTabModel
=> Yes, makes everything less verbose.

## Large prio

- Link up to database / SQL.
Do i need SQL => yes.
- Design screens for progress and the actual hang timer (don't forget to play sounds that notify you which grip and pocket is next).
- Add board selection. Only beastmaker1000 atm.
- Implement a feedback button.

## Medium prio

- Review app on smaller and larger screens.
- Validation needs to be on input field itself, not triggered on every input
- Add open crimp

## Small prio

- Mutliple grades
- Tests :D
- Refactor / redesign the alert toaster. This can be done with Provider (will be a lot cleaner)
- Add info button on most elements
- Stop all globals (singletons as well). Do I have any?
- Check out perf.
- Refactor keyboard screen. Now code is duplicated across settings screen and new workout.
- Unhandled exception when rapidly closing and opening an accordion on the overview page.
  [VERBOSE-2:ui_dart_state.cc(157)] Unhandled Exception: This ticker was canceled: Ticker(created by _WorkoutOverviewCardState#45ee2(lifecycle view_models: created))
  null

