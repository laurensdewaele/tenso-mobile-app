# TODO

- Onboarding screen
  -> Make info graphic with Tenso logo on it.
  -> Make screens in app
- Track completed workouts => send data to db + adjust policy
  1) Reduce what's being saved, locally and remote. Work with refs.
     Adjust your frontend.
     
     Group => board to boardId
              leftGrip to leftGripId
              rightGrip to rightGripId
              leftGripBoardHold to leftGripBoardHoldId
              rightGripBoardHold to rightGripBoardHoldId
              
     Issue => need to convert existing structure to new.
     1) Check whether the saved user data is from v1 or v2
     2) If it's from v2, use new models, it's fine
     3) If it's from v1
        -> map the json data
           -> load using v1 models
           -> map the structure to v2 models
           -> save new sturcture 

### Triage
- Add option to make the exercise asymmetrical, alternating between grip types
- Rearrange groups in a workout
- update to new cupertino icons package
- splash screen
- rethink save and info button on menu?
- Set reminder on calendar page
- Customized congratulations screen, first workout, milestones...

Pro features:
- Compare against locals
- Insight into all data
- World leaderboards
- Build frontend that lets you upload image of your own custom board and draw rectangles

### Large prio
- Jump straight to overview after completing a workout.
- Workout on the fly
- Export data
- Share workouts, this also means settings up an account
- Graphs
- Make videos to explain beginners how to use this app.
- Check the keyboard and keyboard provider, doe\s it still do it's job?
  keyboard slide up doesn't work => don't know (https://github.com/flutter/flutter/issues/16882)

### Medium prio
- Audioplayers stops audio sound on IOS (Ting)
- Add notes to workout, popup when starting workout to display notes. => contact fsdalen on reddit
- recruitment pulls
- Add edge to top row custom board
- Add other boards
- Setup sentry.io
- Review app on smaller and larger screens.

### Small prio
- On orientation switching, the grips are not re-painted.
- Custom boards in horizontal scroll view.
- Keep alive whilst on background and playing sounds.
- Counting upwards in the settings.
- Splash screen logo + loading
- Sync with strava or garmin for the data nerds
- Set reminder for workout.
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
    
## Data

Changed the description of grip type chisel.
From 'chisel (open crimp)' to 'open crimp (chisel)'.
This means it's wrong in people's history.
You would need to reference it or run through the data and adjust.    

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