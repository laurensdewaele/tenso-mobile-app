import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/hold_page_vm.dart';
import 'package:app/view_models/workout/hold_page_vm_state.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/workout/card_container.dart';
import 'package:app/widgets/workout/hold_input_container.dart';
import 'package:app/widgets/workout/navigation_indicator.dart';
import 'package:app/widgets/workout/selected_grips_and_holds.dart';

class HoldPage extends StatefulWidget {
  HoldPage({Key key, this.workoutNavigator, this.workoutViewModel})
      : super(key: key);

  final WorkoutNavigator workoutNavigator;
  final WorkoutViewModel workoutViewModel;

  @override
  _HoldPageState createState() => _HoldPageState();
}

class _HoldPageState extends State<HoldPage> {
  HoldPageViewModel _viewModel;

  @override
  void initState() {
    _viewModel = HoldPageViewModel(
        workoutViewModel: widget.workoutViewModel,
        workoutNavigator: widget.workoutNavigator);
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HoldPageState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.state$,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          HoldPageState _state = snapshot?.data;
          return CardContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (_state.inputsEnabled == true)
                  HoldInputContainer(
                    board: _state.board,
                    currentHold: _state.currentHold,
                    handHold: _state.handHold,
                    totalHolds: _state.totalHolds,
                    leftGrip: _state.leftGrip,
                    leftGripBoardHold: _state.leftGripBoardHold,
                    primaryColor: _state.primaryColor,
                    rightGrip: _state.rightGrip,
                    rightGripBoardHold: _state.rightGripBoardHold,
                    textPrimaryColor: _state.textPrimaryColor,
                    handleLeftGripSelected: _viewModel.handleLeftGripSelected,
                    handleLeftHandSelected: _viewModel.handleLeftHandSelected,
                    handleOneHandedTap: _viewModel.handleOneHandedTap,
                    handleRightGripSelected: _viewModel.handleRightGripSelected,
                    handleRightHandSelected: _viewModel.handleRightHandSelected,
                    handleTwoHandedTap: _viewModel.handleTwoHandedTap,
                    setLeftGripBoardHold: _viewModel.setLeftGripBoardHold,
                    setRightGripBoardHold: _viewModel.setRightGripBoardHold,
                  ),
                if (_state.inputsEnabled != true)
                  SelectedGripsAndHolds(
                    board: _state.board,
                    leftGrip: _state.leftGrip,
                    leftGripBoardHold: _state.leftGripBoardHold,
                    rightGrip: _state.rightGrip,
                    rightGripBoardHold: _state.rightGripBoardHold,
                    totalHolds: _state.totalHolds,
                    currentHold: _state.currentHold,
                  ),
                Section(
                  title: 'basics',
                  children: <Widget>[
                    NumberInputAndDescription<int>(
                      key: ValueKey(
                          'hold-page-repetitions-${_state.currentHoldIndex}'),
                      enabled: _state.inputsEnabled,
                      primaryColor: _state.primaryColor,
                      description: 'repetitions',
                      handleValueChanged: _viewModel.setRepetitions,
                      initialValue: _state.repetitions,
                    ),
                    Divider(
                      height: styles.Measurements.m,
                    ),
                  ],
                ),
                Section(
                  title: 'timers',
                  children: <Widget>[
                    NumberInputAndDescription<int>(
                      key: ValueKey(
                          'hold-page-hang_time_seconds-${_state.currentHoldIndex}'),
                      enabled: _state.inputsEnabled,
                      primaryColor: _state.primaryColor,
                      description: 'hang time seconds',
                      handleValueChanged: _viewModel.setHangTime,
                      initialValue: _state.hangTime,
                    ),
                    if (_state.countdownRestTimer == true)
                      Column(
                        children: <Widget>[
                          Divider(
                            height: styles.Measurements.m,
                          ),
                          NumberInputAndDescription<int>(
                            key: ValueKey(
                                'hold-page-countdown_rest_duration-${_state.currentHoldIndex}'),
                            enabled: _state.inputsEnabled,
                            primaryColor: _state.primaryColor,
                            description: 'rest seconds after hang',
                            handleValueChanged:
                                _viewModel.setCountdownRestDuration,
                            initialValue: _state.countdownRestDuration,
                          ),
                        ],
                      ),
                    Divider(
                      height: styles.Measurements.m,
                    ),
                  ],
                ),
                Section(
                  title: 'added weight',
                  children: <Widget>[
                    NumberInputAndDescription<double>(
                      key: ValueKey(
                          'hold-page-added_weight-${_state.currentHoldIndex}'),
                      enabled: _state.inputsEnabled,
                      primaryColor: _state.primaryColor,
                      description: _state.weightUnitDescription,
                      handleValueChanged: _viewModel.setAddedWeight,
                      initialValue: _state.addedWeight,
                    ),
                    Divider(
                      height: styles.Measurements.m,
                    ),
                  ],
                ),
                Divider(
                  height: styles.Measurements.xxl,
                ),
                NavigationIndicator(
                  primaryColor: _state.primaryColor,
                  activeIndex: _state.currentHoldIndex + 1,
                  count: _state.totalHolds + 2,
                  handleBackNavigation:
                      widget.workoutNavigator.handleBackRequest,
                  handleForwardNavigation:
                      widget.workoutNavigator.handleForwardRequest,
                )
              ],
            ),
          );
        });
  }
}
