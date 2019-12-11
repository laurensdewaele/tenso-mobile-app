import 'package:flutter/cupertino.dart';

import 'package:app/models/grips.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/widgets/new_workout/grip_picker.dart';
import 'package:app/widgets/new_workout/section.dart';

class HoldTab extends StatefulWidget {
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

  @override
  _HoldTabState createState() => _HoldTabState();
}

class _HoldTabState extends State<HoldTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleGripChanged(Grip grip) {}

  @override
  Widget build(BuildContext context) {
    final String currentGrip = widget.currentGrip.toString();
    final String totalGrips = widget.totalGrips.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'choose grip $currentGrip / $totalGrips',
          children: <Widget>[
            GripPicker(
                grips: widget.config.basicGrips
                    ? Grips.advancedR
                    : Grips.advancedR,
                handleGripChanged: _handleGripChanged,
                initialGrip: Grips.frontThreeR)
          ],
        )
      ],
    );
  }
}
