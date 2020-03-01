## Commands
Built value command.
Build
```
flutter packages pub run build_runner build
```
Watch
```
flutter packages pub run build_runner watch
```

## TODO
### Large prio


- Show edge size somewhere.
- Screen hang timer.
  Track completed hangs.


  

- Progress and overview completed workouts.
  - Day overview?
  - Graph overview with addedWeight
  - Graph overview with hold edges
  - Graph overview with Grips
 
  - Overview on workout accordion => calcHandoffSet needs to be in a separate class and extend that one. => do it when incorporating it in the overview. 
- Draw diagram when all is refactored. => DO THIS THOUGH MAYBE DO IT WHEN YOUR READY TO OPEN SOURCE.
  Maybe then you'll foreget how it's all structured. NewOrEditWorkout => buffer for the workout screens because it can alter between new or edit.
  Explain when drawing my diagram that it's quite intricate and it adds a lot of overhead
  if you want every widget to have it's own viewModel and not depend on others.
  It gets messy real fast with Provider lol.
  Bloc would have been better.
- Add board selection. Only beastmaker1000 atm.
- Implement a feedback button.

### Medium prio

- Add custom board
- Rethink the difficulty. Maybe once you do a test it can be reset to what your max is?
- Review app on smaller and larger screens.
- Validation needs to be on input field itself, not triggered on every input
- ShouldLooseFocus stream controller onto Provider.
- Add open crimp

### Small prio

- styles trough Provider instead of globals
- Mutliple grades
- Tests :D
- Add info button on most elements
- Stop all globals (singletons as well). Do I have any? => styles
- Check out perf.
- Refactor keyboard screen. Now code is duplicated across settings screen and new workout.
- Unhandled exception when rapidly closing and opening an accordion on the overview page.
  [VERBOSE-2:ui_dart_state.cc(157)] Unhandled Exception: This ticker was canceled: Ticker(created by _WorkoutOverviewCardState#45ee2(lifecycle view_models: created))
  null
  
  
  
## Errors

### On initial persistence - first time install app
FileSystemException: Cannot open file, path = '/Users/laurens/Library/Developer/CoreSimulator/Devices/E75788F1-923F-495F-B1EE-EE11166390DD/data/Containers/Data/Application/0F710B87-6CE7-4451-80DA-B129B5D7193A/Documents/workout.txt' (OS Error: No such file or directory, errno = 2)
