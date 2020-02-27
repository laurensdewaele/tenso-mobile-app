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
  AudioCache _audioPlayer = AudioCache(prefix: 'audio/');

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
                  return _PortraitContent(
                    title: widget.title,
                    unit: widget.unit,
                    remainingSeconds: widget.remainingSeconds,
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
                  return _LandscapeContent(
                    title: widget.title,
                    unit: widget.unit,
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

class _PortraitContent extends StatefulWidget {
  _PortraitContent({
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
    @required this.unit,
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
  final Unit unit;
  final double addedWeight;
  final Orientation orientation;
  final String title;

  @override
  __PortraitContentState createState() => __PortraitContentState();
}

class __PortraitContentState extends State<_PortraitContent> {
  double _hangInfoContainerHeight = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setTotalHangInfoContainerHeight(double h) {
    setState(() {
      _hangInfoContainerHeight = h;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String _currentSet = widget.currentSet.toString();
    final String _totalSets = widget.totalSets.toString();
    final String _titleText = widget.title;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: Text(
            _titleText,
            style: styles.Typography.countdownLabel,
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
                    style: styles.Typography.countdownTimer,
                  ),
                ),
              ),
              Container(
                height: _hangInfoContainerHeight,
                child: HangInfo(
                  holdLabel: widget.holdLabel,
                  addedWeight: widget.addedWeight,
                  unit: widget.unit,
                  reportTotalHangInfoContainerHeight:
                      _setTotalHangInfoContainerHeight,
                  leftGripBoardHold: widget.leftGripBoardHold,
                  rightGripBoardHold: widget.rightGripBoardHold,
                  board: widget.board,
                  rightGrip: widget.rightGrip,
                  leftGrip: widget.leftGrip,
                  orientation: widget.orientation,
                ),
              ),
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
      ],
    );
  }
}

class _LandscapeContent extends StatelessWidget {
  _LandscapeContent({
    Key key,
    @required this.primaryColor,
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
    @required this.unit,
    @required this.orientation,
    @required this.title,
    this.addedWeight,
  }) : super(key: key);

  final Color primaryColor;
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
  final Orientation orientation;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: Text(
            title,
            style: styles.Typography.countdownLabel,
          ),
        ),
        Divider(
          height: styles.Measurements.m,
        ),
        Expanded(
            child: Stack(
          overflow: Overflow.clip,
          children: <Widget>[
            HangInfo(
              orientation: orientation,
              holdLabel: holdLabel,
              addedWeight: addedWeight,
              unit: unit,
              leftGripBoardHold: leftGripBoardHold,
              rightGripBoardHold: rightGripBoardHold,
              reportTotalHangInfoContainerHeight: (double h) {},
              board: board,
              rightGrip: rightGrip,
              leftGrip: leftGrip,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LandscapeInfo(
                addedWeight: addedWeight,
                unit: unit,
                leftGrip: leftGrip,
                leftGripBoardHold: leftGripBoardHold,
                rightGrip: rightGrip,
                rightGripBoardHold: rightGripBoardHold,
              ),
            ),
          ],
        )),
        Divider(
          height: styles.Measurements.m,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(
              height: styles.Measurements.m,
            ),
            if (totalSets > 1)
              Text(
                'set $currentSet / $totalSets',
                style: styles.Typography.countdownLabel,
              ),
            if (totalSets > 1)
              Divider(
                width: styles.Measurements.m,
              ),
            IndicatorTabs(
              count: totalHangsPerSet,
              active: currentHang,
              primaryColor: primaryColor,
            )
          ],
        )
      ],
    );
  }
}
