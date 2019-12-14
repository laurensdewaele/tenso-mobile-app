import 'package:flutter/cupertino.dart';

import 'package:app/data/grips.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/new_workout/grip_picker.dart';
import 'package:app/widgets/radio_button.dart';

enum _Tabs { leftHand, rightHand }

class GripPickerContainer extends StatefulWidget {
  GripPickerContainer(
      {Key key,
      @required this.advanced,
      this.initialLeftGrip,
      this.initialRightGrip,
      @required this.initialHandHold,
      @required this.handleLeftGripChanged,
      @required this.handleRightGripChanged,
      @required this.handleHandHoldChanged})
      : super(key: key);

  final bool advanced;
  final Grip initialLeftGrip;
  final Grip initialRightGrip;
  final HandHolds initialHandHold;
  final Function(Grip grip) handleLeftGripChanged;
  final Function(Grip grip) handleRightGripChanged;
  final Function(HandHolds handHold) handleHandHoldChanged;

  @override
  _GripPickerContainerState createState() => _GripPickerContainerState();
}

class _GripPickerContainerState extends State<GripPickerContainer> {
  Grip _selectedLeftGrip;
  Grip _selectedRightGrip;
  _Tabs _selectedTab;
  List<Grip> _leftGrips;
  List<Grip> _rightGrips;
  HandHolds _selectedHandHold;

  @override
  void initState() {
    super.initState();
    _selectedLeftGrip = widget.initialLeftGrip;
    _selectedRightGrip = widget.initialRightGrip;
    _selectedHandHold = widget.initialHandHold;
    _selectedTab = widget.initialHandHold == HandHolds.oneHanded &&
            widget.initialRightGrip != null
        ? _Tabs.rightHand
        : _Tabs.leftHand;
    _leftGrips = widget.advanced ? Grips.advancedL : Grips.basicL;
    _rightGrips = widget.advanced ? Grips.advancedR : Grips.basicR;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleLeftGripChanged(Grip grip) {
    widget.handleLeftGripChanged(grip);
    setState(() {
      _selectedLeftGrip = grip;
    });
  }

  void _handleRightGripChanged(Grip grip) {
    widget.handleRightGripChanged(grip);
    setState(() {
      _selectedRightGrip = grip;
    });
  }

  void _handleHandHoldChanged(HandHolds handHold) {
    widget.handleHandHoldChanged(handHold);
    setState(() {
      _selectedHandHold = handHold;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: styles.Measurements.m),
        _HandHoldsRadioGroup(
          selectedHandHold: _selectedHandHold,
          handleHandHoldChanged: _handleHandHoldChanged,
        ),
        Divider(height: styles.Measurements.m),
        GripPicker(
            grips: _leftGrips,
            handleGripChanged: _handleLeftGripChanged,
            initialGrip: _selectedLeftGrip),
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
