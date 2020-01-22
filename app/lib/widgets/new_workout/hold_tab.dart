import 'package:app/functions/unit_conversion.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hand_types.dart';
import 'package:app/models/units.dart';
import 'package:app/state/settings.dart';
import 'package:app/state/workout.dart';
import 'package:app/widgets/new_workout/board_hold_picker.dart';
import 'package:app/widgets/new_workout/grip_picker_container.dart';
import 'package:app/widgets/new_workout/integer_input_and_divider.dart';
import 'package:app/widgets/section.dart';

class HoldTab extends StatelessWidget {
  HoldTab({
    Key key,
    @required this.currentHold,
    @required this.shouldLoseFocusStream,
    @required this.handleErrorMessage,
  }) : super(key: key);

  final int currentHold;
  final Function(Widget message) handleErrorMessage;
  final Stream<bool> shouldLoseFocusStream;

  @override
  Widget build(BuildContext context) {
    final workoutState = Provider.of<WorkoutState>(context, listen: true);
    final settingsState = Provider.of<SettingsState>(context, listen: false);

    final String _currentHoldString = (currentHold + 1).toString();
    final String _totalHoldsString = workoutState.holdCount.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'hold $_currentHoldString / $_totalHoldsString',
          children: <Widget>[
            GripPickerContainer(
              currentHold: currentHold,
              selectedLeftGrip: workoutState.holds[currentHold].leftGrip,
              selectedRightGrip: workoutState.holds[currentHold].rightGrip,
              selectedHandHold: workoutState.holds[currentHold].handHold,
              handleLeftGripChanged: (Grip grip) =>
                  workoutState.setHoldLeftGrip(currentHold, grip),
              handleRightGripChanged: (Grip grip) =>
                  workoutState.setHoldRightGrip(currentHold, grip),
              handleOneHandedTap: (HandTypes handType) {
                HandHolds handHold;
                if (handType == HandTypes.leftHand) {
                  handHold = HandHolds.oneHandedLeft;
                } else {
                  handHold = HandHolds.oneHandedRight;
                }
                workoutState.setHoldHandHold(currentHold, handHold);
              },
              handleTwoHandedTap: () => workoutState.setHoldHandHold(
                  currentHold, HandHolds.twoHanded),
            )
          ],
        ),
        Section(
          title: 'drag to choose',
          children: <Widget>[
            BoardHoldPicker(
                board: workoutState.board,
                leftGrip: workoutState.holds[currentHold].leftGrip,
                rightGrip: workoutState.holds[currentHold].rightGrip,
                initialLeftGripBoardHold:
                    workoutState.holds[currentHold].leftGripBoardHold,
                initialRightGripBoardHold:
                    workoutState.holds[currentHold].rightGripBoardHold,
                handleLeftGripBoardHoldChanged: (BoardHold boardHold) =>
                    workoutState.setHoldLeftGripBoardHold(
                        currentHold, boardHold),
                handleRightGripBoardHoldChanged: (BoardHold boardHold) =>
                    workoutState.setHoldRightGripBoardHold(
                        currentHold, boardHold),
                handleErrorMessage: handleErrorMessage)
          ],
        ),
        Section(
          title: 'basics',
          children: <Widget>[
            NumberInputAndDivider(
              isDouble: false,
              description: 'repetitions',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                workoutState.setHoldRepetitions(currentHold, n);
              },
              initialValue:
                  workoutState.holds[currentHold].repetitions.toDouble(),
              shouldLoseFocusStream: shouldLoseFocusStream,
              handleErrorMessage: handleErrorMessage,
            ),
          ],
        ),
        Section(
          title: 'timers',
          children: <Widget>[
            NumberInputAndDivider(
              isDouble: false,
              description: 'hang time seconds',
              shouldFocus: false,
              handleIntValueChanged: (int s) {
                workoutState.setHoldHangTime(currentHold, s);
              },
              initialValue: workoutState.holds[currentHold].hangTime.toDouble(),
              shouldLoseFocusStream: shouldLoseFocusStream,
              handleErrorMessage: handleErrorMessage,
            ),
            NumberInputAndDivider(
              isDouble: false,
              description: 'rest seconds between repetitions',
              shouldFocus: false,
              handleIntValueChanged: (int s) {
                workoutState.setHoldRestBetweenRepetitions(currentHold, s);
              },
              initialValue: workoutState
                  .holds[currentHold].restBetweenRepetitions
                  .toDouble(),
              shouldLoseFocusStream: shouldLoseFocusStream,
              handleErrorMessage: handleErrorMessage,
            ),
          ],
        ),
        Section(
          title: 'added weight',
          children: <Widget>[
            NumberInputAndDivider(
              zeroValueAllowed: true,
              description: settingsState.unit == Units.metric ? 'kg' : 'pounds',
              shouldFocus: false,
              handleDoubleValueChanged: (double n) {
                workoutState.setHoldAddedWeight(
                    currentHold, n.toDouble(), settingsState.unit);
              },
              initialValue: settingsState.unit == Units.metric
                  ? workoutState.holds[currentHold].addedWeight
                  : UnitConversion.convertPoundsToKg(
                      workoutState.holds[currentHold].addedWeight),
              isDouble: true,
              shouldLoseFocusStream: shouldLoseFocusStream,
              handleErrorMessage: handleErrorMessage,
            ),
          ],
        ),
      ],
    );
  }
}
