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
    final workoutModel = Provider.of<WorkoutModel>(context, listen: true);
    final settingsModel = Provider.of<SettingsModel>(context, listen: false);

    final String _currentHoldString = (currentHold + 1).toString();
    final String _totalHoldsString = workoutModel.holdCount.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'hold $_currentHoldString / $_totalHoldsString',
          children: <Widget>[
            GripPickerContainer(
              currentHold: currentHold,
              selectedLeftGrip: workoutModel.holds[currentHold].leftGrip,
              selectedRightGrip: workoutModel.holds[currentHold].rightGrip,
              selectedHandHold: workoutModel.holds[currentHold].handHold,
              handleLeftGripChanged: (Grip grip) =>
                  workoutModel.setHoldLeftGrip(currentHold, grip),
              handleRightGripChanged: (Grip grip) =>
                  workoutModel.setHoldRightGrip(currentHold, grip),
              handleOneHandedTap: (HandTypes handType) {
                HandHolds handHold;
                if (handType == HandTypes.leftHand) {
                  handHold = HandHolds.oneHandedLeft;
                } else {
                  handHold = HandHolds.oneHandedRight;
                }
                workoutModel.setHoldHandHold(currentHold, handHold);
              },
              handleTwoHandedTap: () => workoutModel.setHoldHandHold(
                  currentHold, HandHolds.twoHanded),
            )
          ],
        ),
        Section(
          title: 'drag to choose',
          children: <Widget>[
            BoardHoldPicker(
                board: workoutModel.board,
                leftGrip: workoutModel.holds[currentHold].leftGrip,
                rightGrip: workoutModel.holds[currentHold].rightGrip,
                initialLeftGripBoardHold:
                    workoutModel.holds[currentHold].leftGripBoardHold,
                initialRightGripBoardHold:
                    workoutModel.holds[currentHold].rightGripBoardHold,
                handleLeftGripBoardHoldChanged: (BoardHold boardHold) =>
                    workoutModel.setHoldLeftGripBoardHold(
                        currentHold, boardHold),
                handleRightGripBoardHoldChanged: (BoardHold boardHold) =>
                    workoutModel.setHoldRightGripBoardHold(
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
              handleValueChanged: (int n) {
                workoutModel.setHoldRepetitions(currentHold, n);
              },
              initialValue:
                  workoutModel.holds[currentHold].repetitions.toDouble(),
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
              handleValueChanged: (int s) {
                workoutModel.setHoldHangTime(currentHold, s);
              },
              initialValue: workoutModel.holds[currentHold].hangTime.toDouble(),
              shouldLoseFocusStream: shouldLoseFocusStream,
              handleErrorMessage: handleErrorMessage,
            ),
            NumberInputAndDivider(
              isDouble: false,
              description: 'rest seconds between repetitions',
              shouldFocus: false,
              handleValueChanged: (int s) {
                workoutModel.setHoldRestBetweenRepetitions(currentHold, s);
              },
              initialValue: workoutModel
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
              description: settingsModel.unit == Units.metric ? 'kg' : 'pounds',
              shouldFocus: false,
              handleValueChanged: (int n) {
                workoutModel.setHoldAddedWeight(
                    currentHold, n.toDouble(), settingsModel.unit);
              },
              initialValue: settingsModel.unit == Units.metric
                  ? workoutModel.holds[currentHold].addedWeight.toInt()
                  : UnitConversion.convertPoundsToKg(
                      workoutModel.holds[currentHold].addedWeight),
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
