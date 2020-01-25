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
      @required this.currentHold,
      @required this.selectedRightGrip,
      @required this.selectedLeftGrip,
      @required this.selectedHandHold,
      @required this.handleLeftGripChanged,
      @required this.handleRightGripChanged,
      @required this.handleOneHandedTap,
      @required this.handleTwoHandedTap,
      @required this.selectedHand,
      @required this.handleRightHandSelected,
      @required this.handleLeftHandSelected})
      : super(key: key);


  final HandTypes selectedHand;
  final int currentHold;
  final Grip selectedLeftGrip;
  final Grip selectedRightGrip;
  final HandHolds selectedHandHold;
  final Function(Grip grip) handleLeftGripChanged;
  final Function(Grip grip) handleRightGripChanged;
  final VoidCallback handleTwoHandedTap;
  final Function(HandTypes handType) handleOneHandedTap;
  final Function(HandHolds selectedHandHold) handleLeftHandSelected;
  final Function(HandHolds selectedHandHold) handleRightHandSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _HandHoldsRadioGroup(
            selectedHandHold: selectedHandHold,
            handleTwoHandedTap: handleTwoHandedTap,
            handleOneHandedTap: () => handleOneHandedTap(selectedHand)),
        Divider(height: styles.Measurements.m),
        HandTabs(
          handleLeftHandTap: () => handleLeftHandSelected(selectedHandHold),
          handleRightHandTap: () => handleRightHandSelected(selectedHandHold),
          isLeftHandSelected: selectedHand == HandTypes.leftHand,
          isRightHandSelected: selectedHand == HandTypes.rightHand,
        ),
        Divider(height: styles.Measurements.m),
        if (selectedHand == HandTypes.leftHand)
          GripPicker(
              grips: Grips.left,
              selectedGrip: selectedLeftGrip,
              handleGripChanged: handleLeftGripChanged),
        if (selectedHand == HandTypes.rightHand)
          GripPicker(
              grips: Grips.right,
              handleGripChanged: handleRightGripChanged,
              selectedGrip: selectedRightGrip),
      ],
    );
  }
}

class _HandHoldsRadioGroup extends StatelessWidget {
  _HandHoldsRadioGroup(
      {@required this.selectedHandHold,
      @required this.handleOneHandedTap,
      @required this.handleTwoHandedTap});

  final HandHolds selectedHandHold;
  final VoidCallback handleTwoHandedTap;
  final VoidCallback handleOneHandedTap;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RadioButton(
        description: 'Two handed',
        value: null,
        active: selectedHandHold == HandHolds.twoHanded,
        handleSelected: (v) => handleTwoHandedTap(),
      ),
      RadioButton(
        description: 'One handed',
        value: null,
        active: selectedHandHold == HandHolds.oneHandedLeft ||
            selectedHandHold == HandHolds.oneHandedRight,
        handleSelected: (v) => handleOneHandedTap(),
      ),
    ]);
  }
}
