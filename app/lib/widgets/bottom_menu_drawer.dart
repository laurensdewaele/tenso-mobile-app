import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icon.dart';

class MenuItem {
  final String name;
  final Icon icon;
  final VoidCallback handleTap;

  const MenuItem({
    @required this.name,
    @required this.icon,
    @required this.handleTap,
  });
}

const double _kRedDragIndicatorHeight = 3.0;
const double _kRedDragIndicatorContainerHeight = styles.Measurements.xl;
const double _kRedDragIndicatorWidth =
    styles.Measurements.m + styles.Measurements.l;
const double _kMenuItemHeight = styles.Measurements.m * 2;
const double _kDividerHeight = styles.Measurements.m;

enum SliderPositions { begin, end }

class BottomMenuDrawer extends StatefulWidget {
  BottomMenuDrawer(
      {Key key,
      this.startOpen = false,
      @required this.longestMenuItemLength,
      @required this.menuItems})
      : super(key: key);

  final bool startOpen;
  final List<MenuItem> menuItems;
  final double longestMenuItemLength;

  @override
  _BottomMenuDrawerState createState() => _BottomMenuDrawerState();
}

class _BottomMenuDrawerState extends State<BottomMenuDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _slideController;
  Animatable<Offset> _slideAnimation;

  double _dy = 0.0;
  SliderPositions _position = SliderPositions.begin;

  double _heightToHide;
  double _offsetHeight;

  @override
  void initState() {
    super.initState();
    _setMeasurements();
    _slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _slideController.value = 1;
    _position = SliderPositions.end;
    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.0, _offsetHeight))
            .chain(CurveTween(curve: Curves.easeIn));
    if (widget.startOpen == true) {
      _reverse();
    }
  }

  void _setMeasurements() {
    final double _totalHeight = widget.menuItems.length * _kMenuItemHeight +
        _kDividerHeight +
        _kRedDragIndicatorContainerHeight;
    _heightToHide =
        widget.menuItems.length * _kMenuItemHeight + _kDividerHeight;
    _offsetHeight = _heightToHide / _totalHeight;
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _forward() async {
    try {
      await _slideController.forward().orCancel;
    } catch (_) {}
    _dy = 0;
    setState(() {
      _position = SliderPositions.end;
    });
  }

  void _reverse() async {
    try {
      await _slideController.reverse().orCancel;
    } catch (_) {}
    _dy = 0;
    setState(() {
      _position = SliderPositions.begin;
    });
  }

  void _handleRedDragIndicatorTap() {
    if (_slideController.value > 0) {
      _reverse();
    } else {
      _forward();
    }
  }

  void _handleDragStart(DragStartDetails details) {
    if (_slideController.isAnimating) {
      _slideController.stop();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _dy += details.delta.dy;
    final double traversedPercentage = (_dy / (_heightToHide)).abs();

    if (_position == SliderPositions.begin && _dy > 0) {
      _slideController.value = traversedPercentage;
    }

    if (_position == SliderPositions.end && _dy < 0) {
      _slideController.value = 1 - traversedPercentage;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    final double velocity = details.primaryVelocity;

    if (velocity > 0) {
      _forward();
    }

    // Dragging upwards has a negative velocity
    if (velocity < 0) {
      _reverse();
    }

    if (velocity == 0) {
      if (_slideController.value >= 0.5) {
        _forward();
      } else {
        _reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SlideTransition(
          position: _slideController.drive(_slideAnimation),
          child: GestureDetector(
            onVerticalDragStart: _handleDragStart,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: styles.Colors.bgWhite,
                borderRadius: BorderRadius.only(
                    topLeft: styles.kBorderRadius,
                    topRight: styles.kBorderRadius),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0005, 0.005],
                  colors: [styles.Colors.bgGrayStop, styles.Colors.bgWhite],
                ),
              ),
              child: SafeArea(
                  top: false,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: _handleRedDragIndicatorTap,
                        child: Container(
                          decoration:
                              BoxDecoration(color: styles.Colors.translucent),
                          height: _kRedDragIndicatorContainerHeight,
                          width: double.infinity,
                          child: Center(
                            child: _RedDragIndicatorRectangle(),
                          ),
                        ),
                      ),
                      ...widget.menuItems
                          .map(
                            (menuItem) => GestureDetector(
                              onTap: () {
                                _forward();
                                menuItem.handleTap();
                              },
                              child: _MenuItemRow(
                                  name: menuItem.name,
                                  icon: menuItem.icon,
                                  longestMenuItemLength:
                                      widget.longestMenuItemLength),
                            ),
                          )
                          .toList(),
                      Divider(height: styles.Measurements.m),
                    ],
                  )),
            ),
          ),
        )
      ],
    );
  }
}

class _RedDragIndicatorRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kRedDragIndicatorWidth,
      height: _kRedDragIndicatorHeight,
      decoration: BoxDecoration(
          color: styles.Colors.primary, borderRadius: styles.kBorderRadiusAll),
    );
  }
}

class _MenuItemRow extends StatelessWidget {
  _MenuItemRow(
      {Key key,
      @required this.name,
      @required this.icon,
      @required this.longestMenuItemLength})
      : super(key: key);

  final String name;
  final Icon icon;
  final double longestMenuItemLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kMenuItemHeight,
      decoration: BoxDecoration(color: styles.Colors.translucent),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Container(
            width: longestMenuItemLength,
            child: Row(
              children: <Widget>[
                Container(
                    height: 25,
                    width: 25,
                    child: Center(child: FittedBox(child: icon))),
                Divider(
                  width: styles.Measurements.xs,
                ),
                Center(
                  child: Text(
                    name,
                    style: styles.Staatliches.xlBlack,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }
}
