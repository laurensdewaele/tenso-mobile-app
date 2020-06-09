import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/workout.vm.dart';
import 'package:app/view_models/workout/workout_2.vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/section_with_info_icon.dart';
import 'package:app/widgets/tabs.dart';
import 'package:app/widgets/text_input.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:app/widgets/workout/fixed_variable_timer_info.dart';
import 'package:app/widgets/workout/groups.dart';
import 'package:app/widgets/workout/label_picker.dart';
import 'package:flutter/cupertino.dart' hide Icon;

class WorkoutScreenGroupArguments {
  final Group group;

  const WorkoutScreenGroupArguments({
    @required this.group,
  });
}

class WorkoutScreenInitArguments {
  final WorkoutTypes workoutType;
  final Workout workout;

  const WorkoutScreenInitArguments({
    @required this.workoutType,
    @required this.workout,
  });
}

class WorkoutScreen2 extends StatefulWidget {
  WorkoutScreen2({Key key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen2> {
  WorkoutViewModel2 _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _arguments = ModalRoute.of(context).settings.arguments;

    if (_viewModel == null &&
        _arguments.runtimeType == WorkoutScreenInitArguments) {
      _viewModel = WorkoutViewModel2(
          workout: (_arguments as WorkoutScreenInitArguments).workout,
          workoutType: (_arguments as WorkoutScreenInitArguments).workoutType);
      _viewModel.addListener(_viewModelListener);
    }

    if (_viewModel != null &&
        _arguments.runtimeType == WorkoutScreenGroupArguments) {
      _viewModel.addGroup((_arguments as WorkoutScreenGroupArguments).group);
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
    _viewModel.removeListener(_viewModelListener);
    _viewModel?.dispose();
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
                      padding: EdgeInsets.only(
                        left: styles.Measurements.m,
                        top: 0,
                        right: styles.Measurements.m,
                        bottom: styles.Measurements.l,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Divider(
                              height: styles.Measurements.l -
                                  styles.Measurements.kInfoIconSurplus),
                          SectionWithInfoIcon(
                            nextSectionHasInfoIcon: true,
                            title: 'Groups',
                            appDialogContent: _GroupInfo(),
                            children: <Widget>[
                              Groups(
                                groups: _viewModel.state.groups,
                                isNewWorkout: _viewModel.workoutType ==
                                    WorkoutTypes.newWorkout,
                                handleAddGroupTap: _viewModel.handleAddGroupTap,
                              ),
                            ],
                          ),
                          SectionWithInfoIcon(
                            nextSectionHasInfoIcon: true,
                            title: 'rest between groups',
                            appDialogContent: FixedVariableTimerInfo(),
                            children: <Widget>[
                              Tabs(
                                leftText: 'Fixed',
                                rightText: 'Variable',
                                handleLeftTap:
                                    _viewModel.setRestBetweenGroupsFixed,
                                handleRightTap:
                                    _viewModel.setRestBetweenGroupsVariable,
                                isLeftSelected:
                                    _viewModel.state.restBetweenGroupsFixed ==
                                        true,
                                isRightSelected:
                                    _viewModel.state.restBetweenGroupsFixed ==
                                        false,
                                primaryColor: _viewModel.state.primaryColor,
                                textPrimaryColor:
                                    _viewModel.state.textPrimaryColor,
                              ),
                              Divider(
                                height: styles.Measurements.m,
                              ),
                              if (_viewModel.state.restBetweenGroupsFixed ==
                                  true)
                                NumberInputAndDescription<int>(
                                  enabled: _viewModel.state.inputsEnabled,
                                  primaryColor: _viewModel.state.primaryColor,
                                  description: 'seconds',
                                  handleValueChanged:
                                      _viewModel.setRestBetweenGroupsS,
                                  initialValue:
                                      _viewModel.state.restBetweenGroupsS,
                                ),
                            ],
                          ),
                          SectionWithInfoIcon(
                            title: 'color label',
                            appDialogContent: _ColorLabelInfo(),
                            children: <Widget>[
                              LabelPicker(
                                  handleLabelChanged: _viewModel.setLabel,
                                  initialLabel: _viewModel.state.label,
                                  enabled: _viewModel.state.inputsEnabled)
                            ],
                          ),
                          Section(
                            title: 'name',
                            children: <Widget>[
                              TextInput(
                                  multiLine: false,
                                  enabled: _viewModel.state.inputsEnabled,
                                  primaryColor: _viewModel.state.primaryColor,
                                  initialValue: _viewModel.state.name,
                                  handleValueChanged: _viewModel.setName)
                            ],
                          ),
                          Center(
                            child: Button(
                              backgroundColor: _viewModel.state.primaryColor,
                              text: _viewModel.state.saveButtonText,
                              handleTap: _viewModel.handleSaveTap,
                            ),
                          ),
                          Divider(
                            height: styles.Measurements.xxl,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: styles.Measurements.xxl)
                ],
              )
            ],
          )),
    );
  }
}

class _ColorLabelInfo extends StatelessWidget {
  _ColorLabelInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'By giving your workout a color label, it will become easier to distuingish between workouts on the calendar overview.',
          style: styles.Lato.xsBlack,
        ),
        Divider(height: styles.Measurements.l),
        Center(
          child: Button(
              small: true,
              displayBackground: false,
              text: 'Ok',
              handleTap: () {
                Navigator.of(context).pop();
              }),
        )
      ],
    );
  }
}

class _GroupInfo extends StatelessWidget {
  _GroupInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RichText(
          text: TextSpan(text: '', style: styles.Lato.xsBlack, children: [
            TextSpan(text: 'A ', style: styles.Lato.xsBlack),
            TextSpan(text: 'group ', style: styles.Lato.xsBlackBold),
            TextSpan(
                text:
                    'is a collection of multiple hangs of the same type (the same grip and holds).',
                style: styles.Lato.xsBlack),
          ]),
        ),
        Divider(height: styles.Measurements.l),
        Center(
          child: Button(
              small: true,
              displayBackground: false,
              text: 'Ok',
              handleTap: () {
                Navigator.of(context).pop();
              }),
        )
      ],
    );
  }
}
