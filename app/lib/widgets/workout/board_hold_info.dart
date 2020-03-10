import 'package:flutter/cupertino.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/models/hold_type.dart';
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
        if (leftGripBoardHold != null)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                    text: 'hold: ',
                    style: styles.Staatliches.xsBlack,
                    children: [
                      TextSpan(
                          text: leftGripBoardHold.position.toString(),
                          style: styles.Lato.xsGray),
                    ]),
              ),
              RichText(
                text: TextSpan(
                    text: 'type: ',
                    style: styles.Staatliches.xsBlack,
                    children: [
                      TextSpan(
                          text: leftGripBoardHold.holdType.toString(),
                          style: styles.Lato.xsGray),
                    ]),
              ),
              if (leftGripBoardHold.holdType == HoldType.pocket)
                RichText(
                  text: TextSpan(
                      text: 'depth: ',
                      style: styles.Staatliches.xsBlack,
                      children: [
                        TextSpan(
                            text: leftGripBoardHold.pocketDepth.toString(),
                            style: styles.Lato.xsGray),
                        TextSpan(text: ' mm', style: styles.Lato.xsGray),
                      ]),
                ),
              if (leftGripBoardHold.holdType == HoldType.sloper)
                RichText(
                  text: TextSpan(
                      text: 'degrees: ',
                      style: styles.Staatliches.xsBlack,
                      children: [
                        TextSpan(
                            text: leftGripBoardHold.sloperDegrees.toString(),
                            style: styles.Lato.xsGray),
                      ]),
                )
            ],
          ),
        if (rightGripBoardHold != null)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                    text: 'hold: ',
                    style: styles.Staatliches.xsBlack,
                    children: [
                      TextSpan(
                          text: rightGripBoardHold.position.toString(),
                          style: styles.Lato.xsGray),
                    ]),
              ),
              RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                    text: 'type: ',
                    style: styles.Staatliches.xsBlack,
                    children: [
                      TextSpan(
                          text: rightGripBoardHold.holdType.toString(),
                          style: styles.Lato.xsGray),
                    ]),
              ),
              if (rightGripBoardHold.holdType == HoldType.pocket)
                RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                      text: 'depth: ',
                      style: styles.Staatliches.xsBlack,
                      children: [
                        TextSpan(
                            text: rightGripBoardHold.pocketDepth.toString(),
                            style: styles.Lato.xsGray),
                        TextSpan(text: ' mm', style: styles.Lato.xsGray),
                      ]),
                ),
              if (rightGripBoardHold.holdType == HoldType.sloper)
                RichText(
                  text: TextSpan(
                      text: 'degrees: ',
                      style: styles.Staatliches.xsBlack,
                      children: [
                        TextSpan(
                            text: rightGripBoardHold.sloperDegrees.toString(),
                            style: styles.Lato.xsGray),
                      ]),
                )
            ],
          )
      ],
    );
  }
}
