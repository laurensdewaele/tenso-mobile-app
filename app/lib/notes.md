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

- menu not visible by default on non-first app launch ever. => create info with user device and first time launched.

### Large prio

- Graphs
- Add categories and category colors?
  - Repeaters
  - Max hangs
  It would be nice to distinguish between these.
  Who can help? Matt?

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
- Add custom board
- Add board selection. Only beastmaker1000 atm.
- Implement a feedback button.
- When changing the model => workouts will be lost because the parsing will fail. Make sure there's a mapping mechanism in place.

### Medium prio

- Nice logo (animated)!
- Review app on smaller and larger screens.
- Add open crimp

### Small prio

- Validation needs to be on input field itself, not triggered on every input
- Copy workout, on compeleted as in the overview on long press and copy the workout and add - copy to the name
- Adjust sounds of countdown / female/male voice that counts down.
- Set reminder for workout.
- styles trough Provider instead of globals
- Tests
- Add info button on most elements
- Stop all globals (singletons as well). Do I have any? => styles
- Check out perf.
  
## Errors

### On initial persistence - first time install app
FileSystemException: Cannot open file, path = '/Users/laurens/Library/Developer/CoreSimulator/Devices/E75788F1-923F-495F-B1EE-EE11166390DD/data/Containers/Data/Application/0F710B87-6CE7-4451-80DA-B129B5D7193A/Documents/workout.txt' (OS Error: No such file or directory, errno = 2)