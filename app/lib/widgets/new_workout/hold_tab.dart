import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedLeftGrip = widget.hold.leftGrip;
    _selectedRightGrip = widget.hold.rightGrip;
    _selectedLeftGripBoardHold = widget.hold.leftGripBoardHold;
    _selectedRightGripBoardHold = widget.hold.rightGripBoardHold;

    _selectedHandHold = widget.hold.handHold;
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

  void _handleHandHoldChanged(HandHolds handHold) {
    setState(() {
      _selectedHandHold = handHold;
    });
  }

  void _handleLeftGripBoardHoldChanged(BoardHold boardHold) {}
  void _handleRightGripBoardHoldChanged(BoardHold boardHold) {}

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
                advanced: widget.config.advancedGrips,
                initialLeftGrip: _selectedLeftGrip,
                initialRightGrip: _selectedRightGrip,
                initialHandHold: _selectedHandHold,
                handleLeftGripChanged: _handleLeftGripChanged,
                handleRightGripChanged: _handleRightGripChanged,
                handleHandHoldChanged: _handleHandHoldChanged)
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
