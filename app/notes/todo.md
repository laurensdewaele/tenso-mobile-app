# TODO

### Others

### Large prio
- Beeps before rest, allow 0;
- Editing a workout whilst your training would be really nice.
  Adjusting the sequence directly.
  Or just simply editing in the history for correct values.
- Access settings during a workout? Why?
  Adjust sounds, and preparation timer.
- Redesign rate workout. Comments screen needs to be way bigger. With this keyboard thing not working, it's bad.
  Maybe just like create and edit with next. 1: rate, 2: comments: 3: stats.
  Rating is also a bit tricky, you can just leave it without actually entering anything.
- Add open crimp, pinch grip, check if all grips available
- Info/explanation screen
- More beginner workouts. => Repeaters / max-hang / density 
- Implement a feedback button.
-----
- Graphs
- Backend

### Medium prio

- Rate workout redesign (1 page, loose the fist? Or make it an easter egg).
- When changing the model => workouts will be lost because the parsing will fail. Make sure there's a mapping mechanism in place.
  You need to provide the app version no. on the workout. So you can map them corrrectly.
  When saving data to disk/be, specify a model version no. e.g workouts.txt:
    {v1: {}, v2{}}
- Tests
- Try catch blocks on sensitive code. E.g. deleting workout.
- Setup sentry.io, don't think about self hosting for now.
- Login with device id, to save workouts already
- Nice logo (animated)!
- Review app on smaller and larger screens.

### Small prio

- Remove built value?
- Remove gradients from screen
- Make as much constants and WIDGETS! consts.
- Add other boards
- Keep alive whilst on background and playing sounds. 
- Refactor navigation with navigator key?
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