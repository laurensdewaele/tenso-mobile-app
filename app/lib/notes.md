What I pondered about yesterday was about the state management.
This all came to be because of an error.
- Hold-Tab sets it's own internal state _selectedHand.
- But in that method also dispatches a new state to the store.
- And thus hold-tab also receives new props from the store.
- Therefor it spits out an error that it cannot mark dirty while it's building.

My pondering of yesterday:

My globale app state heeft een aantal states:

- Settings
- Workouts[]
- Workout / edit / new

Wanneer je gaat naar new workout moet je de temp workout populaten met de laatst aangemaakte workout.
Maar je moet ofwel een bestaande workout kunnen editen en saven in Workouts[] of er een nieuwe aan toevoegen. En dat liefst op elke state change (als ze de app sluiten).
Dus =>

- Als je de model populate moet je ook meegeven welke save er moet gebeuren
- Een soort van depency injection dat weet hij (als het edit is) dat hij de bestaande workout update.

ProxyProvider<workouts, workout>
builder (context, workouts, ...) => Workout(save: workouts)
Or I can have workout(edit/new) depend on workouts so I get access to the save function.
I can specify the which method it should be when constructing the edit/new workout. Wether it be saving to new or updating.



De complexiteit ontstaat omdat er op elke input change alles gesaved moet worden.
Als we saven op een navigate is er weinig probleem.


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
  [VERBOSE-2:ui_dart_state.cc(157)] Unhandled Exception: This ticker was canceled: Ticker(created by _WorkoutOverviewCardState#45ee2(lifecycle state: created))
  null

