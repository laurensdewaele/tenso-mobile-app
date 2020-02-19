
I need:

- To keep track of the completed workouts.

- A stack with 2 colors that shifst during the timer
- A preparation / hang / rest between holds / rest between sets.
- The countdown timer itself
- The next grip / current grip
- Progress indicator

{
    color: 
    title: 
    remainingSeconds: 
    gripText:
    hold: 
    board:
    leftGrip:
    rightGrip:
    leftGripBoardHold:
    rightGripBoardHold:
    totalSets:
    currentSet:
    totalHangsPerSet:
    currentHang:
}


Process:

1) Preparation timer (settings)

Loop over sets
Loop over holds
Loop over repetitions per hold.

2) Hold 1 - rep 1
3) Rest between holds (workout)
2) Hold 1 - rep 2
3) Rest between holds (workout)
4) Hold 2
5) Rest between holds (workout)
6) Hold 3 (workout)

7) Rest between sets
8) Hold 1 - rep 1
9) Rest between holds (workout)
10) Hold 2 - rep 2
11) Rest between holds (workout)
12) Hold 3(workout)

Build some sort of a UI model?



Should i be consistent with the other viewmodels and do all the logic there?
Or is the logic small enough to have it in the widget itself.

Case 1)

Have a CountDownViewModel with 
    color: 
    title: 
    duration: 
    ... 
properties.
Then the Countdown widget would notify the viewmodel when it needs 
to go a diff hold or...... the viewmodel does it all. hm.




