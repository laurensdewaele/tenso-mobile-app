 ## Transitions

Hero transitions for going from my 'add new workout' to the workout screen that takes the gradient.
Add transition from card expand to collapse.

One thing for the next project, is that when designing, you should really factor in the screen transitions.

- Check out the Lato bold fonts for the modal components.

## New workout

What I eventually want a 'NewWorkoutRoute' to receive:

- The configuration file (determined by the settings page).
- The previously entered values by the user (so he/she doesn't have to set the same values all the time).


In my Widget I would like to have something simple like this:

```Dart
    void _handleValueChange(String field, int Value) {
        newWorkout[field] = value;
    }
    
    Widget _determineElement(ElementType types, Values value, String description) {
        switch (types) {
            case types.Slider:
            return Slider(initialValue: value, description: description, handleValueChange: _handleValueChange)
        }
    }
    
    build
    return ...config.map(section => {
      return Section(title: section.title, 
                     children: section.elements.map(element => {
                        return _determineElement( type: element.type, 
                                        initialValue: element.value, 
                                        description: element.description,
                                        workoutProperty: element.workoutProperty
                                        )
      }))
    })
```


How would this object look like?

```Javascript
const config = {
    generalTab: [{title: 'Basics', elements: [{type: 'clicker', initialValue: 3}]}, {title: Timers, elements: []}]
    holdTab (all the specifics regarding a specific hold)
    extraTab (name + diff)
}
```


```Dart

class Config {
  List<NewWorkoutSection> generalTab;
  List<NewWorkoutSection> holdTab;
  List<NewWorkoutSection> extraTab;
}

class NewWorkoutSection {
  String title;
  // Euhh how to I provide a type for all possible Elements?
  // Or would type Element suffice for SliderElement?
  // Or would I need an all elements?
  List<Element> elements;
}

class Element {
  InputTypes types;
  // Can this be strongly typed??
  initialValue value;
  String description;
  WorkoutFields workoutField;
}

class SliderElement extends Element {
  type: 'slider',
  initialValue: 4,
}

class GripElement extends Element {
  type: 'grip',
  initialValue: Grips.monoPinky;
}

// This will not be in the config, because it does not change.
//class BottomDotIndicatorElement extends Element {
//   type: 'dotIndicator',
//   initialValue: 5
 }
```


Ok... This looks quite good.
So:

- The new workout screen will receive the config object from whomever is doing the statekeeping
- Should it be a singleton global with methods to change certain fields when adjusting settings?
    => that way the children won't be notified
    => needs some redux like implementation
    
    
 Wait...
 How will I set my value when sliding for instance? 
 I don't want the Slide widget itself to connect to my store, right?
 That seems cumbersome and ill-ly separated.


