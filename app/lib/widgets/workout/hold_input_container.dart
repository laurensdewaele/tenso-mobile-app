import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/workout/board_hold_info.dart';
import 'package:app/widgets/workout/board_hold_picker.dart';
import 'package:app/widgets/workout/grip_picker_container.dart';

class HoldInputContainer extends StatelessWidget {
  HoldInputContainer({
    Key key,
    @required this.board,
    @required this.currentHold,
    @required this.handHold,
    @required this.holdCount,
    @required this.leftGrip,
    @required this.leftGripBoardHold,
    @required this.primaryColor,
    @required this.rightGrip,
    @required this.rightGripBoardHold,
    @required this.textPrimaryColor,
    @required this.handleLeftGripSelected,
    @required this.handleLeftHandSelected,
    @required this.handleOneHandedTap,
    @required this.handleRightGripSelected,
    @required this.handleRightHandSelected,
    @required this.handleTwoHandedTap,
    @required this.setHoldLeftGripBoardHold,
    @required this.setHoldRightGripBoardHold,
  }) : super(key: key);

  final Board board;
  final int currentHold;
  final HandHold handHold;
  final int holdCount;
  final Grip leftGrip;
  final BoardHold leftGripBoardHold;
  final Color primaryColor;
  final Grip rightGrip;
  final BoardHold rightGripBoardHold;
  final TextStyle textPrimaryColor;
  final void Function(int holdNo, HandHold handHold) handleLeftHandSelected;
  final void Function(int holdNo, HandHold handHold) handleRightHandSelected;
  final void Function(int holdNo, HandHold handHold) handleOneHandedTap;
  final void Function(int holdNo, HandHold handHold) handleTwoHandedTap;
  final void Function(int holdNo, Grip grip) handleRightGripSelected;
  final void Function(int holdNo, Grip grip) handleLeftGripSelected;
  final void Function(int holdNo, BoardHold boardHold) setHoldLeftGripBoardHold;
  final void Function(int holdNo, BoardHold boardHold)
      setHoldRightGripBoardHold;

  @override
  Widget build(BuildContext context) {
    final String _currentHoldString = (currentHold + 1).toString();
    final String _totalHoldsString = holdCount.toString();

    return Column(
      children: <Widget>[
        Section(
          title: 'hold $_currentHoldString / $_totalHoldsString',
          children: <Widget>[
            GripPickerContainer(
              textPrimaryColor: textPrimaryColor,
              primaryColor: primaryColor,
              handleLeftHandSelected: (HandHold handHold) =>
                  handleLeftHandSelected(currentHold, handHold),
              handleRightHandSelected: (HandHold handHold) =>
                  handleRightHandSelected(currentHold, handHold),
              handleOneHandedTap: (HandHold handHold) =>
                  handleOneHandedTap(currentHold, handHold),
              handleTwoHandedTap: (HandHold handHold) =>
                  handleTwoHandedTap(currentHold, handHold),
              rightGrip: rightGrip,
              leftGrip: leftGrip,
              handleRightGripSelected: (Grip grip) =>
                  handleRightGripSelected(currentHold, grip),
              handleLeftGripSelected: (Grip grip) =>
                  handleLeftGripSelected(currentHold, grip),
              handHold: handHold,
            )
          ],
        ),
        Section(
          title: 'drag to choose',
          children: <Widget>[
            BoardHoldPicker(
              board: board,
              leftGrip: leftGrip,
              rightGrip: rightGrip,
              leftGripBoardHold: leftGripBoardHold,
              rightGripBoardHold: rightGripBoardHold,
              handleLeftGripBoardHoldChanged: (BoardHold boardHold) =>
                  setHoldLeftGripBoardHold(currentHold, boardHold),
              handleRightGripBoardHoldChanged: (BoardHold boardHold) =>
                  setHoldRightGripBoardHold(currentHold, boardHold),
            ),
            Divider(
              key: UniqueKey(),
              height: styles.Measurements.m,
            ),
            BoardHoldInfo(
              leftGripBoardHold: leftGripBoardHold,
              rightGripBoardHold: rightGripBoardHold,
              leftGrip: leftGrip,
              rightGrip: rightGrip,
            )
          ],
        ),
      ],
    );
  }
}
