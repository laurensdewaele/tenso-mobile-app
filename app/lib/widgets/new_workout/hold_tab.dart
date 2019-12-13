import 'package:app/data/mock_data.dart';
import 'package:app/models/hand_hold.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/models/grips.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/widgets/new_workout/grip_picker.dart';
import 'package:app/widgets/new_workout/section.dart';

class HoldTab extends StatelessWidget {
  HoldTab(
      {Key key,
      this.config,
      this.currentGrip,
      this.shouldLoseFocusStream,
      this.latestWorkout,
      this.handleErrorMessage,
      this.totalGrips})
      : super(key: key);

  final HoldConfig config;
  final int currentGrip;
  final Function(Widget message) handleErrorMessage;
  final Workout latestWorkout;
  final Stream<bool> shouldLoseFocusStream;
  final int totalGrips;

  void _handleGripChanged(Grip grip) {
    //TODO:  Do i keep this container container connected to the store and fix things here or in the gripPicker?
  }
  void _handleHandHoldChanged(HandHolds handHold) {
    //TODO:  Do i keep this container container connected to the store and fix things here or in the gripPicker?
  }

  @override
  Widget build(BuildContext context) {
    final String currentGripString = currentGrip.toString();
    final String totalGripsString = totalGrips.toString();

    HandHolds initialHandHold;

    final List<int> holdCountList =
        List.generate(mockWorkout.holds.length, (i) => i);
    if (holdCountList.contains(currentGrip - 1)) {
      initialHandHold =
          mockWorkout.holds[currentGrip - 1].handHold ?? HandHolds.twoHanded;
    } else {
      initialHandHold = HandHolds.twoHanded;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'choose grip $currentGripString / $totalGripsString',
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
          title: 'drag to choose holds',
          children: <Widget>[],
        )
      ],
    );
  }
}
