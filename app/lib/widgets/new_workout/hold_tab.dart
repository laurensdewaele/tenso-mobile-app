import 'package:flutter/cupertino.dart';

import 'package:app/data/mock_data.dart';
import 'package:app/models/grips.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/widgets/new_workout/board_hold_picker.dart';
import 'package:app/widgets/new_workout/grip_picker.dart';
import 'package:app/widgets/new_workout/section.dart';

class HoldTab extends StatefulWidget {
  HoldTab(
      {Key key,
      this.config,
      this.currentHold,
      this.shouldLoseFocusStream,
      this.latestWorkout,
      this.handleErrorMessage,
      this.totalHolds})
      : super(key: key);

  final HoldConfig config;
  final int currentHold;
  final Function(Widget message) handleErrorMessage;
  final Workout latestWorkout;
  final Stream<bool> shouldLoseFocusStream;
  final int totalHolds;
  @override
  _HoldTabState createState() => _HoldTabState();
}

class _HoldTabState extends State<HoldTab> {
  Grip _selectedGrip;
  HandHolds _initialHandHold;

  @override
  void initState() {
    super.initState();
    final List<int> holdCountList =
        List.generate(widget.latestWorkout.holds.length, (i) => i);

    if (holdCountList.contains(widget.currentHold - 1)) {
      _initialHandHold =
          widget.latestWorkout.holds[widget.currentHold - 1].handHold ??
              HandHolds.twoHanded;
      _selectedGrip = widget.latestWorkout.holds[widget.currentHold - 1].grip ??
          Grips.openHand;
    } else {
      _initialHandHold = HandHolds.twoHanded;
      _selectedGrip = Grips.openHand;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _handleGripChanged(Grip grip) {
    setState(() {
      _selectedGrip = grip;
    });
  }

  void _handleHandHoldChanged(HandHolds handHold) {
    //TODO:  Do i keep this container container connected to the store and fix things here or in the gripPicker?
  }

  @override
  Widget build(BuildContext context) {
    final String _currentHoldString = widget.currentHold.toString();
    final String _totalHoldsString = widget.totalHolds.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'hold $_currentHoldString / $_totalHoldsString',
          children: <Widget>[
            GripPicker(
                grips: widget.config.basicGrips ? Grips.basic : Grips.advanced,
                handleGripChanged: _handleGripChanged,
                initialGrip: Grips.frontThree,
                oneHanded: widget.config.oneHanded,
                initialHandHold: _initialHandHold,
                handleHandHoldChanged: _handleHandHoldChanged)
          ],
        ),
        Section(
          title: 'drag to choose',
          children: <Widget>[
            BoardHoldPicker(
              board: mockWorkout.board,
              handHold: HandHolds.twoHanded,
              grip: _selectedGrip,
            )
          ],
        )
      ],
    );
  }
}
