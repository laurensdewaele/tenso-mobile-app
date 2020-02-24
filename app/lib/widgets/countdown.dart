import 'package:flutter/cupertino.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:app/models/board.dart';
import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_type.dart';
import 'package:app/models/unit.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/grip_image.dart';
import 'package:app/widgets/indicator_tabs.dart';

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
    this.addedWeight,
  }) : super(key: key);

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

  void setTotalHangInfoContainerHeight(double h) {
    setState(() {
      _hangInfoContainerHeight = h;
    });
  }

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
    final String _unitText = widget.unit == Unit.metric ? 'kg' : 'lb';
    final String _addedWeight = widget.addedWeight.toString();
    final String _currentSet = widget.currentSet.toString();
    final String _totalSets = widget.totalSets.toString();
    final String _addedWeightText = '+ $_addedWeight $_unitText';
    final String _titleText = widget.title;

    final Orientation _orientation = MediaQuery.of(context).orientation;
    final double _largeDividerHeight = _orientation == Orientation.portrait
        ? styles.Measurements.xxl
        : styles.Measurements.m;
    final double _smallDividerHeight = _orientation == Orientation.portrait
        ? styles.Measurements.m
        : styles.Measurements.xs;

    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(color: styles.Colors.black),
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
                      _HangInfo(
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
                    ],
                  ),
                ),
              if (_orientation == Orientation.portrait)
                Divider(
                  height: styles.Measurements.xxl,
                ),
              if (_orientation != Orientation.portrait)
                Expanded(
                  child: Row(
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
                      Expanded(
                        child: Container(
                          height: _hangInfoContainerHeight,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              _HangInfo(
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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

// TODO: SO much repetition with BoardHoldPicker
class _HangInfo extends StatefulWidget {
  _HangInfo({
    Key key,
    this.holdLabel,
    @required this.board,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.reportTotalHangInfoContainerHeight,
    this.addedWeightText,
  }) : super(key: key);

  final String holdLabel;
  final Board board;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final Function(double h) reportTotalHangInfoContainerHeight;
  final String addedWeightText;

  @override
  _HangInfoState createState() => _HangInfoState();
}

class _HangInfoState extends State<_HangInfo> {
  double _boardContainerHeight;
  Size _boardSize;
  double _gripHeight;
  Offset _leftHandOffset;
  Offset _rightHandOffset;

  @override
  void didUpdateWidget(Widget oldWidget) {
    if (widget.leftGrip != null && widget.leftGripBoardHold != null) {
      _setHandOffset(widget.leftGrip, widget.leftGripBoardHold);
    }

    if (widget.rightGrip != null && widget.rightGripBoardHold != null) {
      _setHandOffset(widget.rightGrip, widget.rightGripBoardHold);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _handleBoardDimensions(Size boardSize) {
    final gripHeight = boardSize.height * widget.board.handToBoardHeightRatio;
    final holdLabelHeight = 45;
    final boardContainerHeight = boardSize.height +
        (boardSize.height * widget.board.handToBoardHeightRatio);

    setState(() {
      _boardSize = boardSize;
      _gripHeight = gripHeight;
      _boardContainerHeight = boardContainerHeight;
    });

    widget.reportTotalHangInfoContainerHeight(
        boardContainerHeight + holdLabelHeight);

    if (widget.leftGrip != null && widget.leftGripBoardHold != null) {
      _setHandOffset(widget.leftGrip, widget.leftGripBoardHold);
    }
    if (widget.rightGrip != null && widget.rightGripBoardHold != null) {
      _setHandOffset(widget.rightGrip, widget.rightGripBoardHold);
    }
  }

  _setHandOffset(Grip grip, BoardHold boardHold) {
    final double gripDYHangAnchor = grip.dyRelativeHangAnchor * _gripHeight;
    final double gripDXHangAnchor =
        grip.dxRelativeHangAnchor * grip.assetAspectRatio * _gripHeight;
    final double holdDYHangAnchor =
        boardHold.dyRelativeHangAnchor * _boardSize.height;
    final double holdDXHangAnchor =
        boardHold.dxRelativeHangAnchor * _boardSize.width;
    final Offset offset = Offset(holdDXHangAnchor - gripDXHangAnchor,
        holdDYHangAnchor - gripDYHangAnchor);

    if (grip.handType == HandType.leftHand) {
      setState(() {
        _leftHandOffset = offset;
      });
    } else {
      setState(() {
        _rightHandOffset = offset;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (widget.holdLabel != null)
          Text(
            widget.holdLabel,
            style: styles.Typography.countdownLabel,
          ),
        if (widget.holdLabel != null)
          Divider(
            height: styles.Measurements.m,
          ),
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: _boardContainerHeight,
              child: Container(),
            ),
            _Board(
              boardAspectRatio: widget.board.aspectRatio,
              boardAssetSrc: widget.board.assetSrc,
              handleBoardDimensions: _handleBoardDimensions,
              setHandOffset: _setHandOffset,
              orientation: MediaQuery.of(context).orientation,
            ),
            if (widget.leftGrip != null && _leftHandOffset != null)
              Positioned(
                left: _leftHandOffset.dx,
                top: _leftHandOffset.dy,
                child: Container(
                  height: _gripHeight,
                  child: GripImage(
                    assetSrc: widget.leftGrip.assetSrc,
                    selected: false,
                    color: styles.Colors.lighestGray,
                  ),
                ),
              ),
            if (widget.rightGrip != null && _rightHandOffset != null)
              Positioned(
                left: _rightHandOffset.dx,
                top: _rightHandOffset.dy,
                child: Container(
                  height: _gripHeight,
                  child: GripImage(
                    assetSrc: widget.rightGrip.assetSrc,
                    selected: false,
                    color: styles.Colors.lighestGray,
                  ),
                ),
              ),
            if (widget.addedWeightText != null)
              Container(
                height: _boardContainerHeight,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _AddedWeightInfo(
                    text: widget.addedWeightText,
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}

class _Board extends StatefulWidget {
  _Board({
    Key key,
    @required this.handleBoardDimensions,
    @required this.setHandOffset,
    @required this.orientation,
    @required this.boardAspectRatio,
    @required this.boardAssetSrc,
  }) : super(key: key);

  final double boardAspectRatio;
  final String boardAssetSrc;
  final Function(Size boardSize) handleBoardDimensions;
  final Function(Grip grip, BoardHold boardHold) setHandOffset;
  final Orientation orientation;

  @override
  _BoardDragTargetsState createState() => _BoardDragTargetsState();
}

class _BoardDragTargetsState extends State<_Board> {
  bool _shouldCheckDimensions = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(_Board oldWidget) {
    if (oldWidget.orientation != widget.orientation) {
      setState(() {
        _shouldCheckDimensions = true;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  void _triggerPostFrameCallback(Size boardSize) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.handleBoardDimensions(boardSize);
      setState(() {
        _shouldCheckDimensions = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final Size _boardSize = Size(
          constraints.maxWidth, constraints.maxWidth / widget.boardAspectRatio);

      if (_shouldCheckDimensions == true) {
        _triggerPostFrameCallback(_boardSize);
      }
      return Stack(
        children: <Widget>[
          Container(
              child: Image.asset(
            widget.boardAssetSrc,
          )),
        ],
      );
    });
  }
}

class _AddedWeightInfo extends StatelessWidget {
  _AddedWeightInfo({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            color: styles.Colors.gray,
            boxShadow: [styles.kBoxShadow]),
        padding: EdgeInsets.symmetric(
            vertical: styles.Measurements.xs,
            horizontal: styles.Measurements.m),
        child: Text(
          text,
          style: styles.Typography.countdownAddedWeight,
          textAlign: TextAlign.center,
        ));
  }
}
