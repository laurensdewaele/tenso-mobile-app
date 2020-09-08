# TODO
- graphs - overview screen
- metolius 3d
- onboarding screen
- share workouts with friends

### Triage
- Onboarding screen
- rethink save and info button on menu?
- Allow ability to add some notes to each group, or name each group. 
  I like to do some scapula pulls, knee raises and pull ups to warm up. 
  I would love to have the warm up with prompts on here.
- Alternating between grip types, e.g. open hang => crimp => open hand => crimp => open ...

### Large prio
- Graphs
- Export data
- Make videos to explain beginners how to use this app.
- Check the keyboard and keyboard provider, doe\s it still do it's job?
  keyboard slide up doesn't work => don't know (https://github.com/flutter/flutter/issues/16882)

### Medium prio
- Add edge to top row custom board
- Add other boards
- Setup sentry.io
- Review app on smaller and larger screens.

### Small prio
- Custom boards in horizontal scroll view.
- Counting upwards in the settings.
- Splash screen logo + loading
- Sync with strava or garmin for the data nerds
- Set reminder for workout.
- Keep alive whilst on background and playing sounds.
- Add info button on most elements.
- Have an 'on the fly workout'?
- Scale pull measurements (Jan)? 
- Audioplayer service play sound takes a while when not already initted;
- Adjust sounds of countdown / female/male voice that counts down.
- Check out perf; Make as much constants and WIDGETS! consts.
- Info on group and rep rest needs to say stuff about group and rest, not just 
  variable and fixed.
- Have a timer section, without specifying holds etc.
- Webapp where people can upload their own image of the board
- When dragging a hand and you go back to it's original position, it says it's in use.
    
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