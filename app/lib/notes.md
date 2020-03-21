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

- Display workout. Most important average added weight, average hang seconds. No of holds.
- Do i need to adjust the ID when editing a workout? => Yes
- Add grip type on hold info (hold, type, depth)
- Rename felt difficulty to effort level.
- Negative weights!
- Bug? Keyboard on rotation (on countdown screen)?
- Add open crimp, check if all grips available.

### Large prio

- Stopwatch option for rest periods
- Stop and log, when a workout is more than you can handle that day. E.g. The last set is too much.
- Advanced section on rate workout => Body weight / Temperatue / Humidity / Comments
- Graphs
- Redesign toast
- Add board selection. Only beastmaker1000 atm.
- Add custom board => Slopers, pinches, ... 
- Info/explanation screen
- Implement a feedback button.
- Skip buttons so you can quickly complete a workout.
- When changing the model => workouts will be lost because the parsing will fail. Make sure there's a mapping mechanism in place.

### Medium prio

- Setup sentry.io, don't think about self hosting for now.
- Login with device id, to save workouts already
- Think about: 
  - Categories and different colors?
- Draw diagram when all is refactored.
- Nice logo (animated)!
- Review app on smaller and larger screens.

### Small prio

- Tests
- Validation needs to be on input field itself, not triggered on every input
- Copy workout, on compeleted as in the overview on long press and copy the workout and add - copy to the name
- Adjust sounds of countdown / female/male voice that counts down.
- Set reminder for workout.
- styles trough Provider instead of globals
- Add info button on most elements
- Stop all globals (singletons as well). Do I have any? => styles
- Check out perf.
  
## Errors

### On initial persistence - first time install app
FileSystemException: Cannot open file, path = '/Users/laurens/Library/Developer/CoreSimulator/Devices/E75788F1-923F-495F-B1EE-EE11166390DD/data/Containers/Data/Application/0F710B87-6CE7-4451-80DA-B129B5D7193A/Documents/workout.txt' (OS Error: No such file or directory, errno = 2)