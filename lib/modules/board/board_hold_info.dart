import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

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
                RichText(
                  text: TextSpan(
                      text: 'position: ',
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
                if (leftGripBoardHold.holdType == HoldType.pinchBlock &&
                    leftGripBoardHold.pinchWidth != null)
                  RichText(
                    text: TextSpan(
                        text: 'width: ',
                        style: styles.Staatliches.xsBlack,
                        children: [
                          TextSpan(
                              text: leftGripBoardHold.pinchWidth.toString(),
                              style: styles.Lato.xsGray),
                          TextSpan(text: ' mm', style: styles.Lato.xsGray),
                        ]),
                  ),
                if (leftGripBoardHold.holdType == HoldType.pocket ||
                    leftGripBoardHold.holdType == HoldType.edge)
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
                if (leftGripBoardHold.sloperDegrees != null)
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
                RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                      text: 'position: ',
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
                if (rightGripBoardHold.holdType == HoldType.pinchBlock &&
                    rightGripBoardHold.pinchWidth != null)
                  RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                        text: 'width: ',
                        style: styles.Staatliches.xsBlack,
                        children: [
                          TextSpan(
                              text: rightGripBoardHold.pinchWidth.toString(),
                              style: styles.Lato.xsGray),
                          TextSpan(text: ' mm', style: styles.Lato.xsGray),
                        ]),
                  ),
                if (rightGripBoardHold.holdType == HoldType.pocket ||
                    rightGripBoardHold.holdType == HoldType.edge)
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
                if (rightGripBoardHold.sloperDegrees != null)
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
