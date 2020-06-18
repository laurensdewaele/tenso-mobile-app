import 'dart:ui';

import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:flutter/cupertino.dart' hide Icon;

enum _SlideDirection { left, right }

class SlidingCard extends StatefulWidget {
  final Widget leftAction;
  final Widget rightAction;
  final Widget content;
  final bool border;
  final VoidCallback handleLongPress;
  final VoidCallback handleLeftActionTap;
  final VoidCallback handleRightActionTap;
  final bool divider;
  final double dividerHeight;
  final bool disabled;

  @override
  _SlidingCardState createState() => _SlidingCardState();

  const SlidingCard({
    Key key,
    @required this.leftAction,
    @required this.rightAction,
    @required this.content,
    @required this.border,
    @required this.handleLongPress,
    @required this.handleLeftActionTap,
    @required this.handleRightActionTap,
    @required this.divider,
    @required this.dividerHeight,
    @required this.disabled,
  });
}

class _SlidingCardState extends State<SlidingCard>
    with TickerProviderStateMixin {
  Animation<double> _sizeAnimation;
  Animation<Offset> _slideAnimation;
  AnimationController _sizeController;
  AnimationController _slideController;

  bool _isSliderOpen = false;
  double dx = 0.0;

  @override
  void initState() {
    super.initState();
    _sizeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _sizeAnimation = Tween<double>(begin: 1, end: 0)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(_sizeController);
    // Value 0.5 is the neutral position as our controller ranges from [0,1].
    _slideController = AnimationController(
      vsync: this,
      value: 0.5,
    );
    _slideAnimation =
        Tween<Offset>(begin: Offset(-.25, 0), end: Offset(.25, 0.0))
            .animate(_slideController);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  void _handleLeftAction() {
    _close();
    widget.handleLeftActionTap();
  }

  void _handleRightAction() async {
    _close();
    await _sizeController.forward();
    widget.handleRightActionTap();
  }

  void _handleDragStart(DragStartDetails details) {
    if (_slideController.isAnimating) {
      _slideController.stop();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    dx += details.delta.dx;
    // An action is a fourth the size of the card
    final double actionContainerSize = context.size.width / 4;
    final double traversedPercentage = dx / actionContainerSize;
    // Our controller range spans from [0,1] and the neutral position is 0.5.
    _slideController.value = .5 + traversedPercentage / 2;
  }

  void _handleDragEnd(DragEndDetails details) {
    final double velocity = details.primaryVelocity;
    final double editActionThreshold = .75;
    final double deleteActionThreshold = .25;

    if (velocity > 0) {
      if (_slideController.value >= editActionThreshold) {
        _open(_SlideDirection.right);
      } else {
        _close();
      }
    }

    if (velocity < 0) {
      if (_slideController.value <= deleteActionThreshold) {
        _open(_SlideDirection.left);
      } else {
        _close();
      }
    }

    if (velocity == 0) {
      if (_slideController.value >= editActionThreshold) {
        _open(_SlideDirection.right);
      }

      if (_slideController.value > deleteActionThreshold &&
          _slideController.value < editActionThreshold) {
        _close();
      }

      if (_slideController.value <= deleteActionThreshold) {
        _open(_SlideDirection.left);
      }
    }
  }

  void _handleLongPress() {
    widget.handleLongPress();
  }

  TickerFuture _animateTo(double value) {
    return _slideController.animateTo(value,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void _close() {
    _animateTo(.5).then((_) => {dx = 0});

    setState(() {
      _isSliderOpen = false;
    });
  }

  void _open(_SlideDirection direction) {
    if (direction == _SlideDirection.left) {
      _animateTo(0);
    }

    if (direction == _SlideDirection.right) {
      _animateTo(1);
    }

    setState(() {
      _isSliderOpen = true;
    });
  }

  void _handleContentTap() {
    if (_isSliderOpen == true) {
      _close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _sizeAnimation,
      child: Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.clip,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Card(
                    border: widget.border,
                    child: Stack(
                      overflow: Overflow.clip,
                      children: <Widget>[
                        if (widget.disabled == false)
                          Positioned.fill(
                            child: Transform.scale(
                              scale: 1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: _handleLeftAction,
                                      child: widget.leftAction,
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: _handleRightAction,
                                      child: widget.rightAction,
                                    ),
                                    flex: 1,
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (widget.disabled == false)
                          GestureDetector(
                              onHorizontalDragStart: _handleDragStart,
                              onHorizontalDragUpdate: _handleDragUpdate,
                              onHorizontalDragEnd: _handleDragEnd,
                              onLongPress: _handleLongPress,
                              child: SlideTransition(
                                  position: _slideAnimation,
                                  child: GestureDetector(
                                    onTap: _handleContentTap,
                                    child: widget.content,
                                  ))),
                        if (widget.disabled == true)
                          GestureDetector(
                            onTap: _handleContentTap,
                            child: widget.content,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (widget.divider == true) Divider(height: widget.dividerHeight)
        ],
      ),
    );
  }
}
