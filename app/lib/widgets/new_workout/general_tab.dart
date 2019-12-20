import 'package:flutter/cupertino.dart';

import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/widgets/new_workout/integer_input_and_divider.dart';
import 'package:app/widgets/section.dart';

class GeneralTab extends StatefulWidget {
  GeneralTab(
      {Key key,
      @required this.config,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
      @required this.workout,
      @required this.handleHoldCountChanged,
      @required this.shouldFocusOnInput})
      : super(key: key);

  final GeneralConfig config;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget message) handleErrorMessage;
  final Function(int count) handleHoldCountChanged;
  final Workout workout;
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

  void _handleValueChanged(
      {@required WorkoutProperties workoutProperty,
      HoldProperties holdProperty,
      @required int value}) {
    // TODO: Connect to store
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Section(
          title: 'basics',
          children: <Widget>[
            if (widget.config.holdCount)
              IntegerInputAndDivider(
                description: 'holds',
                shouldFocus: widget.shouldFocusOnInput,
                handleValueChanged: (int value) {
                  widget.handleHoldCountChanged(value);
                  _handleValueChanged(
                      workoutProperty: WorkoutProperties.holdCount,
                      value: value);
                },
                initialValue: widget.workout.holdCount,
                shouldLoseFocusStream: widget.shouldLoseFocusStream,
                handleErrorMessage: widget.handleErrorMessage,
              ),
            if (widget.config.repetitions)
              IntegerInputAndDivider(
                description: 'repetittions per hold',
                shouldFocus: false,
                handleValueChanged: (int value) {
                  _handleValueChanged(
                      workoutProperty: WorkoutProperties.holds,
                      holdProperty: HoldProperties.repetitions,
                      value: value);
                },
                initialValue: widget.workout.averageRepetitions,
                shouldLoseFocusStream: widget.shouldLoseFocusStream,
                handleErrorMessage: widget.handleErrorMessage,
              ),
            if (widget.config.sets)
              IntegerInputAndDivider(
                description: 'sets',
                shouldFocus: false,
                handleValueChanged: (int value) {
                  _handleValueChanged(
                      workoutProperty: WorkoutProperties.sets, value: value);
                },
                initialValue: widget.workout.sets,
                shouldLoseFocusStream: widget.shouldLoseFocusStream,
                handleErrorMessage: widget.handleErrorMessage,
              ),
          ],
        ),
        if (widget.config.hasTimers)
          Section(
            title: 'timers',
            children: <Widget>[
              if (widget.config.hangTime)
                IntegerInputAndDivider(
                  description: 'hang time seconds',
                  shouldFocus: false,
                  handleValueChanged: (int value) {
                    _handleValueChanged(
                        workoutProperty: WorkoutProperties.holds,
                        holdProperty: HoldProperties.hangTime,
                        value: value);
                  },
                  initialValue: widget.workout.averageHangTime,
                  shouldLoseFocusStream: widget.shouldLoseFocusStream,
                  handleErrorMessage: widget.handleErrorMessage,
                ),
              if (widget.config.restBetweenRepetitions)
                IntegerInputAndDivider(
                  description: 'rest seconds between repetitions',
                  shouldFocus: false,
                  handleValueChanged: (int value) {
                    _handleValueChanged(
                        workoutProperty: WorkoutProperties.holds,
                        holdProperty: HoldProperties.restBetweenRepetitions,
                        value: value);
                  },
                  initialValue: widget.workout.averageRestBetweenRepetitions,
                  shouldLoseFocusStream: widget.shouldLoseFocusStream,
                  handleErrorMessage: widget.handleErrorMessage,
                ),
              if (widget.config.restBetweenHolds)
                IntegerInputAndDivider(
                  description: 'rest seconds between holds',
                  shouldFocus: false,
                  handleValueChanged: (int value) {
                    _handleValueChanged(
                        workoutProperty: WorkoutProperties.holds,
                        holdProperty: HoldProperties.restBeforeNextHold,
                        value: value);
                  },
                  initialValue: widget.workout.averageRestBetweenHolds,
                  shouldLoseFocusStream: widget.shouldLoseFocusStream,
                  handleErrorMessage: widget.handleErrorMessage,
                ),
              if (widget.config.restBetweenSets)
                IntegerInputAndDivider(
                  description: 'rest seconds between sets',
                  shouldFocus: false,
                  handleValueChanged: (int value) {
                    _handleValueChanged(
                        workoutProperty: WorkoutProperties.restBetweenSets,
                        value: value);
                  },
                  initialValue: widget.workout.restBetweenSets,
                  shouldLoseFocusStream: widget.shouldLoseFocusStream,
                  handleErrorMessage: widget.handleErrorMessage,
                ),
            ],
          ),
        if (widget.config.hasBoard)
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
