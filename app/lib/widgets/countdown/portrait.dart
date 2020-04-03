import 'package:flutter/cupertino.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/board_with_grips.dart';
import 'package:app/widgets/countdown/indicator_tabs.dart';

class Portrait extends StatefulWidget {
  Portrait({
    Key key,
    @required this.primaryColor,
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
    @required this.currentHang,
    @required this.weightUnit,
    @required this.orientation,
    @required this.title,
    this.addedWeight,
  }) : super(key: key);

  final Color primaryColor;
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
  final WeightUnit weightUnit;
  final double addedWeight;
  final Orientation orientation;
  final String title;

  @override
  __PortraitContentState createState() => __PortraitContentState();
}

class __PortraitContentState extends State<Portrait> {
  double _boardGripsAddedWeightContainerHeight = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setContainerHeight(double h) {
    setState(() {
      _boardGripsAddedWeightContainerHeight = h + 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String _currentSet = widget.currentSet.toString();
    final String _totalSets = widget.totalSets.toString();
    final String _titleText = widget.title;
    final String _unitText = widget.weightUnit == WeightUnit.metric ? 'kg' : 'lbs';
    final String _addedWeight = widget.addedWeight.toString();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: Text(
            _titleText,
            style: styles.Staatliches.mWhite,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    widget.remainingSeconds.toString(),
                    style: styles.Staatliches.countdownTimer,
                  ),
                ),
              ),
              Column(children: [
                Text(
                  widget.holdLabel,
                  style: styles.Staatliches.mWhite,
                ),
                Divider(
                  height: styles.Measurements.m,
                ),
                Container(
                  height: _boardGripsAddedWeightContainerHeight,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      BoardWithGrips(
                        reportTotalHeight: _setContainerHeight,
                        leftGripBoardHold: widget.leftGripBoardHold,
                        rightGripBoardHold: widget.rightGripBoardHold,
                        board: widget.board,
                        rightGrip: widget.rightGrip,
                        leftGrip: widget.leftGrip,
                        orientation: widget.orientation,
                      ),
                      if (widget.addedWeight > 0.0)
                        Container(
                          height: _boardGripsAddedWeightContainerHeight,
                          width: double.infinity,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: styles.kBorderRadiusAll,
                                      color: styles.Colors.darkGray,
                                      boxShadow: [styles.kBoxShadow]),
                                  padding: EdgeInsets.symmetric(
                                      vertical: styles.Measurements.xs,
                                      horizontal: styles.Measurements.m),
                                  child: Text(
                                    '+ $_addedWeight $_unitText',
                                    style: styles.Staatliches.xlWhite,
                                    textAlign: TextAlign.center,
                                  ))),
                        ),
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
        Divider(
          height: styles.Measurements.xxl,
        ),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.totalSets > 1)
                Text(
                  'set $_currentSet / $_totalSets',
                  style: styles.Staatliches.mWhite,
                ),
              if (widget.totalSets > 1)
                Divider(
                  height: styles.Measurements.m,
                ),
              IndicatorTabs(
                count: widget.totalHangsPerSet,
                active: widget.currentHang,
                primaryColor: widget.primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
