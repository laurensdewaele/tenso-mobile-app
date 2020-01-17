## Rest between holds on generalTab (reduces complexity)
## New workout
- Keep the pages alive somehow? => state store in a provider that is just above the new workout section.
## Validation needs to be on input field itself, not triggered on every input
## Link up to database / SQL.

## Add board selection. Only beastmaker1000 atm.
## Add info button on most elements
## Add open crimp

## Smaller width screens
Review the app on smaller and larger screens.

## Implement a feedback button
## Stop all globals (singletons as well)
## Perf
Performance seems acceptable at the moment.
Except for the initial dialog.
Try to convert as much as possible to consts.

## Code todo
- Refactor keyboard screen. Now code is duplicated across settings screen and new workout.

## Play sound that says which grip is next and which hold (pocket) is next.

## Unhandled exception when rapidly closing and opening an accordion on the overview page.
[VERBOSE-2:ui_dart_state.cc(157)] Unhandled Exception: This ticker was canceled: Ticker(created by _WorkoutOverviewCardState#45ee2(lifecycle state: created))
null



