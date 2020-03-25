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

- Remove +- weight if weight is negative on countdown screen.
- Add open crimp, check if all grips available.
- Remove difficulty and add label colour.

### Large prio

- Overview on completed workouts need effective time hung.
- Stopwatch option for rest periods
- Stop and log, when a workout is more than you can handle that day. E.g. The last set is too much.
- Keep screen alive when on countdown screen
- Skip buttons so you can quickly complete a workout.
- Redesign toast
- Graphs
- Add board selection. Only beastmaker1000 atm.
- Add custom board => Slopers, pinches, ... 
- Info/explanation screen
- Implement a feedback button.
- Check if sounds come trough if app on bg 

### Medium prio

- When changing the model => workouts will be lost because the parsing will fail. Make sure there's a mapping mechanism in place.
- Refactor appState. Remove provider. Needs to be done with streams. A lot cleaner and more performance.
  You don't want a widget listening to 3 VMs here. It worked before the latest refactor but was 
  very gimmicky with provider. With streams this will be a lot clearer. You want AppState => Workout_VM => General/Hold/Extra.
- Tests
- Try catch blocks on sensitive code. E.g. deleting workout.
- Setup sentry.io, don't think about self hosting for now.
- Login with device id, to save workouts already
- Draw diagram when all is refactored.
- Nice logo (animated)!
- Review app on smaller and larger screens.

### Small prio

- Text input needs continual validation. Doesn't work just when you lose focus.
  Because you can swipe or click the next button assuming it'll be saved.
  But it wont be saved.
  => Intercept swipes and validate on swipes and next buttons.
- Get rid of navigationStreams on workout. Workout screen should be the one managing the pages.
  And just pass the index and pages down as props, that way you wont need the whole thing.
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