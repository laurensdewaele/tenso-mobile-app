# Calendar

## Requirements

- Calendar header
- When I click on the header, a popup / modal from below appears where I can input the month.
- Calendar where you can scroll trough months.

### Calendar header

#### Spec
Just displays the current month.
On click or tap -> open up the bottom drawer.
#### Implementation
It should accept as params:
- String month + year
- On arrow click, trigger cb to parent that opens up the drawer.


### Bottom drawer - generic
Gets the content via provider.
Opens and closes (is just gone when it closes).


### Bottom drawer - content

### Spec
It needs to display selectable months.
E.g. 2019 - January
Months that do not have any data, should be greyed out.
Experiment with infinite scrolling of months, or limit the user to max 1 year or something without data.
### Implementation
It should accept as params: 
- List of months that contain workouts

Determine first month that has completed workouts
Determine last month that has a completed workout.

On select => notify calendar state of the changed month.
Calendar state / vm
- selectedMonth
- selectedDay
- completedWorkoutsForSelectedDay

### Calendar

Display the days in a week format. 
Gray out the days that do not belong to this month.
On init, select the current date.
The selected date will be bigger.
It should display all the completed workouts with their felt destruction level.
#### Implementation
Args:
- selectedMonth DateTime
- selectedDay DateTime
- completedWorkouts for that month
- handleDaySelected


### Completed workouts display 

It should display the completed workouts and the ability to delete them.

