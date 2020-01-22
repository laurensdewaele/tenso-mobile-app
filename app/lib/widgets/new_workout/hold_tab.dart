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
    final workoutStateModel = Provider.of<WorkoutStateModel>(context, listen: true);
    final settingsStateModel = Provider.of<SettingsStateModel>(context, listen: false);

    final String _currentHoldString = (currentHold + 1).toString();
    final String _totalHoldsString = workoutStateModel.holdCount.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'hold $_currentHoldString / $_totalHoldsString',
          children: <Widget>[
            GripPickerContainer(
              currentHold: currentHold,
              selectedLeftGrip: workoutStateModel.holds[currentHold].leftGrip,
              selectedRightGrip: workoutStateModel.holds[currentHold].rightGrip,
              selectedHandHold: workoutStateModel.holds[currentHold].handHold,
              handleLeftGripChanged: (Grip grip) =>
                  workoutStateModel.setHoldLeftGrip(currentHold, grip),
              handleRightGripChanged: (Grip grip) =>
                  workoutStateModel.setHoldRightGrip(currentHold, grip),
              handleOneHandedTap: (HandTypes handType) {
                HandHolds handHold;
                if (handType == HandTypes.leftHand) {
                  handHold = HandHolds.oneHandedLeft;
                } else {
                  handHold = HandHolds.oneHandedRight;
                }
                workoutStateModel.setHoldHandHold(currentHold, handHold);
              },
              handleTwoHandedTap: () => workoutStateModel.setHoldHandHold(
                  currentHold, HandHolds.twoHanded),
            )
          ],
        ),
        Section(
          title: 'drag to choose',
          children: <Widget>[
            BoardHoldPicker(
                board: workoutStateModel.board,
                leftGrip: workoutStateModel.holds[currentHold].leftGrip,
                rightGrip: workoutStateModel.holds[currentHold].rightGrip,
                initialLeftGripBoardHold:
                    workoutStateModel.holds[currentHold].leftGripBoardHold,
                initialRightGripBoardHold:
                    workoutStateModel.holds[currentHold].rightGripBoardHold,
                handleLeftGripBoardHoldChanged: (BoardHold boardHold) =>
                    workoutStateModel.setHoldLeftGripBoardHold(
                        currentHold, boardHold),
                handleRightGripBoardHoldChanged: (BoardHold boardHold) =>
                    workoutStateModel.setHoldRightGripBoardHold(
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
                workoutStateModel.setHoldRepetitions(currentHold, n);
              },
              initialValue:
                  workoutStateModel.holds[currentHold].repetitions.toDouble(),
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
                workoutStateModel.setHoldHangTime(currentHold, s);
              },
              initialValue: workoutStateModel.holds[currentHold].hangTime.toDouble(),
              shouldLoseFocusStream: shouldLoseFocusStream,
              handleErrorMessage: handleErrorMessage,
            ),
            NumberInputAndDivider(
              isDouble: false,
              description: 'rest seconds between repetitions',
              shouldFocus: false,
              handleIntValueChanged: (int s) {
                workoutStateModel.setHoldRestBetweenRepetitions(currentHold, s);
              },
              initialValue: workoutStateModel
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
              description: settingsStateModel.unit == Units.metric ? 'kg' : 'pounds',
              shouldFocus: false,
              handleDoubleValueChanged: (double n) {
                workoutStateModel.setHoldAddedWeight(
                    currentHold, n.toDouble(), settingsStateModel.unit);
              },
              initialValue: settingsStateModel.unit == Units.metric
                  ? workoutStateModel.holds[currentHold].addedWeight
                  : UnitConversion.convertPoundsToKg(
                      workoutStateModel.holds[currentHold].addedWeight),
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
