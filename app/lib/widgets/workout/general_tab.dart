import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/general_tab_vm.dart';
import 'package:app/view_models/workout_vm.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/widgets/section.dart';

class GeneralTab extends StatefulWidget {
  GeneralTab({Key key}) : super(key: key);

  @override
  _GeneralTabState createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _workoutViewModel =
        Provider.of<WorkoutViewModel>(context, listen: true);
    final _generalTabViewModel =
        Provider.of<GeneralTabViewModel>(context, listen: false);
    final _appState = Provider.of<AppState>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Section(
          title: 'basics',
          children: <Widget>[
            NumberInputAndDescription(
              enabled: _workoutViewModel.inputsEnabled,
              primaryColor: _workoutViewModel.primaryColor,
              description: 'holds',
              handleIntValueChanged: (int n) {
                _generalTabViewModel.setHoldCount(n);
              },
              initialIntValue: _appState.workout.holdCount,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            NumberInputAndDescription(
              enabled: _workoutViewModel.inputsEnabled,
              primaryColor: _workoutViewModel.primaryColor,
              description: 'sets',
              handleIntValueChanged: (int n) {
                _generalTabViewModel.setSets(n);
              },
              initialIntValue: _appState.workout.sets,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
          ],
        ),
        Section(
          title: 'timers',
          children: <Widget>[
            NumberInputAndDescription(
              enabled: _workoutViewModel.inputsEnabled,
              primaryColor: _workoutViewModel.primaryColor,
              description: 'rest seconds between holds',
              handleIntValueChanged: (int n) {
                _generalTabViewModel.setRestBetweenHolds(n);
              },
              initialIntValue: _appState.workout.restBetweenHolds,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            NumberInputAndDescription(
              enabled: _workoutViewModel.inputsEnabled,
              primaryColor: _workoutViewModel.primaryColor,
              description: 'rest seconds between sets',
              handleIntValueChanged: (int n) {
                _generalTabViewModel.setRestBetweenSets(n);
              },
              initialIntValue: _appState.workout.restBetweenSets,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
          ],
        ),
        if (_workoutViewModel.inputsEnabled == true)
          Section(
            title: 'board',
            children: <Widget>[
              // TODO: Board selector
            ],
          )
      ],
    );
  }
}
