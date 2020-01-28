import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/functions/unit_conversion.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hand_type.dart';
import 'package:app/models/units.dart';
import 'package:app/view_models/settings.dart';
import 'package:app/view_models/workout.dart';
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
    final workoutViewModel = Provider.of<WorkoutViewModel>(context, listen: true);
    final settingsViewModel = Provider.of<SettingsViewModel>(context, listen: false);

    final String _currentHoldString = (currentHold + 1).toString();
    final String _totalHoldsString = workoutViewModel.holdCount.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'hold $_currentHoldString / $_totalHoldsString',
          children: <Widget>[
            GripPickerContainer(
              currentHold: currentHold,
              selectedLeftGrip: workoutViewModel.holds[currentHold].leftGrip,
              selectedRightGrip: workoutViewModel.holds[currentHold].rightGrip,
              selectedHandHold: workoutViewModel.holds[currentHold].handHold,
              handleLeftGripChanged: (Grip grip) =>
                  workoutViewModel.setHoldLeftGrip(currentHold, grip),
              handleRightGripChanged: (Grip grip) =>
                  workoutViewModel.setHoldRightGrip(currentHold, grip),
              handleOneHandedTap: (HandType handType) {
                HandHolds handHold;
                if (handType == HandType.leftHand) {
                  handHold = HandHolds.oneHandedLeft;
                } else {
                  handHold = HandHolds.oneHandedRight;
                }
                workoutViewModel.setHoldHandHold(currentHold, handHold);
              },
              handleTwoHandedTap: () => workoutViewModel.setHoldHandHold(
                  currentHold, HandHolds.twoHanded),
            )
          ],
        ),
        Section(
          title: 'drag to choose',
          children: <Widget>[
            BoardHoldPicker(
                board: workoutViewModel.board,
                leftGrip: workoutViewModel.holds[currentHold].leftGrip,
                rightGrip: workoutViewModel.holds[currentHold].rightGrip,
                initialLeftGripBoardHold:
                    workoutViewModel.holds[currentHold].leftGripBoardHold,
                initialRightGripBoardHold:
                    workoutViewModel.holds[currentHold].rightGripBoardHold,
                handleLeftGripBoardHoldChanged: (BoardHold boardHold) =>
                    workoutViewModel.setHoldLeftGripBoardHold(
                        currentHold, boardHold),
                handleRightGripBoardHoldChanged: (BoardHold boardHold) =>
                    workoutViewModel.setHoldRightGripBoardHold(
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
                workoutViewModel.setHoldRepetitions(currentHold, n);
              },
              initialValue:
                  workoutViewModel.holds[currentHold].repetitions.toDouble(),
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
                workoutViewModel.setHoldHangTime(currentHold, s);
              },
              initialValue: workoutViewModel.holds[currentHold].hangTime.toDouble(),
              shouldLoseFocusStream: shouldLoseFocusStream,
              handleErrorMessage: handleErrorMessage,
            ),
            NumberInputAndDivider(
              isDouble: false,
              description: 'rest seconds between repetitions',
              shouldFocus: false,
              handleIntValueChanged: (int s) {
                workoutViewModel.setHoldRestBetweenRepetitions(currentHold, s);
              },
              initialValue: workoutViewModel
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
              description: settingsViewModel.unit == Units.metric ? 'kg' : 'pounds',
              shouldFocus: false,
              handleDoubleValueChanged: (double n) {
                workoutViewModel.setHoldAddedWeight(
                    currentHold, n.toDouble(), settingsViewModel.unit);
              },
              initialValue: settingsViewModel.unit == Units.metric
                  ? workoutViewModel.holds[currentHold].addedWeight
                  : UnitConversion.convertPoundsToKg(
                      workoutViewModel.holds[currentHold].addedWeight),
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
