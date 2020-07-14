# TODO

- Implement a feedback section.

=> Created date on backend

- Take new photo's of all grips.

### Triage:
- Have an overview of the things you specifically did, hang times, and skipped etc...
- Have an 'on the fly workout'? 
  Where you can specify how much you've hung, with added weight.
  Just rep per rep, or set per set.
- Preview workout.
- Instead of counting down, counting up is probably better.
  Settings?
- Scale pull measurements (Jan)? 

### Large prio
- Add open crimp, pinch grip, check if all grips available
- Info/explanation screen
- LAUNCH

### Medium prio
- Info on group and rep rest needs to say stuff about group and rest, not just 
  variable and fixed.
- More beginner workouts. => Repeaters / max-hang / density 
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
- Custom boards in horizontal scroll view.
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