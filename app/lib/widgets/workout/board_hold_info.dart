import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

class BoardHoldInfo extends StatelessWidget {
  BoardHoldInfo(
      {this.leftGripBoardHold,
      this.rightGripBoardHold,
      this.leftGrip,
      this.rightGrip});

  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (leftGripBoardHold != null)
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (leftGripBoardHold.position != null)
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
                            text: leftGripBoardHold.type.toString(),
                            style: styles.Lato.xsGray),
                      ]),
                ),
                if (leftGripBoardHold.type == HoldType.pocket ||
                    leftGripBoardHold.type == HoldType.edge)
                  RichText(
                    text: TextSpan(
                        text: 'depth: ',
                        style: styles.Staatliches.xsBlack,
                        children: [
                          TextSpan(
                              text: leftGripBoardHold.depth.toString(),
                              style: styles.Lato.xsGray),
                          TextSpan(text: ' mm', style: styles.Lato.xsGray),
                        ]),
                  ),
                if (leftGripBoardHold.type == HoldType.sloper)
                  RichText(
                    text: TextSpan(
                        text: 'degrees: ',
                        style: styles.Staatliches.xsBlack,
                        children: [
                          TextSpan(
                              text: leftGripBoardHold.sloperDegrees.toString(),
                              style: styles.Lato.xsGray),
                        ]),
                  ),
                if (leftGrip != null)
                  RichText(
                    text: TextSpan(
                        text: 'grip: ',
                        style: styles.Staatliches.xsBlack,
                        children: [
                          TextSpan(
                              text: leftGrip.description,
                              style: styles.Lato.xsGray),
                        ]),
                  )
              ],
            ),
          ),
        if (rightGripBoardHold != null)
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (rightGripBoardHold.position != null)
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
                            text: rightGripBoardHold.type.toString(),
                            style: styles.Lato.xsGray),
                      ]),
                ),
                if (rightGripBoardHold.type == HoldType.pocket ||
                    rightGripBoardHold.type == HoldType.edge)
                  RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                        text: 'depth: ',
                        style: styles.Staatliches.xsBlack,
                        children: [
                          TextSpan(
                              text: rightGripBoardHold.depth.toString(),
                              style: styles.Lato.xsGray),
                          TextSpan(text: ' mm', style: styles.Lato.xsGray),
                        ]),
                  ),
                if (rightGripBoardHold.type == HoldType.sloper)
                  RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                        text: 'degrees: ',
                        style: styles.Staatliches.xsBlack,
                        children: [
                          TextSpan(
                              text: rightGripBoardHold.sloperDegrees.toString(),
                              style: styles.Lato.xsGray),
                        ]),
                  ),
                if (rightGrip != null)
                  RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                        text: 'grip: ',
                        style: styles.Staatliches.xsBlack,
                        children: [
                          TextSpan(
                              text: rightGrip.description,
                              style: styles.Lato.xsGray),
                        ]),
                  )
              ],
            ),
          )
      ],
    );
  }
}
