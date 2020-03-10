import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/unit.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/hold_tab_vm.dart';
import 'package:app/view_models/workout_vm.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/new_or_edit_workout/board_hold_info.dart';
import 'package:app/widgets/new_or_edit_workout/board_hold_picker.dart';
import 'package:app/widgets/new_or_edit_workout/grip_picker_container.dart';
import 'package:app/widgets/new_or_edit_workout/integer_input_and_divider.dart';
import 'package:app/widgets/section.dart';

class HoldTab extends StatelessWidget {
  HoldTab({
    Key key,
    @required this.currentHold,
    @required this.shouldLoseFocusStream,
  }) : super(key: key);

  final int currentHold;
  final Stream<bool> shouldLoseFocusStream;

  @override
  Widget build(BuildContext context) {
    // We cannot listen to appState here to get our workout.
    // This is because we need to determine if it's an editWorkout or newWorkout.
    // Which WorkoutViewModel does ofc.
    final _workoutViewModel =
        Provider.of<WorkoutViewModel>(context, listen: true);
    final _settings = Provider.of<AppState>(context, listen: true).settings;
    final _holdTabViewModel =
        Provider.of<HoldTabViewModel>(context, listen: false);

    final String _currentHoldString = (currentHold + 1).toString();
    final String _totalHoldsString =
        _workoutViewModel.workout.holdCount.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'hold $_currentHoldString / $_totalHoldsString',
          children: <Widget>[
            GripPickerContainer(
              textPrimaryColor: _workoutViewModel.textPrimaryColor,
              primaryColor: _workoutViewModel.primaryColor,
              handleLeftHandSelected: (HandHold handHold) => _holdTabViewModel
                  .handleLeftHandSelected(currentHold, handHold),
              handleRightHandSelected: (HandHold handHold) => _holdTabViewModel
                  .handleRightHandSelected(currentHold, handHold),
              handleOneHandedTap: (HandHold handHold) =>
                  _holdTabViewModel.handleOneHandedTap(currentHold, handHold),
              handleTwoHandedTap: (HandHold handHold) =>
                  _holdTabViewModel.handleTwoHandedTap(currentHold, handHold),
              rightGrip: _workoutViewModel
                  .workout.holds[currentHold].rightGrip,
              leftGrip: _workoutViewModel
                  .workout.holds[currentHold].leftGrip,
              handleRightGripSelected: (Grip grip) =>
                  _holdTabViewModel.handleRightGripSelected(currentHold, grip),
              handleLeftGripSelected: (Grip grip) =>
                  _holdTabViewModel.handleLeftGripSelected(currentHold, grip),
              handHold: _workoutViewModel
                  .workout.holds[currentHold].handHold,
            )
          ],
        ),
        Section(
          title: 'drag to choose',
          children: <Widget>[
            BoardHoldPicker(
              board: _workoutViewModel.workout.board,
              leftGrip: _workoutViewModel
                  .workout.holds[currentHold].leftGrip,
              rightGrip: _workoutViewModel
                  .workout.holds[currentHold].rightGrip,
              leftGripBoardHold: _workoutViewModel
                  .workout.holds[currentHold].leftGripBoardHold,
              rightGripBoardHold: _workoutViewModel
                  .workout.holds[currentHold].rightGripBoardHold,
              handleLeftGripBoardHoldChanged: (BoardHold boardHold) =>
                  _holdTabViewModel.setHoldLeftGripBoardHold(
                      currentHold, boardHold),
              handleRightGripBoardHoldChanged: (BoardHold boardHold) =>
                  _holdTabViewModel.setHoldRightGripBoardHold(
                      currentHold, boardHold),
            ),
            Divider(
              key: UniqueKey(),
              height: styles.Measurements.m,
            ),
            BoardHoldInfo(
              leftGripBoardHold: _workoutViewModel
                  .workout.holds[currentHold].leftGripBoardHold,
              rightGripBoardHold: _workoutViewModel
                  .workout.holds[currentHold].rightGripBoardHold,
            )
          ],
        ),
        Section(
          title: 'basics',
          children: <Widget>[
            NumberInputAndDivider(
              primaryColor: _workoutViewModel.primaryColor,
              isDouble: false,
              description: 'repetitions',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                _holdTabViewModel.setHoldRepetitions(currentHold, n);
              },
              initialValue: _workoutViewModel
                  .workout.holds[currentHold].repetitions
                  .toDouble(),
              shouldLoseFocusStream: shouldLoseFocusStream,
            ),
          ],
        ),
        Section(
          title: 'timers',
          children: <Widget>[
            NumberInputAndDivider(
              primaryColor: _workoutViewModel.primaryColor,
              isDouble: false,
              description: 'hang time seconds',
              shouldFocus: false,
              handleIntValueChanged: (int s) {
                _holdTabViewModel.setHoldHangTime(currentHold, s);
              },
              initialValue: _workoutViewModel
                  .workout.holds[currentHold].hangTime
                  .toDouble(),
              shouldLoseFocusStream: shouldLoseFocusStream,
            ),
            NumberInputAndDivider(
              primaryColor: _workoutViewModel.primaryColor,
              isDouble: false,
              description: 'rest seconds between repetitions',
              shouldFocus: false,
              handleIntValueChanged: (int s) {
                _holdTabViewModel.setHoldRestBetweenRepetitions(currentHold, s);
              },
              initialValue: _workoutViewModel
                  .workout.holds[currentHold].restBetweenRepetitions
                  .toDouble(),
              shouldLoseFocusStream: shouldLoseFocusStream,
            ),
          ],
        ),
        Section(
          title: 'added weight',
          children: <Widget>[
            NumberInputAndDivider(
              primaryColor: _workoutViewModel.primaryColor,
              zeroValueAllowed: true,
              description: _settings.unit == Unit.metric ? 'kg' : 'lb',
              shouldFocus: false,
              handleDoubleValueChanged: (double n) {
                _holdTabViewModel.setHoldAddedWeight(
                    currentHold, n, _settings.unit);
              },
              initialValue: _workoutViewModel
                  .workout.holds[currentHold].addedWeight,
              isDouble: true,
              shouldLoseFocusStream: shouldLoseFocusStream,
            ),
          ],
        ),
      ],
    );
  }
}
