import 'package:flutter/cupertino.dart';

import 'package:app/data/grips.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hand_types.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/new_workout/grip_picker.dart';
import 'package:app/widgets/new_workout/hand_tabs.dart';
import 'package:app/widgets/radio_button.dart';

class GripPickerContainer extends StatelessWidget {
  GripPickerContainer(
      {Key key,
      @required this.advanced,
      this.selectedRightGrip,
      this.selectedLeftGrip,
      @required this.selectedHandHold,
      @required this.handleLeftGripChanged,
      @required this.handleRightGripChanged,
      @required this.handleHandHoldChanged,
      @required this.handleLeftHandSelected,
      @required this.handleRightHandSelected,
      @required this.selectedTab,
      @required this.isLeftHandSelected,
      @required this.isRightHandSelected})
      : super(key: key);

  final bool advanced;
  final Grip selectedLeftGrip;
  final Grip selectedRightGrip;
  final HandHolds selectedHandHold;
  final Function(Grip grip) handleLeftGripChanged;
  final Function(Grip grip) handleRightGripChanged;
  final Function(HandHolds handHold) handleHandHoldChanged;
  final VoidCallback handleLeftHandSelected;
  final VoidCallback handleRightHandSelected;
  final HandTypes selectedTab;
  final bool isLeftHandSelected;
  final bool isRightHandSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _HandHoldsRadioGroup(
          selectedHandHold: selectedHandHold,
          handleHandHoldChanged: handleHandHoldChanged,
        ),
        Divider(height: styles.Measurements.m),
        HandTabs(
          handleLeftHandTap: handleLeftHandSelected,
          handleRightHandTap: handleRightHandSelected,
          isLeftHandSelected: isLeftHandSelected,
          isRightHandSelected: isRightHandSelected,
        ),
        Divider(height: styles.Measurements.m),
        if (isLeftHandSelected)
          GripPicker(
              grips: advanced ? Grips.advancedL : Grips.basicL,
              selectedGrip: selectedLeftGrip,
              handleGripChanged: handleLeftGripChanged),
        if (isRightHandSelected)
          GripPicker(
              grips: advanced ? Grips.advancedR : Grips.basicR,
              handleGripChanged: handleRightGripChanged,
              selectedGrip: selectedRightGrip),
      ],
    );
  }
}

class _HandHoldsRadioGroup extends StatelessWidget {
  _HandHoldsRadioGroup({this.selectedHandHold, this.handleHandHoldChanged});

  final HandHolds selectedHandHold;
  final Function(HandHolds handHold) handleHandHoldChanged;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RadioButton(
        description: 'Two handed',
        value: HandHolds.twoHanded,
        active: selectedHandHold == HandHolds.twoHanded,
        handleSelected: handleHandHoldChanged,
      ),
      RadioButton(
        description: 'One handed',
        value: HandHolds.oneHanded,
        active: selectedHandHold == HandHolds.oneHanded,
        handleSelected: handleHandHoldChanged,
      ),
    ]);
  }
}
