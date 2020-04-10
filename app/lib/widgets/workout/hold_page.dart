import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/hold_page_vm.dart';
import 'package:app/view_models/workout/hold_page_vm_state.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description2.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/workout/card_container.dart';
import 'package:app/widgets/workout/hold_input_container.dart';
import 'package:app/widgets/workout/selected_grips_and_holds.dart';

class HoldPage extends StatelessWidget {
  HoldPage({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final HoldPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HoldPageInitialState>(
        stream: viewModel.initialState$,
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
                      handleLeftGripSelected: viewModel.handleLeftGripSelected,
                      handleLeftHandSelected: viewModel.handleLeftHandSelected,
                      handleOneHandedTap: viewModel.handleOneHandedTap,
                      handleRightGripSelected:
                          viewModel.handleRightGripSelected,
                      handleRightHandSelected:
                          viewModel.handleRightHandSelected,
                      handleTwoHandedTap: viewModel.handleTwoHandedTap,
                      setLeftGripBoardHold: viewModel.setLeftGripBoardHold,
                      setRightGripBoardHold: viewModel.setRightGripBoardHold,
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
                        handleValueChanged: viewModel.setRepetitions,
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
                        handleValueChanged: viewModel.setHangTime,
                        initialValue: _initialState.hangTime,
                      ),
                      Divider(
                        height: styles.Measurements.m,
                      ),
                      NumberInputAndDescription2(
                        enabled: _initialState.inputsEnabled,
                        primaryColor: _initialState.primaryColor,
                        description: 'rest seconds between repetitions',
                        handleValueChanged: viewModel.setRestBetweenRepetitions,
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
                        handleValueChanged: viewModel.setAddedWeight,
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
