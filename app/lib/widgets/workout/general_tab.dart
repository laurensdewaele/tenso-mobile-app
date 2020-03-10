import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/view_models/general_tab_vm.dart';
import 'package:app/view_models/workout_vm.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/workout/integer_input_and_divider.dart';

class GeneralTab extends StatefulWidget {
  GeneralTab(
      {Key key,
      @required this.shouldLoseFocusStream,
      @required this.shouldFocusOnInput})
      : super(key: key);

  final Stream<bool> shouldLoseFocusStream;
  final bool shouldFocusOnInput;

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
    // It's fine to not listen to appState here as our general practice to get the workout.
    // This is because we don't care if it changes or not. It's only used for the initialValues.
    final _workoutViewModel =
        Provider.of<WorkoutViewModel>(context, listen: true);
    final _generalTabViewModel =
        Provider.of<GeneralTabViewModel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Section(
          title: 'basics',
          children: <Widget>[
            NumberInputAndDivider(
              primaryColor: _workoutViewModel.primaryColor,
              isDouble: false,
              description: 'holds',
              shouldFocus: widget.shouldFocusOnInput,
              handleIntValueChanged: (int n) {
                _generalTabViewModel.setHoldCount(n);
              },
              initialValue:
                  _workoutViewModel.workout.holdCount.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
            ),
            NumberInputAndDivider(
              primaryColor: _workoutViewModel.primaryColor,
              isDouble: false,
              description: 'sets',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                _generalTabViewModel.setSets(n);
              },
              initialValue: _workoutViewModel.workout.sets.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
            ),
          ],
        ),
        Section(
          title: 'timers',
          children: <Widget>[
            NumberInputAndDivider(
              primaryColor: _workoutViewModel.primaryColor,
              isDouble: false,
              description: 'rest seconds between holds',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                _generalTabViewModel.setRestBetweenHolds(n);
              },
              initialValue: _workoutViewModel.workout.restBetweenHolds
                  .toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
            ),
            NumberInputAndDivider(
              primaryColor: _workoutViewModel.primaryColor,
              isDouble: false,
              description: 'rest seconds between sets',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                _generalTabViewModel.setRestBetweenSets(n);
              },
              initialValue:
                  _workoutViewModel.workout.restBetweenSets.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
            ),
          ],
        ),
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
