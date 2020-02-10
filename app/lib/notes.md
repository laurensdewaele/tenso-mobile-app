## Commands
Built value command.
Build
`flutter packages pub run build_runner build`
Watch
`flutter packages pub run build_runner watch`

## TODO
### Large prio

- Error when you have a small finger and try to pick a bigger hand for a not suitable hold.
- Refactor / redesign the alert toaster. This can be done with Provider (will be a lot cleaner)
- Draw diagram when all is refactored.
- Write to file on every change.
- Design screens for progress and the actual hang timer (don't forget to play sounds that notify you which grip and pocket is next).
- Add board selection. Only beastmaker1000 atm.
- Implement a feedback button.

### Medium prio

- Review app on smaller and larger screens.
- Validation needs to be on input field itself, not triggered on every input
- Add open crimp

### Small prio

- Mutliple grades
- Tests :D
- Add info button on most elements
- Stop all globals (singletons as well). Do I have any?
- Check out perf.
- Refactor keyboard screen. Now code is duplicated across settings screen and new workout.
- Unhandled exception when rapidly closing and opening an accordion on the overview page.
  [VERBOSE-2:ui_dart_state.cc(157)] Unhandled Exception: This ticker was canceled: Ticker(created by _WorkoutOverviewCardState#45ee2(lifecycle view_models: created))
  null