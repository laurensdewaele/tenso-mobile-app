import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/state/workout.dart';
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
    final workoutModel = Provider.of<WorkoutModel>(context, listen: false);

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
                workoutModel.setHoldCount(n);
              },
              initialValue: workoutModel.holdCount.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
              handleErrorMessage: widget.handleErrorMessage,
            ),
            NumberInputAndDivider(
              isDouble: false,
              description: 'sets',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                workoutModel.setSets(n);
              },
              initialValue: workoutModel.sets.toDouble(),
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
                workoutModel.setRestBetweenHolds(n);
              },
              initialValue: workoutModel.restBetweenHolds.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
              handleErrorMessage: widget.handleErrorMessage,
            ),
            NumberInputAndDivider(
              isDouble: false,
              description: 'rest seconds between sets',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                workoutModel.setRestBetweenSets(n);
              },
              initialValue: workoutModel.restBetweenSets.toDouble(),
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
