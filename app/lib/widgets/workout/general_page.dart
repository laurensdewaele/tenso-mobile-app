import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/general_page_vm.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description2.dart';
import 'package:app/widgets/section.dart';
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
              NumberInputAndDescription2<int>(
                enabled: _viewModel.state.inputsEnabled,
                primaryColor: _viewModel.state.primaryColor,
                description: 'holds',
                handleValueChanged: _viewModel.setHoldCount,
                initialValue: _viewModel.state.holdCount,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
              NumberInputAndDescription2<int>(
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
          Section(
            title: 'timers',
            children: <Widget>[
              NumberInputAndDescription2<int>(
                enabled: _viewModel.state.inputsEnabled,
                primaryColor: _viewModel.state.primaryColor,
                description: 'rest seconds between holds',
                handleValueChanged: _viewModel.setRestBetweenHolds,
                initialValue: _viewModel.state.restBetweenHolds,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
              NumberInputAndDescription2(
                enabled: _viewModel.state.inputsEnabled,
                primaryColor: _viewModel.state.primaryColor,
                description: 'rest seconds between sets',
                handleValueChanged: _viewModel.setRestBetweenSets,
                initialValue: _viewModel.state.restBetweenSets,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
            ],
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
