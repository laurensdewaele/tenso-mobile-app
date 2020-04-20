import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/general_page_vm.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/section_with_info_icon.dart';
import 'package:app/widgets/tabs.dart';
import 'package:app/widgets/workout/card_container.dart';
import 'package:app/widgets/workout/navigation_indicator.dart';

class GeneralPage extends StatefulWidget {
  GeneralPage({Key key, this.workoutNavigator, this.workoutViewModel})
      : super(key: key);

  final WorkoutNavigator workoutNavigator;
  final WorkoutViewModel workoutViewModel;

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  GeneralPageViewModel _viewModel;

  @override
  void initState() {
    _viewModel = GeneralPageViewModel(
      workoutNavigator: widget.workoutNavigator,
      workoutViewModel: widget.workoutViewModel,
    );
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Section(
            title: 'basics',
            children: <Widget>[
              NumberInputAndDescription<int>(
                enabled: _viewModel.state.inputsEnabled,
                primaryColor: _viewModel.state.primaryColor,
                description: 'holds',
                handleValueChanged: _viewModel.setHoldCount,
                initialValue: _viewModel.state.holdCount,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
              NumberInputAndDescription<int>(
                enabled: _viewModel.state.inputsEnabled,
                primaryColor: _viewModel.state.primaryColor,
                description: 'sets',
                handleValueChanged: _viewModel.setSets,
                initialValue: _viewModel.state.sets,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
            ],
          ),
          StreamBuilder<bool>(
            initialData: _viewModel.stopwatchRestTimers,
            stream: _viewModel.stopwatchRestTimers$,
            builder: (context, snapshot) {
              final bool _stopwatchRestTimers = snapshot.data;
              return SectionWithInfoIcon(
                appDialogContent: _RestTimersInfo(),
                title: 'rest timers',
                children: <Widget>[
                  Tabs(
                    leftText: 'Countdown',
                    rightText: 'Stopwatch',
                    handleLeftTap: () =>
                        _viewModel.setStopwatchRestTimers(isStopWatch: false),
                    handleRightTap: () =>
                        _viewModel.setStopwatchRestTimers(isStopWatch: true),
                    isLeftSelected: _stopwatchRestTimers == false,
                    isRightSelected: _stopwatchRestTimers == true,
                    primaryColor: _viewModel.state.primaryColor,
                    textPrimaryColor: _viewModel.state.textPrimaryColor,
                  ),
                  if (_stopwatchRestTimers == false)
                    Column(
                      children: <Widget>[
                        Divider(
                          height: styles.Measurements.l,
                        ),
                        NumberInputAndDescription<int>(
                          enabled: _viewModel.state.inputsEnabled,
                          primaryColor: _viewModel.state.primaryColor,
                          description: 'rest seconds between holds',
                          handleValueChanged: _viewModel.setRestBetweenHolds,
                          initialValue: _viewModel.state.restBetweenHolds,
                        ),
                        Divider(
                          height: styles.Measurements.m,
                        ),
                        NumberInputAndDescription<int>(
                          enabled: _viewModel.state.inputsEnabled,
                          primaryColor: _viewModel.state.primaryColor,
                          description: 'rest seconds between sets',
                          handleValueChanged: _viewModel.setRestBetweenSets,
                          initialValue: _viewModel.state.restBetweenSets,
                        ),
                      ],
                    ),
                  Divider(
                    height: styles.Measurements.m,
                  ),
                ],
              );
            },
          ),
          if (_viewModel.state.inputsEnabled == true)
            Section(
              title: 'board',
              children: <Widget>[
                // TODO: Board selector
              ],
            ),
          Divider(
            height: styles.Measurements.xxl,
          ),
          StreamBuilder(
            initialData: _viewModel.holdCount,
            stream: _viewModel.holdCount$,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final _totalPages = snapshot.data + 2;
              return NavigationIndicator(
                primaryColor: _viewModel.state.primaryColor,
                activeIndex: 0,
                count: _totalPages,
                handleBackNavigation: widget.workoutNavigator.handleBackRequest,
                handleForwardNavigation:
                    widget.workoutNavigator.handleForwardRequest,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RestTimersInfo extends StatelessWidget {
  _RestTimersInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RichText(
              text: TextSpan(text: '', style: styles.Lato.xsBlack, children: [
                TextSpan(text: 'Countdown ', style: styles.Lato.xsBlackBold),
                TextSpan(
                    text:
                        'will display a countdown timer during your rest periods in between hangs. This way, you are sure that you are getting adequate rest.',
                    style: styles.Lato.xsBlack),
              ]),
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            RichText(
              text: TextSpan(text: '', style: styles.Lato.xsBlack, children: [
                TextSpan(text: 'Stopwatch ', style: styles.Lato.xsBlackBold),
                TextSpan(
                    text:
                        'will display a stopwatch for your rest periods. This is suited for experienced hangboarders, who can better gauge the minumum recovery time after each specific hang.',
                    style: styles.Lato.xsBlack),
              ]),
            ),
            Divider(
              height: styles.Measurements.l,
            ),
            Transform.scale(
              scale: .8,
              child: Button(
                  displayBackground: false,
                  text: 'Ok',
                  handleTap: () {
                    Navigator.of(context).pop();
                  }),
            )
          ],
        )
      ],
    );
  }
}
