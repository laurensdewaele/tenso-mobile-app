import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/functions/unit_conversion.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/unit.dart';
import 'package:app/view_models/app_state_vm.dart';
import 'package:app/view_models/hold_tab_vm.dart';
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
    final _workout = Provider.of<AppState>(context, listen: true).workout;
    final _settings = Provider.of<AppState>(context, listen: false).settings;
    final _viewModel = Provider.of<HoldTabViewModel>(context, listen: false);

    final String _currentHoldString = (currentHold + 1).toString();
    final String _totalHoldsString = _workout.holdCount.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'hold $_currentHoldString / $_totalHoldsString',
          children: <Widget>[
            GripPickerContainer(
              currentHold: currentHold,
            )
          ],
        ),
        Section(
          title: 'drag to choose',
          children: <Widget>[
            BoardHoldPicker(
                board: _workout.board,
                leftGrip: _workout.holds[currentHold].leftGrip,
                rightGrip: _workout.holds[currentHold].rightGrip,
                initialLeftGripBoardHold:
                    _workout.holds[currentHold].leftGripBoardHold,
                initialRightGripBoardHold:
                    _workout.holds[currentHold].rightGripBoardHold,
                handleLeftGripBoardHoldChanged: (BoardHold boardHold) =>
                    _viewModel.setHoldLeftGripBoardHold(currentHold, boardHold),
                handleRightGripBoardHoldChanged: (BoardHold boardHold) =>
                    _viewModel.setHoldRightGripBoardHold(
                        currentHold, boardHold),
                handleErrorMessage: (Widget message) =>
                    handleErrorMessage(message))
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
                _viewModel.setHoldRepetitions(currentHold, n);
              },
              initialValue: _workout.holds[currentHold].repetitions.toDouble(),
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
                _viewModel.setHoldHangTime(currentHold, s);
              },
              initialValue: _workout.holds[currentHold].hangTime.toDouble(),
              shouldLoseFocusStream: shouldLoseFocusStream,
              handleErrorMessage: handleErrorMessage,
            ),
            NumberInputAndDivider(
              isDouble: false,
              description: 'rest seconds between repetitions',
              shouldFocus: false,
              handleIntValueChanged: (int s) {
                _viewModel.setHoldRestBetweenRepetitions(currentHold, s);
              },
              initialValue:
                  _workout.holds[currentHold].restBetweenRepetitions.toDouble(),
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
              description: _settings.unit == Unit.metric ? 'kg' : 'pounds',
              shouldFocus: false,
              handleDoubleValueChanged: (double n) {
                _viewModel.setHoldAddedWeight(
                    currentHold, n.toDouble(), _settings.unit);
              },
              initialValue: _settings.unit == Unit.metric
                  ? _workout.holds[currentHold].addedWeight
                  : UnitConversion.convertPoundsToKg(
                      _workout.holds[currentHold].addedWeight),
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
