import 'package:flutter/cupertino.dart';

import 'package:app/data/grips.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hand_type.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/new_workout/grip_picker.dart';
import 'package:app/widgets/new_workout/hand_tabs.dart';
import 'package:app/widgets/radio_button.dart';
import 'package:provider/provider.dart';

class GripPickerContainer extends StatefulWidget {
  GripPickerContainer({
    Key key,
    @required this.currentHold,
    @required this.selectedRightGrip,
    @required this.selectedLeftGrip,
    @required this.selectedHandHold,
    @required this.handleLeftGripChanged,
    @required this.handleRightGripChanged,
    @required this.handleOneHandedTap,
    @required this.handleTwoHandedTap,
  }) : super(key: key);

  final int currentHold;
  final Grip selectedLeftGrip;
  final Grip selectedRightGrip;
  final HandHolds selectedHandHold;
  final Function(Grip grip) handleLeftGripChanged;
  final Function(Grip grip) handleRightGripChanged;
  final VoidCallback handleTwoHandedTap;
  final Function(HandType handType) handleOneHandedTap;

  @override
  _GripPickerContainerState createState() => _GripPickerContainerState();
}

class _GripPickerContainerState extends State<GripPickerContainer> {
  HandType _selectedHand;

  @override
  void initState() {
    super.initState();
    if (widget.selectedHandHold == HandHolds.oneHandedRight) {
      _selectedHand = HandType.rightHand;
    } else {
      _selectedHand = HandType.leftHand;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleLeftHandSelected() {
    if (widget.selectedHandHold != HandHolds.twoHanded) {
      Provider.of<WorkoutViewModel>(context, listen: false)
          .setHoldHandHold(widget.currentHold, HandHolds.oneHandedLeft);
    }
    setState(() {
      _selectedHand = HandType.leftHand;
    });
  }

  void _handleRightHandSelected() {
    if (widget.selectedHandHold != HandHolds.twoHanded) {
      Provider.of<WorkoutViewModel>(context, listen: false)
          .setHoldHandHold(widget.currentHold, HandHolds.oneHandedRight);
    }
    setState(() {
      _selectedHand = HandType.rightHand;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _HandHoldsRadioGroup(
            selectedHandHold: widget.selectedHandHold,
            handleTwoHandedTap: widget.handleTwoHandedTap,
            handleOneHandedTap: () => widget.handleOneHandedTap(_selectedHand)),
        Divider(height: styles.Measurements.m),
        HandTabs(
          handleLeftHandTap: _handleLeftHandSelected,
          handleRightHandTap: _handleRightHandSelected,
          isLeftHandSelected: _selectedHand == HandType.leftHand,
          isRightHandSelected: _selectedHand == HandType.rightHand,
        ),
        Divider(height: styles.Measurements.m),
        if (_selectedHand == HandType.leftHand)
          GripPicker(
              grips: Grips.left,
              selectedGrip: widget.selectedLeftGrip,
              handleGripChanged: widget.handleLeftGripChanged),
        if (_selectedHand == HandType.rightHand)
          GripPicker(
              grips: Grips.right,
              handleGripChanged: widget.handleRightGripChanged,
              selectedGrip: widget.selectedRightGrip),
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
