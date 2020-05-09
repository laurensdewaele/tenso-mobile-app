import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/hold_page_vm.dart';
import 'package:app/view_models/workout/hold_page_vm_state.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/workout/board_hold_info.dart';
import 'package:app/widgets/workout/board_hold_picker.dart';
import 'package:app/widgets/workout/card_container.dart';
import 'package:app/widgets/workout/grip_picker_container.dart';
import 'package:app/widgets/workout/navigation_indicator.dart';
import 'package:app/widgets/workout/selected_grips_and_holds.dart';
import 'package:flutter/cupertino.dart';

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
                  Column(
                    children: <Widget>[
                      Section(
                        title:
                            'hold ${_state.currentHold} / ${_state.totalHolds}',
                        children: <Widget>[
                          GripPickerContainer(
                            textPrimaryColor: _state.textPrimaryColor,
                            primaryColor: _state.primaryColor,
                            handleLeftHandSelected:
                                _viewModel.handleLeftHandSelected,
                            handleRightHandSelected:
                                _viewModel.handleRightHandSelected,
                            handleOneHandedTap: _viewModel.handleOneHandedTap,
                            handleTwoHandedTap: _viewModel.handleTwoHandedTap,
                            rightGrip: _state.rightGrip,
                            leftGrip: _state.leftGrip,
                            handleRightGripSelected:
                                _viewModel.handleRightGripSelected,
                            handleLeftGripSelected:
                                _viewModel.handleLeftGripSelected,
                            handHold: _state.handHold,
                          )
                        ],
                      ),
                      Section(
                        title: 'drag to choose',
                        children: <Widget>[
                          LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final double _boardHeight =
                                constraints.maxWidth / _state.board.aspectRatio;
                            final Size _boardSize =
                                Size(constraints.maxWidth, _boardHeight);
                            final _gripHeight = _boardHeight *
                                _state.board.handToBoardHeightRatio;
                            final _boardWithGripsHeight =
                                _boardHeight + _gripHeight;
                            return Container(
                              height: _boardWithGripsHeight,
                              child: BoardHoldPicker(
                                boardHolds: _state.board.boardHolds.toList(),
                                boardSize: _boardSize,
                                gripHeight: _gripHeight,
                                customBoardHoldImages: _state
                                    .board.customBoardHoldImages
                                    ?.toList(),
                                imageAsset: _state.board.imageAsset,
                                leftGrip: _state.leftGrip,
                                rightGrip: _state.rightGrip,
                                leftGripBoardHold: _state.leftGripBoardHold,
                                rightGripBoardHold: _state.rightGripBoardHold,
                                handleLeftGripBoardHoldChanged:
                                    _viewModel.setLeftGripBoardHold,
                                handleRightGripBoardHoldChanged:
                                    _viewModel.setRightGripBoardHold,
                              ),
                            );
                          }),
                          BoardHoldInfo(
                            leftGripBoardHold: _state.leftGripBoardHold,
                            rightGripBoardHold: _state.rightGripBoardHold,
                            leftGrip: _state.leftGrip,
                            rightGrip: _state.rightGrip,
                          )
                        ],
                      ),
                    ],
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
