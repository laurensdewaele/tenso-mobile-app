# TODO

### Triage:
- Have an 'on the fly workout'? 
  Where you can specify how much you've hung, with added weight.
  Just rep per rep, or set per set.


### Large prio
- get rid of sets
- rename to grips / sets
- implement design svanhild
- Custom boards in horizontal scroll view.
- History (calendar) update times.
- Edit hung values on completion, new button next to rate workout.
- Rename holds to different grip positions.
- Repeaters
- board picker on general_tab
- Beeps before rest, allow 0;
- Redesign rate workout + refactor. Comments screen needs to be way bigger. With this keyboard thing not working, it's bad.
  Maybe just like create and edit with next. 1: rate, 2: comments: 3: stats.
  Rating is also a bit tricky, you can just leave it without actually entering anything.
- Rate workout redesign (1 page, loose the fist? Or make it an easter egg).
- Add open crimp, pinch grip, check if all grips available
- Info/explanation screen
- More beginner workouts. => Repeaters / max-hang / density 
- Implement a feedback button.
- LAUNCH

### Medium prio
- Make videos to explain beginners how to use this app.
- Graphs
- Backend
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
- Have a timer section, without specifying holds etc.
- Show history with pauses included, skip buttons etc. 
- edit standard board depths
- Webapp where people can upload their own image of the board
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