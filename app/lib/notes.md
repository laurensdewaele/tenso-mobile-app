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
### Large prio

- Design screens for progress and the actual hang timer (don't forget to play sounds that notify you which grip and pocket is next).
  => What does the timer screen need?
  It needs a mute button. => you can go to settings for now.
  It needs a pause button. => and a play button. => yeps
  It needs a stop button. => yeps.
  It would be very cool if there were an animation. => yeps
  I'm thinking that'd it be nice if you could use the whole screen. => yeps
  The device is probably going to be a bit further away from the user.
  So being able to see will be nice. 
  How about flashing?
  Also beeps.
  I do not want to force the user to choose an orientation.
  
   
  What do I need to track?
  - Completed hangs


  What else do I need in the app?
  - An overview screen of the completed workouts with the date. 
    A calendar would be awesome.
    
    Some stats about the workout => seconds on holds 
    
    
    A stats overview tab => graph with used grips
    => graph with used holds.
    => graph with added weight.
    
    Well ideally, you want an objective score. Because you can objectively measure the stats.
    Then you specifiy how hard it was for you.
    
    With those 2 ratings => you can finely measure your progression.
    
    I do think you need a distinction in sloper, jug and pocket.
    - Rating of open hand => mono pinky
    - Edge mm
    - Added weight
    - One handed / two handed.
   
    
   
    


- Draw diagram when all is refactored. => DO THIS THOUGH MAYBE DO IT WHEN YOUR READY TO OPEN SOURCE.
  Maybe then you'll forget how it's all structured. NewOrEditWorkout => buffer for the workout screens because it can alter between new or edit.
  Explain when drawing my diagram that it's quite intricate and it adds a lot of overhead
  if you want every widget to have it's own viewModel and not depend on others.
  It gets messy real fast with Provider lol.
  Bloc would have been better.
- Add board selection. Only beastmaker1000 atm.
- Implement a feedback button.

### Medium prio

- Rethink the difficulty. Maybe once you do a test it can be reset to what your max is?
- Review app on smaller and larger screens.
- Validation needs to be on input field itself, not triggered on every input
- ShouldLooseFocus stream controller onto Provider.
- Add open crimp

### Small prio

- styles trough Provider instead of globals
- Mutliple grades
- Tests :D
- Add info button on most elements
- Stop all globals (singletons as well). Do I have any?
- Check out perf.
- Refactor keyboard screen. Now code is duplicated across settings screen and new workout.
- Unhandled exception when rapidly closing and opening an accordion on the overview page.
  [VERBOSE-2:ui_dart_state.cc(157)] Unhandled Exception: This ticker was canceled: Ticker(created by _WorkoutOverviewCardState#45ee2(lifecycle view_models: created))
  null
  
  
  
## Errors

### On initial persistence - first time install app
FileSystemException: Cannot open file, path = '/Users/laurens/Library/Developer/CoreSimulator/Devices/E75788F1-923F-495F-B1EE-EE11166390DD/data/Containers/Data/Application/0F710B87-6CE7-4451-80DA-B129B5D7193A/Documents/workout.txt' (OS Error: No such file or directory, errno = 2)

### BoardHoldPicker - setState() or markNeedsBuild() called during build
```Dart
The following assertion was thrown while dispatching notifications for AppState:
setState() or markNeedsBuild() called during build.

This _DefaultInheritedProviderScope<AppState> widget cannot be marked as needing to build because the framework is already in the process of building widgets.  A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
The widget on which setState() or markNeedsBuild() was called was: _DefaultInheritedProviderScope<AppState>
  value: Instance of 'AppState'
  listening to value
The widget which was currently being built when the offending call was made was: Section
```

This comes from BoardHoldPicker. 
It receives a new leftGrip or rightGrip from it's parent (emitted by AppState).
And therefor enters into it's didUpdateWidget method to set the correct offset for the new grip.
This also sets state, whilst it's already building and therefor the error is thrown.

Possible solutions:

- leave it as is. The error is non breaking?
- addPostFrameCallback gets rid of the error, but then there's a slight delay you notice when the feedback is being set.

