# TODO

## Countdown
- Remove +- weight if weight is negative on countdown screen.
- Keep screen alive
- Check if sounds come through on bg

### Large prio
- Add open crimp, check if all grips available.
- Graphs
- Add board selection. Only beastmaker1000 atm.
- Add custom board => Slopers, pinches, ...
- Info/explanation screen
- Implement a feedback button.

### Medium prio
- Rate workout redesign (1 page, loose the fist? Or make it an easter egg).
- When changing the model => workouts will be lost because the parsing will fail. Make sure there's a mapping mechanism in place.
  You need to provide the app version no. on the workout. So you can map them corrrectly.
- Tests
- Try catch blocks on sensitive code. E.g. deleting workout.
- Setup sentry.io, don't think about self hosting for now.
- Login with device id, to save workouts already
- Nice logo (animated)!
- Review app on smaller and larger screens.

### Small prio
- Refactor navigation with navigator key?
- Redesign toast
- Edit completed workout.
- Audioplayer service play sound takes a while when not already initted;
- keyboard slide up doesn't work => don't know (https://github.com/flutter/flutter/issues/16882)
- When deleting a workout => let the divider fade out as well (no janky feel).
- Adjust sounds of countdown / female/male voice that counts down.
- Set reminder for workout.
- Add info button on most elements
- Check out perf.
    
## Data strategy
Local is the source of truth.
Always save and persist locally.
Only when saving workouts or completed workouts => also send to server.
Only when something goes wrong when requesting the local db => try to fetch via backend.
  
  
## Errors
### On initial persistence - first time install app
FileSystemException: Cannot open file, path = '/Users/laurens/Library/Developer/CoreSimulator/Devices/E75788F1-923F-495F-B1EE-EE11166390DD/data/Containers/Data/Application/0F710B87-6CE7-4451-80DA-B129B5D7193A/Documents/workout.txt' (OS Error: No such file or directory, errno = 2)