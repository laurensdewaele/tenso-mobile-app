import 'package:flutter/cupertino.dart';
import 'package:tenso_app/data/grips.data.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/radio_button.dart';
import 'package:tenso_app/modules/common/tabs.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/workout/grip_picker.dart';

class GripPickerContainer extends StatefulWidget {
  GripPickerContainer({
    Key key,
    @required this.rightGrip,
    @required this.leftGrip,
    @required this.handHold,
    @required this.handleLeftGripSelected,
    @required this.handleRightGripSelected,
    @required this.handleOneHandedTap,
    @required this.handleTwoHandedTap,
    @required this.handleLeftHandSelected,
    @required this.handleRightHandSelected,
    @required this.primaryColor,
    @required this.textPrimaryColor,
  }) : super(key: key);

  final TextStyle textPrimaryColor;
  final Color primaryColor;
  final Grip leftGrip;
  final Grip rightGrip;
  final HandHold handHold;
  final void Function(Grip grip) handleLeftGripSelected;
  final void Function(Grip grip) handleRightGripSelected;
  final void Function(HandHold handHold) handleOneHandedTap;
  final void Function(HandHold handHold) handleTwoHandedTap;
  final void Function(HandHold handHold) handleLeftHandSelected;
  final void Function(HandHold handHold) handleRightHandSelected;

  @override
  _GripPickerContainerState createState() => _GripPickerContainerState();
}

class _GripPickerContainerState extends State<GripPickerContainer> {
  HandType _handType;

  @override
  void initState() {
    super.initState();
    if (widget.handHold == HandHold.oneHandedRight) {
      _handType = HandType.rightHand;
    } else {
      _handType = HandType.leftHand;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleTwoHandedTap() {
    widget.handleTwoHandedTap(HandHold.twoHanded);
  }

  void _handleOneHandedTap() {
    HandHold handHold;
    if (_handType == HandType.leftHand) {
      handHold = HandHold.oneHandedLeft;
    } else {
      handHold = HandHold.oneHandedRight;
    }
    widget.handleOneHandedTap(handHold);
  }

  void _handleLeftHandSelected() {
    if (widget.handHold != HandHold.twoHanded) {
      widget.handleLeftHandSelected(HandHold.oneHandedLeft);
    }
    setState(() {
      _handType = HandType.leftHand;
    });
  }

  void _handleRightHandSelected() {
    if (widget.handHold != HandHold.twoHanded) {
      widget.handleRightHandSelected(HandHold.oneHandedRight);
    }
    setState(() {
      _handType = HandType.rightHand;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _HandHoldRadioGroup(
          primaryColor: widget.primaryColor,
          handHold: widget.handHold,
          handleTwoHandedTap: _handleTwoHandedTap,
          handleOneHandedTap: _handleOneHandedTap,
        ),
        Divider(height: styles.Measurements.m),
        Tabs(
          textPrimaryColor: widget.textPrimaryColor,
          primaryColor: widget.primaryColor,
          leftText: 'Left',
          rightText: 'Right',
          handleLeftTap: _handleLeftHandSelected,
          handleRightTap: _handleRightHandSelected,
          isLeftSelected: _handType == HandType.leftHand,
          isRightSelected: _handType == HandType.rightHand,
        ),
        Divider(height: styles.Measurements.m),
        if (_handType == HandType.leftHand && widget.leftGrip != null)
          GripPicker(
              primaryColor: widget.primaryColor,
              grips: Grips.left,
              selectedGrip: widget.leftGrip,
              handleGripChanged: widget.handleLeftGripSelected),
        if (_handType == HandType.rightHand && widget.rightGrip != null)
          GripPicker(
              primaryColor: widget.primaryColor,
              grips: Grips.right,
              handleGripChanged: widget.handleRightGripSelected,
              selectedGrip: widget.rightGrip),
      ],
    );
  }
}

class _HandHoldRadioGroup extends StatelessWidget {
  _HandHoldRadioGroup(
      {@required this.handHold,
      @required this.primaryColor,
      @required this.handleOneHandedTap,
      @required this.handleTwoHandedTap});

  final Color primaryColor;
  final HandHold handHold;
  final VoidCallback handleTwoHandedTap;
  final VoidCallback handleOneHandedTap;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RadioButton(
        primaryColor: primaryColor,
        description: 'Two handed',
        value: null,
        active: handHold == HandHold.twoHanded,
        handleSelected: (v) => handleTwoHandedTap(),
      ),
      RadioButton(
        primaryColor: primaryColor,
        description: 'One handed',
        value: null,
        active: handHold == HandHold.oneHandedLeft ||
            handHold == HandHold.oneHandedRight,
        handleSelected: (v) => handleOneHandedTap(),
      ),
    ]);
  }
}
