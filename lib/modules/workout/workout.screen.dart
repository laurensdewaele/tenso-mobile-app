import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/button.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/icons.dart' as icons;
import 'package:tenso_app/modules/common/label_with_text_picker.dart';
import 'package:tenso_app/modules/common/ok_button.dart';
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/section.dart';
import 'package:tenso_app/modules/common/section_with_info_icon.dart';
import 'package:tenso_app/modules/common/tabs.dart';
import 'package:tenso_app/modules/common/top_navigation.dart';
import 'package:tenso_app/modules/keyboard_input/keyboard_and_toast_provider.dart';
import 'package:tenso_app/modules/keyboard_input/keyboard_list_view.dart';
import 'package:tenso_app/modules/keyboard_input/number_input_and_description.dart';
import 'package:tenso_app/modules/keyboard_input/text_input.dart';
import 'package:tenso_app/modules/workout/fixed_variable_timer_info.dart';
import 'package:tenso_app/modules/workout/group_overview.dart';
import 'package:tenso_app/modules/workout/workout.vm.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class WorkoutScreenArguments {
  final WorkoutActions workoutAction;
  final Workout workout;

  const WorkoutScreenArguments({
    @required this.workoutAction,
    @required this.workout,
  });
}

class WorkoutScreen extends StatefulWidget {
  WorkoutScreen({Key key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  WorkoutViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final WorkoutScreenArguments _arguments =
        ModalRoute.of(context).settings.arguments;

    if (_viewModel == null) {
      _viewModel = WorkoutViewModel(
          workout: _arguments.workout, workoutAction: _arguments.workoutAction);
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
    _viewModel.removeListener(_viewModelListener);
    _viewModel?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAndToastProvider(
      child: WillPopScope(
        onWillPop: () async {
          _viewModel.handleBackNavigation();
          return false;
        },
        child: Screen(
            handleBackNavigation: _viewModel.handleBackNavigation,
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
                                GroupOverview(
                                  groups: _viewModel.state.groups,
                                  handleEditGroup: _viewModel.handleEditGroup,
                                  handleDeleteGroup:
                                      _viewModel.handleDeleteGroup,
                                  weightUnit:
                                      _viewModel.state.weightSystem.unit,
                                ),
                                Column(
                                  children: <Widget>[
                                    if (_viewModel.state.groups.length > 0)
                                      Divider(
                                        height: styles.Measurements.l,
                                      ),
                                    Button(
                                        smallText: true,
                                        height: styles.kSmallButtonHeight,
                                        text: 'Add group',
                                        backgroundColor: styles.Colors.primary,
                                        handleTap: _viewModel.handleAddGroupTap,
                                        leadingIcon: icons.plusIconWhiteS)
                                  ],
                                )
                              ],
                            ),
                            SectionWithInfoIcon(
                              nextSectionHasInfoIcon: true,
                              title: 'group rest',
                              appDialogContent: FixedVariableTimerInfo(),
                              children: <Widget>[
                                Tabs(
                                  leftText: 'Variable',
                                  rightText: 'Fixed',
                                  handleLeftTap:
                                      _viewModel.setRestBetweenGroupsVariable,
                                  handleRightTap:
                                      _viewModel.setRestBetweenGroupsFixed,
                                  isLeftSelected:
                                      _viewModel.state.restBetweenGroupsFixed ==
                                          false,
                                  isRightSelected:
                                      _viewModel.state.restBetweenGroupsFixed ==
                                          true,
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
                                LabelWithTextPicker(
                                  handleLabelChanged: _viewModel.setLabel,
                                  initialLabelWithText: LabelWithText(
                                      label: _viewModel.state.label ??
                                          defaultLabelsWithText[4].label),
                                  labelsWithText: defaultLabelsWithText,
                                ),
                              ],
                            ),
                            Section(
                              title: 'name',
                              children: <Widget>[
                                TextInput(
                                    multiLine: false,
                                    primaryColor: _viewModel.state.primaryColor,
                                    initialValue: _viewModel.state.name,
                                    handleValueChanged: _viewModel.setName)
                              ],
                            ),
                            Divider(
                              height: styles.Measurements.l,
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
      ),
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
          child: OKButton(handleTap: () {
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
        Divider(
          height: styles.Measurements.m,
        ),
        RichText(
          text: TextSpan(text: '', style: styles.Lato.xsBlack, children: [
            TextSpan(
                text:
                    'On the group page you can specify all the details of the group.',
                style: styles.Lato.xsBlack),
          ]),
        ),
        Divider(height: styles.Measurements.l),
        Center(
          child: OKButton(handleTap: () {
            Navigator.of(context).pop();
          }),
        )
      ],
    );
  }
}
