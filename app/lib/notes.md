## Commands
Built value command.
Build
`flutter packages pub run build_runner build`
Watch
`flutter packages pub run build_runner watch`

## TODO
### Large prio

- Edit workout. 
- Better naming because it needs to be used edit workout as well.


OH HEAHHH SHIT WORKS SONNNY BOOY...
So what I need to do: refactor and remove appState
Remove _workout and call it _newWorkout;

Go train hehemahhaa;

- Draw diagram when all is refactored. => DO THIS THOUGH
- Write to file on every change.
- Design screens for progress and the actual hang timer (don't forget to play sounds that notify you which grip and pocket is next).
- Add board selection. Only beastmaker1000 atm.
- Implement a feedback button.

### Medium prio

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

