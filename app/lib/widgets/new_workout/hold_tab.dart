import 'package:flutter/cupertino.dart';

import 'package:app/data/mock_data.dart';
import 'package:app/models/grips.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/widgets/new_workout/grip_picker.dart';
import 'package:app/widgets/new_workout/section.dart';

class HoldTab extends StatelessWidget {
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

  void _handleGripChanged(Grip grip) {
    //TODO:  Do i keep this container container connected to the store and fix things here or in the gripPicker?
  }
  void _handleHandHoldChanged(HandHolds handHold) {
    //TODO:  Do i keep this container container connected to the store and fix things here or in the gripPicker?
  }

  @override
  Widget build(BuildContext context) {
    final String currentHoldString = currentHold.toString();
    final String totalHoldsString = totalHolds.toString();

    HandHolds initialHandHold;

    final List<int> holdCountList =
        List.generate(mockWorkout.holds.length, (i) => i);
    if (holdCountList.contains(currentHold - 1)) {
      initialHandHold =
          mockWorkout.holds[currentHold - 1].handHold ?? HandHolds.twoHanded;
    } else {
      initialHandHold = HandHolds.twoHanded;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'hold $currentHoldString / $totalHoldsString',
          children: <Widget>[
            GripPicker(
                grips: config.basicGrips ? Grips.basic : Grips.advanced,
                handleGripChanged: _handleGripChanged,
                initialGrip: Grips.frontThree,
                oneHanded: config.oneHanded,
                initialHandHold: initialHandHold,
                handleHandHoldChanged: _handleHandHoldChanged)
          ],
        ),
        Section(
          title: 'drag to choose',
          children: <Widget>[],
        )
      ],
    );
  }
}
