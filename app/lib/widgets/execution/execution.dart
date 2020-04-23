import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/execution/portrait.dart';
import 'package:app/widgets/execution/landscape.dart';

class Execution extends StatefulWidget {
  Execution({
    Key key,
    @required this.animatedBackgroundHeightFactor,
    @required this.primaryColor,
    @required this.title,
    @required this.seconds,
    @required this.holdLabel,
    @required this.board,
    @required this.leftGrip,
    @required this.leftGripBoardHold,
    @required this.rightGrip,
    @required this.rightGripBoardHold,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalHangsPerSet,
    @required this.currentHang,
    @required this.weightUnit,
    @required this.endSound,
    @required this.beepSound,
    @required this.beepsBeforeEnd,
    @required this.addedWeight,
  }) : super(key: key);

  final Sound endSound;
  final Sound beepSound;
  final int beepsBeforeEnd;
  final double animatedBackgroundHeightFactor;
  final Color primaryColor;
  final String title;
  final int seconds;
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
  final WeightUnit weightUnit;
  final double addedWeight;

  @override
  _ExecutionState createState() => _ExecutionState();
}

class _ExecutionState extends State<Execution> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Skip this widget and put it in the screen
    final Orientation _orientation = MediaQuery.of(context).orientation;
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(color: styles.Colors.bgBlack),
      ),
      FractionallySizedBox(
          heightFactor: widget.animatedBackgroundHeightFactor,
          child: Container(
            decoration: BoxDecoration(color: widget.primaryColor),
          )),
      SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(styles.Measurements.m),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (_orientation == Orientation.portrait) {
                  return Portrait(
                    title: widget.title,
                    weightUnit: widget.weightUnit,
                    seconds: widget.seconds,
                    orientation: _orientation,
                    rightGripBoardHold: widget.rightGripBoardHold,
                    rightGrip: widget.rightGrip,
                    leftGripBoardHold: widget.leftGripBoardHold,
                    leftGrip: widget.leftGrip,
                    board: widget.board,
                    currentHang: widget.currentHang,
                    currentSet: widget.currentSet,
                    holdLabel: widget.holdLabel,
                    primaryColor: widget.primaryColor,
                    totalHangsPerSet: widget.totalHangsPerSet,
                    totalSets: widget.totalSets,
                    addedWeight: widget.addedWeight,
                  );
                } else {
                  return Landscape(
                    title: widget.title,
                    weightUnit: widget.weightUnit,
                    orientation: _orientation,
                    rightGripBoardHold: widget.rightGripBoardHold,
                    rightGrip: widget.rightGrip,
                    leftGripBoardHold: widget.leftGripBoardHold,
                    leftGrip: widget.leftGrip,
                    board: widget.board,
                    currentHang: widget.currentHang,
                    currentSet: widget.currentSet,
                    holdLabel: widget.holdLabel,
                    primaryColor: widget.primaryColor,
                    totalHangsPerSet: widget.totalHangsPerSet,
                    totalSets: widget.totalSets,
                    addedWeight: widget.addedWeight,
                  );
                }
              },
            )),
      ),
    ]);
  }
}

abstract class ExecutionTitles {
  static const String preparation = 'preparation';
  static const String hang = 'hang';
  static const String recoveryRest = 'recovery rest';
}

abstract class ExecutionHoldLabels {
  static const String nextUp = 'next up';
  // It needs to be empty, otherwise there's a shift in height across screens
  static const String hang = '';
}
