import 'package:app/models/hold_type.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/styles/styles.dart' as styles;

class BoardHoldInfo extends StatelessWidget {
  BoardHoldInfo({this.leftGripBoardHold, this.rightGripBoardHold});

  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  text: 'hold: ',
                  style: styles.Typography.smallBlack,
                  children: [
                    TextSpan(
                        text: leftGripBoardHold.position.toString(),
                        style: styles.Typography.text),
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: 'type: ',
                  style: styles.Typography.smallBlack,
                  children: [
                    TextSpan(
                        text: leftGripBoardHold.holdType.toString(),
                        style: styles.Typography.text),
                  ]),
            ),
            if (leftGripBoardHold.holdType == HoldType.pocket)
              RichText(
                text: TextSpan(
                    text: 'depth: ',
                    style: styles.Typography.smallBlack,
                    children: [
                      TextSpan(
                          text: leftGripBoardHold.pocketDepth.toString(),
                          style: styles.Typography.text),
                      TextSpan(text: ' mm', style: styles.Typography.text),
                    ]),
              ),
            if (leftGripBoardHold.holdType == HoldType.sloper)
              RichText(
                text: TextSpan(
                    text: 'degrees: ',
                    style: styles.Typography.smallBlack,
                    children: [
                      TextSpan(
                          text: leftGripBoardHold.sloperDegrees.toString(),
                          style: styles.Typography.text),
                    ]),
              )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                  text: 'hold: ',
                  style: styles.Typography.smallBlack,
                  children: [
                    TextSpan(
                        text: rightGripBoardHold.position.toString(),
                        style: styles.Typography.text),
                  ]),
            ),
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                  text: 'type: ',
                  style: styles.Typography.smallBlack,
                  children: [
                    TextSpan(
                        text: rightGripBoardHold.holdType.toString(),
                        style: styles.Typography.text),
                  ]),
            ),
            if (rightGripBoardHold.holdType == HoldType.pocket)
              RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                    text: 'depth: ',
                    style: styles.Typography.smallBlack,
                    children: [
                      TextSpan(
                          text: rightGripBoardHold.pocketDepth.toString(),
                          style: styles.Typography.text),
                      TextSpan(text: ' mm', style: styles.Typography.text),
                    ]),
              ),
            if (rightGripBoardHold.holdType == HoldType.sloper)
              RichText(
                text: TextSpan(
                    text: 'degrees: ',
                    style: styles.Typography.smallBlack,
                    children: [
                      TextSpan(
                          text: rightGripBoardHold.sloperDegrees.toString(),
                          style: styles.Typography.text),
                    ]),
              )
          ],
        )
      ],
    );
  }
}
