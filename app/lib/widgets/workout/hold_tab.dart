import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/models/unit.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/hold_tab_vm.dart';
import 'package:app/view_models/workout_vm.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/workout/hold_input_container.dart';
import 'package:app/widgets/workout/selected_grips_and_holds.dart';

class HoldTab extends StatelessWidget {
  HoldTab({
    Key key,
    @required this.currentHold,
  }) : super(key: key);

  final int currentHold;

  @override
  Widget build(BuildContext context) {
    final _workoutViewModel =
        Provider.of<WorkoutViewModel>(context, listen: true);
    final _holdTabViewModel =
        Provider.of<HoldTabViewModel>(context, listen: false);
    final _appState = Provider.of<AppState>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (_workoutViewModel.inputsEnabled == true)
          HoldInputContainer(
            board: _appState.workout.board,
            currentHold: currentHold,
            handHold: _appState.workout.holds[currentHold].handHold,
            holdCount: _appState.workout.holdCount,
            leftGrip: _appState.workout.holds[currentHold].leftGrip,
            leftGripBoardHold:
                _appState.workout.holds[currentHold].leftGripBoardHold,
            primaryColor: _workoutViewModel.primaryColor,
            rightGrip: _appState.workout.holds[currentHold].rightGrip,
            rightGripBoardHold:
                _appState.workout.holds[currentHold].rightGripBoardHold,
            textPrimaryColor: _workoutViewModel.textPrimaryColor,
            handleLeftGripSelected: _holdTabViewModel.handleLeftGripSelected,
            handleLeftHandSelected: _holdTabViewModel.handleLeftHandSelected,
            handleOneHandedTap: _holdTabViewModel.handleOneHandedTap,
            handleRightGripSelected: _holdTabViewModel.handleRightGripSelected,
            handleRightHandSelected: _holdTabViewModel.handleRightHandSelected,
            handleTwoHandedTap: _holdTabViewModel.handleTwoHandedTap,
            setHoldLeftGripBoardHold:
                _holdTabViewModel.setHoldLeftGripBoardHold,
            setHoldRightGripBoardHold:
                _holdTabViewModel.setHoldRightGripBoardHold,
          ),
        if (_workoutViewModel.inputsEnabled != true)
          SelectedGripsAndHolds(
            board: _appState.workout.board,
            leftGrip: _appState.workout.holds[currentHold].leftGrip,
            leftGripBoardHold:
                _appState.workout.holds[currentHold].leftGripBoardHold,
            rightGrip: _appState.workout.holds[currentHold].rightGrip,
            rightGripBoardHold:
                _appState.workout.holds[currentHold].rightGripBoardHold,
            holdCount: _appState.workout.holdCount,
            currentHold: currentHold,
          ),
        Section(
          title: 'basics',
          children: <Widget>[
            NumberInputAndDescription(
              enabled: _workoutViewModel.inputsEnabled,
              primaryColor: _workoutViewModel.primaryColor,
              isDouble: false,
              description: 'repetitions',
              handleIntValueChanged: (int n) {
                _holdTabViewModel.setHoldRepetitions(currentHold, n);
              },
              initialIntValue: _appState.workout.holds[currentHold].repetitions,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
          ],
        ),
        Section(
          title: 'timers',
          children: <Widget>[
            NumberInputAndDescription(
              enabled: _workoutViewModel.inputsEnabled,
              primaryColor: _workoutViewModel.primaryColor,
              isDouble: false,
              description: 'hang time seconds',
              handleIntValueChanged: (int s) {
                _holdTabViewModel.setHoldHangTime(currentHold, s);
              },
              initialIntValue: _appState.workout.holds[currentHold].hangTime,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            NumberInputAndDescription(
              enabled: _workoutViewModel.inputsEnabled,
              primaryColor: _workoutViewModel.primaryColor,
              isDouble: false,
              description: 'rest seconds between repetitions',
              handleIntValueChanged: (int s) {
                _holdTabViewModel.setHoldRestBetweenRepetitions(currentHold, s);
              },
              initialIntValue:
                  _appState.workout.holds[currentHold].restBetweenRepetitions,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
          ],
        ),
        Section(
          title: 'added weight',
          children: <Widget>[
            NumberInputAndDescription(
              enabled: _workoutViewModel.inputsEnabled,
              primaryColor: _workoutViewModel.primaryColor,
              zeroValueAllowed: true,
              description: _appState.settings.unit == Unit.metric ? 'kg' : 'lb',
              handleDoubleValueChanged: (double n) {
                _holdTabViewModel.setHoldAddedWeight(
                    currentHold, n, _appState.settings.unit);
              },
              initialDoubleValue:
                  _appState.workout.holds[currentHold].addedWeight,
              isDouble: true,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
          ],
        ),
      ],
    );
  }
}
