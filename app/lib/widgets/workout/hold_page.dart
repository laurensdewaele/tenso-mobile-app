import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/hold_page_vm.dart';
import 'package:app/view_models/workout/hold_page_vm_state.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description2.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/workout/card_container.dart';
import 'package:app/widgets/workout/hold_input_container.dart';
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
    return StreamBuilder<HoldPageInitialState>(
        stream: _viewModel.initialState$,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          HoldPageInitialState _initialState = snapshot?.data;
          if (_initialState == null) {
            return Container();
          } else {
            return CardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (_initialState.inputsEnabled == true)
                    HoldInputContainer(
                      board: _initialState.board,
                      currentHold: _initialState.currentHold,
                      handHold: _initialState.handHold,
                      totalHolds: _initialState.totalHolds,
                      leftGrip: _initialState.leftGrip,
                      leftGripBoardHold: _initialState.leftGripBoardHold,
                      primaryColor: _initialState.primaryColor,
                      rightGrip: _initialState.rightGrip,
                      rightGripBoardHold: _initialState.rightGripBoardHold,
                      textPrimaryColor: _initialState.textPrimaryColor,
                      handleLeftGripSelected: _viewModel.handleLeftGripSelected,
                      handleLeftHandSelected: _viewModel.handleLeftHandSelected,
                      handleOneHandedTap: _viewModel.handleOneHandedTap,
                      handleRightGripSelected:
                          _viewModel.handleRightGripSelected,
                      handleRightHandSelected:
                          _viewModel.handleRightHandSelected,
                      handleTwoHandedTap: _viewModel.handleTwoHandedTap,
                      setLeftGripBoardHold: _viewModel.setLeftGripBoardHold,
                      setRightGripBoardHold: _viewModel.setRightGripBoardHold,
                    ),
                  if (_initialState.inputsEnabled != true)
                    SelectedGripsAndHolds(
                      board: _initialState.board,
                      leftGrip: _initialState.leftGrip,
                      leftGripBoardHold: _initialState.leftGripBoardHold,
                      rightGrip: _initialState.rightGrip,
                      rightGripBoardHold: _initialState.rightGripBoardHold,
                      totalHolds: _initialState.totalHolds,
                      currentHold: _initialState.currentHold,
                    ),
                  Section(
                    title: 'basics',
                    children: <Widget>[
                      NumberInputAndDescription2(
                        enabled: _initialState.inputsEnabled,
                        primaryColor: _initialState.primaryColor,
                        description: 'repetitions',
                        handleValueChanged: _viewModel.setRepetitions,
                        initialValue: _initialState.repetitions,
                      ),
                      Divider(
                        height: styles.Measurements.m,
                      ),
                    ],
                  ),
                  Section(
                    title: 'timers',
                    children: <Widget>[
                      NumberInputAndDescription2(
                        enabled: _initialState.inputsEnabled,
                        primaryColor: _initialState.primaryColor,
                        description: 'hang time seconds',
                        handleValueChanged: _viewModel.setHangTime,
                        initialValue: _initialState.hangTime,
                      ),
                      Divider(
                        height: styles.Measurements.m,
                      ),
                      NumberInputAndDescription2(
                        enabled: _initialState.inputsEnabled,
                        primaryColor: _initialState.primaryColor,
                        description: 'rest seconds between repetitions',
                        handleValueChanged:
                            _viewModel.setRestBetweenRepetitions,
                        initialValue: _initialState.restBetweenRepetitions,
                      ),
                      Divider(
                        height: styles.Measurements.m,
                      ),
                    ],
                  ),
                  Section(
                    title: 'added weight',
                    children: <Widget>[
                      NumberInputAndDescription2(
                        enabled: _initialState.inputsEnabled,
                        primaryColor: _initialState.primaryColor,
                        description: _initialState.weightUnitDescription,
                        handleValueChanged: _viewModel.setAddedWeight,
                        initialValue: _initialState.addedWeight,
                      ),
                      Divider(
                        height: styles.Measurements.m,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }
}
