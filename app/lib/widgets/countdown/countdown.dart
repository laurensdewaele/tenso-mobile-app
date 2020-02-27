import 'package:flutter/cupertino.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:audioplayers/audio_cache.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/unit.dart';
import 'package:app/models/sound.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/countdown/hang_info.dart';
import 'package:app/widgets/countdown/landscape_info.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/countdown/indicator_tabs.dart';

class Countdown extends StatefulWidget {
  Countdown({
    Key key,
    @required this.animatedBackgroundHeightFactor,
    @required this.primaryColor,
    @required this.title,
    @required this.remainingSeconds,
    this.holdLabel,
    @required this.board,
    this.leftGrip,
    this.leftGripBoardHold,
    this.rightGrip,
    this.rightGripBoardHold,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalHangsPerSet,
    @required this.currentHang,
    @required this.unit,
    @required this.endSound,
    @required this.beepSound,
    @required this.beepsBeforeEnd,
    this.addedWeight,
  }) : super(key: key);

  final Sound endSound;
  final Sound beepSound;
  final int beepsBeforeEnd;
  final double animatedBackgroundHeightFactor;
  final Color primaryColor;
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
  final Unit unit;
  final double addedWeight;

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  double _hangInfoContainerHeight = 0;
  AudioCache _audioPlayer = AudioCache(prefix: 'audio/');

  void setTotalHangInfoContainerHeight(double h) {
    setState(() {
      _hangInfoContainerHeight = h;
    });
  }

  @override
  void didUpdateWidget(Countdown oldWidget) {
    if (oldWidget.remainingSeconds != widget.remainingSeconds) {
      if (widget.remainingSeconds == 0) {
        if (widget.endSound.muted != true) {
          _audioPlayer.play(widget.endSound.filename);
        }
      } else if (widget.remainingSeconds <= widget.beepsBeforeEnd) {
        if (widget.beepSound.muted != true) {
          _audioPlayer.play(widget.beepSound.filename);
        }
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    if (widget.remainingSeconds <= widget.beepsBeforeEnd) {
      if (widget.beepSound.muted != true) {
        _audioPlayer.play(widget.beepSound.filename);
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: Save progress of workout;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String _unitText = widget.unit == Unit.metric ? 'kg' : 'lb';
    final String _addedWeight = widget.addedWeight.toString();
    final String _currentSet = widget.currentSet.toString();
    final String _totalSets = widget.totalSets.toString();
    final String _addedWeightText = '+ $_addedWeight $_unitText';
    final String _titleText = widget.title;

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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Text(
                  _titleText,
                  style: styles.Typography.countdownLabel,
                ),
              ),
              if (_orientation == Orientation.portrait)
                Expanded(
                  child: Center(
                    child: AutoSizeText(
                      widget.remainingSeconds.toString(),
                      style: styles.Typography.countdownTimer,
                    ),
                  ),
                ),
              if (_orientation == Orientation.portrait)
                Container(
                  height: _hangInfoContainerHeight,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      HangInfo(
                        holdLabel: widget.holdLabel,
                        addedWeightText: _addedWeightText,
                        reportTotalHangInfoContainerHeight:
                            setTotalHangInfoContainerHeight,
                        leftGripBoardHold: widget.leftGripBoardHold,
                        rightGripBoardHold: widget.rightGripBoardHold,
                        board: widget.board,
                        rightGrip: widget.rightGrip,
                        leftGrip: widget.leftGrip,
                        orientation: _orientation,
                      ),
                    ],
                  ),
                ),
              if (_orientation == Orientation.portrait)
                Divider(
                  height: styles.Measurements.xxl,
                ),
              if (_orientation != Orientation.portrait)
                Divider(
                  height: styles.Measurements.m,
                ),
              if (_orientation != Orientation.portrait)
                Expanded(
                    child: Stack(
                  overflow: Overflow.clip,
                  children: <Widget>[
                    HangInfo(
                      orientation: _orientation,
                      holdLabel: widget.holdLabel,
                      addedWeightText: _addedWeightText,
                      reportTotalHangInfoContainerHeight:
                          setTotalHangInfoContainerHeight,
                      leftGripBoardHold: widget.leftGripBoardHold,
                      rightGripBoardHold: widget.rightGripBoardHold,
                      board: widget.board,
                      rightGrip: widget.rightGrip,
                      leftGrip: widget.leftGrip,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: LandscapeInfo(
                        addedWeightText: _addedWeightText,
                        leftGrip: widget.leftGrip,
                        leftGripBoardHold: widget.leftGripBoardHold,
                        rightGrip: widget.rightGrip,
                        rightGripBoardHold: widget.rightGripBoardHold,
                      ),
                    ),
                  ],
                )),
              if (_orientation != Orientation.portrait)
                Divider(
                  height: styles.Measurements.m,
                ),
              if (_orientation == Orientation.portrait)
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (widget.totalSets > 1)
                        Text(
                          'set $_currentSet / $_totalSets',
                          style: styles.Typography.countdownLabel,
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
              if (_orientation != Orientation.portrait)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Divider(
                      height: styles.Measurements.m,
                    ),
                    if (widget.totalSets > 1)
                      Text(
                        'set $_currentSet / $_totalSets',
                        style: styles.Typography.countdownLabel,
                      ),
                    if (widget.totalSets > 1)
                      Divider(
                        width: styles.Measurements.m,
                      ),
                    IndicatorTabs(
                      count: widget.totalHangsPerSet,
                      active: widget.currentHang,
                      primaryColor: widget.primaryColor,
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    ]);
  }
}
