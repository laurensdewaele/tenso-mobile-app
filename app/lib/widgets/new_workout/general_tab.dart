import 'package:flutter/cupertino.dart';

import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/new_workout/integer_input_and_description.dart';

class GeneralTab extends StatefulWidget {
  GeneralTab(
      {Key key,
      @required this.config,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage})
      : super(key: key);

  final GeneralConfig config;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget message) handleErrorMessage;

  @override
  _GeneralTabState createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> {
  bool hasTimers;
  bool hasBoard;

  @override
  void initState() {
    super.initState();
    hasTimers = widget.config.restBetweenSets ||
        widget.config.restBetweenHolds ||
        widget.config.restBetweenRepetitions ||
        widget.config.hangTime;
    hasBoard = widget.config.board;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _handleValueChanged(
      {@required WorkoutProperties workoutProperty,
      HoldProperties holdProperty,
      @required int value}) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Section(
          title: 'basics',
          children: <Widget>[
            if (widget.config.holdAmount)
              InputAndDivider(
                description: 'holds',
                isFirst: true,
                handleValueChanged: (int value) {
                  _handleValueChanged(
                      workoutProperty: WorkoutProperties.holdAmount,
                      value: value);
                },
                initialValue: 4,
                shouldLoseFocusStream: widget.shouldLoseFocusStream,
                handleErrorMessage: widget.handleErrorMessage,
              ),
            if (widget.config.repetitions)
              InputAndDivider(
                description: 'repetittions per hold',
                isFirst: false,
                handleValueChanged: (int value) {
                  _handleValueChanged(
                      workoutProperty: WorkoutProperties.holds,
                      holdProperty: HoldProperties.repetitions,
                      value: value);
                },
                initialValue: 4,
                shouldLoseFocusStream: widget.shouldLoseFocusStream,
                handleErrorMessage: widget.handleErrorMessage,
              ),
            if (widget.config.sets)
              InputAndDivider(
                description: 'sets',
                isFirst: false,
                handleValueChanged: (int value) {
                  _handleValueChanged(
                      workoutProperty: WorkoutProperties.sets, value: value);
                },
                initialValue: 4,
                shouldLoseFocusStream: widget.shouldLoseFocusStream,
                handleErrorMessage: widget.handleErrorMessage,
              ),
          ],
        ),
        if (hasTimers)
          Section(
            title: 'timers',
            children: <Widget>[
              if (widget.config.hangTime)
                InputAndDivider(
                  description: 'hang time seconds',
                  isFirst: false,
                  handleValueChanged: (int value) {
                    _handleValueChanged(
                        workoutProperty: WorkoutProperties.holds,
                        holdProperty: HoldProperties.hangTime,
                        value: value);
                  },
                  initialValue: 4,
                  shouldLoseFocusStream: widget.shouldLoseFocusStream,
                  handleErrorMessage: widget.handleErrorMessage,
                ),
              if (widget.config.restBetweenRepetitions)
                InputAndDivider(
                  description: 'rest seconds between repetitions',
                  isFirst: false,
                  handleValueChanged: (int value) {
                    _handleValueChanged(
                        workoutProperty: WorkoutProperties.holds,
                        holdProperty: HoldProperties.restBetweenRepetitions,
                        value: value);
                  },
                  initialValue: 4,
                  shouldLoseFocusStream: widget.shouldLoseFocusStream,
                  handleErrorMessage: widget.handleErrorMessage,
                ),
              if (widget.config.restBetweenHolds)
                InputAndDivider(
                  description: 'rest seconds between holds',
                  isFirst: false,
                  handleValueChanged: (int value) {
                    _handleValueChanged(
                        workoutProperty: WorkoutProperties.holds,
                        holdProperty: HoldProperties.restBeforeNextHold,
                        value: value);
                  },
                  initialValue: 4,
                  shouldLoseFocusStream: widget.shouldLoseFocusStream,
                  handleErrorMessage: widget.handleErrorMessage,
                ),
              if (widget.config.restBetweenSets)
                InputAndDivider(
                  description: 'rest seconds between sets',
                  isFirst: false,
                  handleValueChanged: (int value) {
                    _handleValueChanged(
                        workoutProperty: WorkoutProperties.restBetweenSets,
                        value: value);
                  },
                  initialValue: 4,
                  shouldLoseFocusStream: widget.shouldLoseFocusStream,
                  handleErrorMessage: widget.handleErrorMessage,
                ),
            ],
          ),
        if (hasBoard)
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

class Section extends StatelessWidget {
  Section({@required this.title, @required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: styles.Typography.title,
        ),
        Divider(height: styles.Measurements.l),
        ...children,
        Divider(height: styles.Measurements.xxl),
      ],
    );
  }
}

class InputAndDivider extends StatelessWidget {
  InputAndDivider(
      {Key key,
      @required this.description,
      @required this.initialValue,
      @required this.handleValueChanged,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
      @required this.isFirst})
      : super(key: key);

  final String description;
  final int initialValue;
  final ValueChanged<int> handleValueChanged;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget) handleErrorMessage;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        IntegerInputAndDescription(
          description: description,
          isFirst: isFirst,
          handleValueChanged: handleValueChanged,
          initialValue: initialValue,
          shouldLoseFocusStream: shouldLoseFocusStream,
          handleErrorMessage: handleErrorMessage,
        ),
        Divider(
          key: UniqueKey(),
          height: styles.Measurements.m,
        ),
      ],
    );
  }
}
