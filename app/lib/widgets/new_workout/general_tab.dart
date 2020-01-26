import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/view_models/workout.dart';
import 'package:app/widgets/new_workout/integer_input_and_divider.dart';
import 'package:app/widgets/section.dart';

class GeneralTab extends StatefulWidget {
  GeneralTab(
      {Key key,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
      @required this.shouldFocusOnInput})
      : super(key: key);

  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget message) handleErrorMessage;
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
    final workoutViewModel = Provider.of<WorkoutViewModel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Section(
          title: 'basics',
          children: <Widget>[
            NumberInputAndDivider(
              isDouble: false,
              description: 'holds',
              shouldFocus: widget.shouldFocusOnInput,
              handleIntValueChanged: (int n) {
                workoutViewModel.setHoldCount(n);
              },
              initialValue: workoutViewModel.holdCount.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
              handleErrorMessage: widget.handleErrorMessage,
            ),
            NumberInputAndDivider(
              isDouble: false,
              description: 'sets',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                workoutViewModel.setSets(n);
              },
              initialValue: workoutViewModel.sets.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
              handleErrorMessage: widget.handleErrorMessage,
            ),
          ],
        ),
        Section(
          title: 'timers',
          children: <Widget>[
            NumberInputAndDivider(
              isDouble: false,
              description: 'rest seconds between holds',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                workoutViewModel.setRestBetweenHolds(n);
              },
              initialValue: workoutViewModel.restBetweenHolds.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
              handleErrorMessage: widget.handleErrorMessage,
            ),
            NumberInputAndDivider(
              isDouble: false,
              description: 'rest seconds between sets',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                workoutViewModel.setRestBetweenSets(n);
              },
              initialValue: workoutViewModel.restBetweenSets.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
              handleErrorMessage: widget.handleErrorMessage,
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
