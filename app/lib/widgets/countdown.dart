import 'package:flutter/cupertino.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/styles/styles.dart' as styles;

class Countdown extends StatelessWidget {
  Countdown(
      {Key key,
      @required this.animatedBackgroundHeightFactor,
      @required this.animatedBackgroundColor,
      @required this.title,
      @required this.remainingSeconds,
      @required this.holdLabel,
      @required this.board,
      @required this.leftGrip,
      @required this.leftGripBoardHold,
      @required this.rightGrip,
      @required this.rightGripBoardHold,
      @required this.totalSets,
      @required this.currentSet,
      @required this.totalHangsPerSet,
      @required this.currentHang})
      : super(key: key);

  final double animatedBackgroundHeightFactor;
  final Color animatedBackgroundColor;
  final String title;
  final int remainingSeconds;
  final String holdLabel;
  final Board board;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final int totalSets;
  final int currentSet;
  final int totalHangsPerSet;
  final int currentHang;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(color: styles.Colors.black),
      ),
      FractionallySizedBox(
          heightFactor: animatedBackgroundHeightFactor,
          child: Container(
            decoration: BoxDecoration(color: animatedBackgroundColor),
          )),
      Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(styles.Measurements.xxl),
            child: Center(child: Text(remainingSeconds.toString())),
          )
        ],
      )
    ]);
  }
}
