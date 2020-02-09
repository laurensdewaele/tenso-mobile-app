import 'package:app/models/grip.dart';
import 'package:app/view_models/app_state_vm.dart';
import 'package:app/view_models/hold_tab_vm.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/data/grips.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hand_type.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/new_workout/grip_picker.dart';
import 'package:app/widgets/new_workout/hand_tabs.dart';
import 'package:app/widgets/radio_button.dart';
import 'package:provider/provider.dart';

class GripPickerContainer extends StatefulWidget {
  GripPickerContainer({Key key, @required this.currentHold}) : super(key: key);

  final int currentHold;

  @override
  _GripPickerContainerState createState() => _GripPickerContainerState();
}

class _GripPickerContainerState extends State<GripPickerContainer> {
  @override
  void initState() {
    super.initState();
    Provider.of<HoldTabViewModel>(context, listen: false)
        .initState(widget.currentHold);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<HoldTabViewModel>(context, listen: true);
    final _workout = Provider.of<AppState>(context, listen: true).workout;

    return Column(
      children: <Widget>[
        _HandHoldRadioGroup(
            selectedHandHold: _workout.holds[widget.currentHold].handHold,
            handleTwoHandedTap: () =>
                _viewModel.handleTwoHandedTap(widget.currentHold),
            handleOneHandedTap: () =>
                _viewModel.handleOneHandedTap(widget.currentHold)),
        Divider(height: styles.Measurements.m),
        HandTabs(
          handleLeftHandTap: () =>
              _viewModel.handleLeftHandSelected(widget.currentHold),
          handleRightHandTap: () =>
              _viewModel.handleRightHandSelected(widget.currentHold),
          isLeftHandSelected: _viewModel.selectedHand == HandType.leftHand,
          isRightHandSelected: _viewModel.selectedHand == HandType.rightHand,
        ),
        Divider(height: styles.Measurements.m),
        if (_viewModel.selectedHand == HandType.leftHand)
          GripPicker(
              grips: Grips.left,
              selectedGrip: _workout.holds[widget.currentHold].leftGrip,
              handleGripChanged: (Grip grip) =>
                  _viewModel.handleLeftGripChanged(widget.currentHold, grip)),
        if (_viewModel.selectedHand == HandType.rightHand)
          GripPicker(
              grips: Grips.right,
              handleGripChanged: (Grip grip) =>
                  _viewModel.handleRightGripChanged(widget.currentHold, grip),
              selectedGrip: _workout.holds[widget.currentHold].rightGrip),
      ],
    );
  }
}

class _HandHoldRadioGroup extends StatelessWidget {
  _HandHoldRadioGroup(
      {@required this.selectedHandHold,
      @required this.handleOneHandedTap,
      @required this.handleTwoHandedTap});

  final HandHold selectedHandHold;
  final VoidCallback handleTwoHandedTap;
  final VoidCallback handleOneHandedTap;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RadioButton(
        description: 'Two handed',
        value: null,
        active: selectedHandHold == HandHold.twoHanded,
        handleSelected: (v) => handleTwoHandedTap(),
      ),
      RadioButton(
        description: 'One handed',
        value: null,
        active: selectedHandHold == HandHold.oneHandedLeft ||
            selectedHandHold == HandHold.oneHandedRight,
        handleSelected: (v) => handleOneHandedTap(),
      ),
    ]);
  }
}
