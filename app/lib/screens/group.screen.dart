import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/group.vm.dart';
import 'package:app/view_models/workout/workout.vm.dart';
import 'package:app/widgets/board/board_hold_info.dart';
import 'package:app/widgets/board/board_hold_picker.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/tabs.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:app/widgets/workout/grip_picker_container.dart';
import 'package:app/widgets/workout/selected_grips_and_holds.dart';
import 'package:flutter/cupertino.dart';

class GroupScreenArguments {
  final Group group;
  final WorkoutTypes workoutType;
  final WeightSystem weightSystem;

  const GroupScreenArguments(
      {@required this.group,
      @required this.workoutType,
      @required this.weightSystem});
}

class GroupScreen extends StatefulWidget {
  const GroupScreen();

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  GroupViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewModel == null) {
      final GroupScreenArguments _arguments =
          ModalRoute.of(context).settings.arguments;
      _viewModel = GroupViewModel(
          group: _arguments.group,
          workoutType: _arguments.workoutType,
          weightSystem: _arguments.weightSystem);
      _viewModel.addListener(_viewModelListener);
    }
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAndToastProvider(
      child: Screen(
          handleBackNavigation: () => Navigator.of(context).pop(),
          backgroundColor: _viewModel.state.primaryColor,
          child: KeyboardListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  TopNavigation(
                    title: _viewModel.state.title,
                  ),
                  Divider(height: styles.Measurements.xxl),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: styles.Measurements.xs),
                    child: Card(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: styles.Measurements.m,
                                vertical: styles.Measurements.l),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                if (_viewModel.state.inputsEnabled == true)
                                  Column(
                                    children: <Widget>[
                                      Section(
                                        title: 'Grip',
                                        children: <Widget>[
                                          GripPickerContainer(
                                            textPrimaryColor: _viewModel
                                                .state.textPrimaryColor,
                                            primaryColor:
                                                _viewModel.state.primaryColor,
                                            handleLeftHandSelected: _viewModel
                                                .handleLeftHandSelected,
                                            handleRightHandSelected: _viewModel
                                                .handleRightHandSelected,
                                            handleOneHandedTap:
                                                _viewModel.handleOneHandedTap,
                                            handleTwoHandedTap:
                                                _viewModel.handleTwoHandedTap,
                                            rightGrip:
                                                _viewModel.state.rightGrip,
                                            leftGrip: _viewModel.state.leftGrip,
                                            handleRightGripSelected: _viewModel
                                                .handleRightGripSelected,
                                            handleLeftGripSelected: _viewModel
                                                .handleLeftGripSelected,
                                            handHold: _viewModel.state.handHold,
                                          )
                                        ],
                                      ),
                                      Section(
                                        title: 'drag to choose',
                                        children: <Widget>[
                                          BoardHoldPicker(
                                            handToBoardHeightRatio: _viewModel
                                                .state
                                                .board
                                                .handToBoardHeightRatio,
                                            boardAspectRatio: _viewModel
                                                .state.board.aspectRatio,
                                            boardHolds: _viewModel
                                                .state.board.boardHolds
                                                .toList(),
                                            customBoardHoldImages: _viewModel
                                                .state
                                                .board
                                                .customBoardHoldImages
                                                ?.toList(),
                                            boardImageAsset: _viewModel
                                                .state.board.imageAsset,
                                            boardImageAssetWidth: _viewModel
                                                .state.board.imageAssetWidth,
                                            leftGrip: _viewModel.state.leftGrip,
                                            rightGrip:
                                                _viewModel.state.rightGrip,
                                            leftGripBoardHold: _viewModel
                                                .state.leftGripBoardHold,
                                            rightGripBoardHold: _viewModel
                                                .state.rightGripBoardHold,
                                            handleLeftGripBoardHoldChanged:
                                                _viewModel.setLeftGripBoardHold,
                                            handleRightGripBoardHoldChanged:
                                                _viewModel
                                                    .setRightGripBoardHold,
                                          ),
                                          BoardHoldInfo(
                                            leftGripBoardHold: _viewModel
                                                .state.leftGripBoardHold,
                                            rightGripBoardHold: _viewModel
                                                .state.rightGripBoardHold,
                                            leftGrip: _viewModel.state.leftGrip,
                                            rightGrip:
                                                _viewModel.state.rightGrip,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                if (_viewModel.state.inputsEnabled != true)
                                  SelectedGripsAndHolds(
                                    board: _viewModel.state.board,
                                    leftGrip: _viewModel.state.leftGrip,
                                    leftGripBoardHold:
                                        _viewModel.state.leftGripBoardHold,
                                    rightGrip: _viewModel.state.rightGrip,
                                    rightGripBoardHold:
                                        _viewModel.state.rightGripBoardHold,
                                  ),
                                Section(
                                  title: 'basics',
                                  children: <Widget>[
                                    // TODO: Repeaters toggler
                                    NumberInputAndDescription<int>(
                                      enabled: _viewModel.state.inputsEnabled,
                                      primaryColor:
                                          _viewModel.state.primaryColor,
                                      description: 'repetitions',
                                      handleValueChanged:
                                          _viewModel.setRepetitions,
                                      initialValue:
                                          _viewModel.state.repetitions,
                                    ),
                                    Divider(
                                      height: styles.Measurements.m,
                                    ),
                                    NumberInputAndDescription<int>(
                                      enabled: _viewModel.state.inputsEnabled,
                                      primaryColor:
                                          _viewModel.state.primaryColor,
                                      description: 'hang time seconds',
                                      handleValueChanged:
                                          _viewModel.setHangTimeS,
                                      initialValue: _viewModel.state.hangTimeS,
                                    ),
                                    if (_viewModel.state.repeaters == true)
                                      Column(
                                        children: <Widget>[
                                          Divider(
                                            height: styles.Measurements.m,
                                          ),
                                          NumberInputAndDescription<int>(
                                            enabled:
                                                _viewModel.state.inputsEnabled,
                                            primaryColor:
                                                _viewModel.state.primaryColor,
                                            description: 'rest between reps',
                                            handleValueChanged:
                                                _viewModel.setRestBetweenRepsS,
                                            initialValue: _viewModel
                                                .state.restBetweenRepsS,
                                          ),
                                          Divider(
                                            height: styles.Measurements.m,
                                          ),
                                          NumberInputAndDescription<int>(
                                            enabled:
                                                _viewModel.state.inputsEnabled,
                                            primaryColor:
                                                _viewModel.state.primaryColor,
                                            description: 'sets',
                                            handleValueChanged:
                                                _viewModel.setSets,
                                            initialValue: _viewModel.state.sets,
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                                if (_viewModel.state.repeaters == true)
                                  Section(
                                    title: 'Rest between sets',
                                    children: <Widget>[
                                      Tabs(
                                        leftText: 'Fixed',
                                        rightText: 'Variable',
                                        handleLeftTap:
                                            _viewModel.setRestBetweenSetsFixed,
                                        handleRightTap: _viewModel
                                            .setRestBetweenSetsVariable,
                                        isLeftSelected: _viewModel
                                                .state.restBetweenSetsFixed ==
                                            true,
                                        isRightSelected: _viewModel
                                                .state.restBetweenSetsFixed ==
                                            false,
                                        primaryColor:
                                            _viewModel.state.primaryColor,
                                        textPrimaryColor:
                                            _viewModel.state.textPrimaryColor,
                                      ),
                                      Divider(
                                        height: styles.Measurements.m,
                                      ),
                                      NumberInputAndDescription<int>(
                                        enabled: _viewModel.state.inputsEnabled,
                                        primaryColor:
                                            _viewModel.state.primaryColor,
                                        description:
                                            'rest seconds between sets',
                                        handleValueChanged:
                                            _viewModel.setRestBetweenSetsS,
                                        initialValue:
                                            _viewModel.state.restBetweenSetsS,
                                      ),
                                      Divider(
                                        height: styles.Measurements.m,
                                      ),
                                    ],
                                  ),
                                if (_viewModel.state.repeaters == false)
                                  Section(
                                    title: 'Rest between repetitions',
                                    children: <Widget>[
                                      Tabs(
                                        leftText: 'Fixed',
                                        rightText: 'Variable',
                                        handleLeftTap:
                                            _viewModel.setRestBetweenRepsFixed,
                                        handleRightTap: _viewModel
                                            .setRestBetweenRepsVariable,
                                        isLeftSelected: _viewModel
                                                .state.restBetweenRepsFixed ==
                                            true,
                                        isRightSelected: _viewModel
                                                .state.restBetweenRepsFixed ==
                                            false,
                                        primaryColor:
                                            _viewModel.state.primaryColor,
                                        textPrimaryColor:
                                            _viewModel.state.textPrimaryColor,
                                      ),
                                      Divider(
                                        height: styles.Measurements.m,
                                      ),
                                      NumberInputAndDescription<int>(
                                        enabled: _viewModel.state.inputsEnabled,
                                        primaryColor:
                                            _viewModel.state.primaryColor,
                                        description:
                                            'rest seconds between repetitions',
                                        handleValueChanged:
                                            _viewModel.setRestBetweenRepsS,
                                        initialValue:
                                            _viewModel.state.restBetweenRepsS,
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
                                      enabled: _viewModel.state.inputsEnabled,
                                      primaryColor:
                                          _viewModel.state.primaryColor,
                                      description: _viewModel.state.weightUnit,
                                      handleValueChanged:
                                          _viewModel.setAddedWeight,
                                      initialValue:
                                          _viewModel.state.addedWeight,
                                    ),
                                    Divider(
                                      height: styles.Measurements.m,
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: styles.Measurements.xxl,
                                ),
                              ],
                            ),
                          )
                        ])),
                  ),
                  Divider(height: styles.Measurements.xxl)
                ],
              )
            ],
          )),
    );
  }
}
