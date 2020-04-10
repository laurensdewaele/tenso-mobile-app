import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
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
    @required this.totalHolds,
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
    @required this.setLeftGripBoardHold,
    @required this.setRightGripBoardHold,
  }) : super(key: key);

  final int currentHold;
  final int totalHolds;
  final Board board;
  final HandHold handHold;
  final Grip leftGrip;
  final BoardHold leftGripBoardHold;
  final Color primaryColor;
  final Grip rightGrip;
  final BoardHold rightGripBoardHold;
  final TextStyle textPrimaryColor;
  final void Function(HandHold handHold) handleLeftHandSelected;
  final void Function(HandHold handHold) handleRightHandSelected;
  final void Function(HandHold handHold) handleOneHandedTap;
  final void Function(HandHold handHold) handleTwoHandedTap;
  final void Function(Grip grip) handleRightGripSelected;
  final void Function(Grip grip) handleLeftGripSelected;
  final void Function(BoardHold boardHold) setLeftGripBoardHold;
  final void Function(BoardHold boardHold) setRightGripBoardHold;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Section(
          title: 'hold $currentHold / $totalHolds',
          children: <Widget>[
            GripPickerContainer(
              textPrimaryColor: textPrimaryColor,
              primaryColor: primaryColor,
              handleLeftHandSelected: handleLeftHandSelected,
              handleRightHandSelected: handleRightHandSelected,
              handleOneHandedTap: handleOneHandedTap,
              handleTwoHandedTap: handleTwoHandedTap,
              rightGrip: rightGrip,
              leftGrip: leftGrip,
              handleRightGripSelected: handleRightGripSelected,
              handleLeftGripSelected: handleLeftGripSelected,
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
              handleLeftGripBoardHoldChanged: setLeftGripBoardHold,
              handleRightGripBoardHoldChanged: setRightGripBoardHold,
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
