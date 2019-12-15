import 'package:flutter/cupertino.dart';

import 'package:app/data/grips.dart';
import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/hand_types.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/widgets/new_workout/board_hold_picker.dart';
import 'package:app/widgets/new_workout/grip_picker_container.dart';
import 'package:app/widgets/new_workout/section.dart';

class HoldTab extends StatefulWidget {
  HoldTab(
      {Key key,
      this.config,
      this.currentHold,
      this.shouldLoseFocusStream,
      this.handleErrorMessage,
      this.hold,
      this.board,
      this.totalHolds})
      : super(key: key);

  final Hold hold;
  final HoldConfig config;
  final int currentHold;
  final Function(Widget message) handleErrorMessage;
  final Stream<bool> shouldLoseFocusStream;
  final int totalHolds;
  final Board board;
  @override
  _HoldTabState createState() => _HoldTabState();
}

class _HoldTabState extends State<HoldTab> {
  Grip _selectedLeftGrip;
  Grip _selectedRightGrip;
  BoardHold _selectedLeftGripBoardHold;
  BoardHold _selectedRightGripBoardHold;
  HandHolds _selectedHandHold;
  HandTypes _selectedHand;

  @override
  void initState() {
    super.initState();
    _selectedLeftGrip = widget.hold.leftGrip;
    _selectedRightGrip = widget.hold.rightGrip;
    _selectedLeftGripBoardHold = widget.hold.leftGripBoardHold;
    _selectedRightGripBoardHold = widget.hold.rightGripBoardHold;
    _selectedHandHold = widget.hold.handHold;
    _selectedHand = widget.hold.handHold == HandHolds.oneHanded &&
            widget.hold.rightGrip != null
        ? HandTypes.rightHand
        : HandTypes.leftHand;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleLeftGripChanged(Grip grip) {
    setState(() {
      _selectedLeftGrip = grip;
    });
  }

  void _handleRightGripChanged(Grip grip) {
    setState(() {
      _selectedRightGrip = grip;
    });
  }

  void _checkOneHanded() {
    if (_selectedHandHold == HandHolds.oneHanded) {
      setState(() {
        if (_selectedHand == HandTypes.leftHand) {
          _selectedRightGrip = null;
        } else {
          _selectedLeftGrip = null;
        }
      });
    }
  }

  void _checkTwoHanded() {
    if (_selectedHandHold == HandHolds.twoHanded) {
      if (_selectedLeftGrip == null) {
        setState(() {
          _selectedLeftGrip = Grips.openHandL;
        });
      }
      if (_selectedRightGrip == null) {
        setState(() {
          _selectedRightGrip = Grips.openHandR;
        });
      }
    }
  }

  void _handleHandHoldChanged(HandHolds handHold) {
    setState(() {
      _selectedHandHold = handHold;
    });
    _checkOneHanded();
    _checkTwoHanded();
  }

  void _handleLeftGripBoardHoldChanged(BoardHold boardHold) {
    setState(() {
      _selectedLeftGripBoardHold = boardHold;
    });
  }

  void _handleRightGripBoardHoldChanged(BoardHold boardHold) {
    setState(() {
      _selectedRightGripBoardHold = boardHold;
    });
  }

  void _handleLeftHandSelected() {
    setState(() {
      if (_selectedLeftGrip == null) {
        _selectedLeftGrip = Grips.openHandL;
      }
      _selectedHand = HandTypes.leftHand;
    });
    _checkOneHanded();
  }

  void _handleRightHandSelected() {
    setState(() {
      if (_selectedRightGrip == null) {
        _selectedRightGrip = Grips.openHandR;
      }
      _selectedHand = HandTypes.rightHand;
    });
    _checkOneHanded();
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
            GripPickerContainer(
              isLeftHandSelected: _selectedHand == HandTypes.leftHand,
              isRightHandSelected: _selectedHand == HandTypes.rightHand,
              advanced: widget.config.advancedGrips,
              selectedLeftGrip: _selectedLeftGrip,
              selectedRightGrip: _selectedRightGrip,
              selectedHandHold: _selectedHandHold,
              selectedTab: _selectedHand,
              handleLeftGripChanged: _handleLeftGripChanged,
              handleRightGripChanged: _handleRightGripChanged,
              handleHandHoldChanged: _handleHandHoldChanged,
              handleLeftHandSelected: _handleLeftHandSelected,
              handleRightHandSelected: _handleRightHandSelected,
            )
          ],
        ),
        Section(
          title: 'drag to choose',
          children: <Widget>[
            BoardHoldPicker(
              board: widget.board,
              leftGrip: _selectedLeftGrip,
              rightGrip: _selectedRightGrip,
              initialLeftGripBoardHold: _selectedLeftGripBoardHold,
              initialRightGripBoardHold: _selectedRightGripBoardHold,
              handleLeftGripBoardHoldChanged: _handleLeftGripBoardHoldChanged,
              handleRightGripBoardHoldChanged: _handleRightGripBoardHoldChanged,
            )
          ],
        )
      ],
    );
  }
}
