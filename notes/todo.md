# TODO

- Default board not working properly.
- Stop a hangboarding session, then press the back button in the "congratulations" screen. This puts the app in a broken state I cannot get out of.
- Chisel grip / open crimp + pinch grip

### Boards
- Tension grindstone
- TRANGO Rock Prodigy
- Tension Flash Board
- metolius simulator 3D
- Antworks Strong Ant 3
- eva lopez’s boards
- metolius’ boards

### Triage:
- Tracking of the pause timer.
- Allow abilit to add some notes to each group, or name each group. 
  I like to do some scapula pulls, knee raises and pull ups to warm up. 
  I would love to have the warm up with prompts on here.
- Adding notes whilst resting
- Alternating between grip types, e.g. open hang => crimp => open hand => crimp => open ...

### Large prio
- Graphs
- Counting upwards in the settings.
- Check the keyboard and keyboard provider, does it still do it's job?
  keyboard slide up doesn't work => don't know (https://github.com/flutter/flutter/issues/16882)

### Medium prio
- Add other boards
- Setup sentry.io
- Backend
- Login with device id, to save workouts already
- Review app on smaller and larger screens.
- Tests

### Small prio
- Make videos to explain beginners how to use this app.
- Set reminder for workout.
- Keep alive whilst on background and playing sounds.
- Splash screen logo + loading
- Add info button on most elements.
- Have an 'on the fly workout'?
- Scale pull measurements (Jan)? 
- background color on edit and create, not red?
- Custom boards in horizontal scroll view.
- Audioplayer service play sound takes a while when not already initted;
- Adjust sounds of countdown / female/male voice that counts down.
- Check out perf; Make as much constants and WIDGETS! consts.
- Info on group and rep rest needs to say stuff about group and rest, not just 
  variable and fixed.
- Have a timer section, without specifying holds etc.
- Webapp where people can upload their own image of the board
    
## Data strategy
- Remove built value?
- When changing the model => workouts will be lost because the parsing will fail. Make sure there's a mapping mechanism in place.
  You need to provide the app version no. on the workout. So you can map them corrrectly.
  When saving data to disk/be, specify a model version no. e.g workouts.txt:
    {v1: {}, v2{}}

Local is the source of truth.
Always save and persist locally.
Only when saving workouts or completed workouts => also send to server.
Only when something goes wrong when requesting the local db => try to fetch via backend.
  
  
## Errors
### On initial persistence - first time install app
FileSystemException: Cannot open file, path = '/Users/laurens/Library/Developer/CoreSimulator/Devices/E75788F1-923F-495F-B1EE-EE11166390DD/data/Containers/Data/Application/0F710B87-6CE7-4451-80DA-B129B5D7193A/Documents/workout.txt' (OS Error: No such file or directory, errno = 2)