import 'package:flutter/cupertino.dart';

import 'package:app/models/menu_item.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/dividers.dart';

const double _kRedDragIndicatorHeight = 3.0;
const double _kRedDragIndicatorContainerHeight = styles.Measurements.xl;
const double _kRedDragIndicatorWidth =
    styles.Measurements.m + styles.Measurements.l;
const double _kMenuItemTextHeight = styles.Measurements.m * 2;
const double _kDividerHeight = styles.Measurements.m;
enum SliderPositions { begin, end }

class BottomMenuDrawer extends StatefulWidget {
  BottomMenuDrawer({Key key, @required this.menuItems, this.handleMenuItemTap})
      : heightToHide = _determineHeightToHide(menuItems.length),
        offsetHeight = _determineHeightOffset(menuItems.length),
        super(key: key);

  final List<MenuItem> menuItems;
  final VoidCallback handleMenuItemTap;
  final double heightToHide;
  final double offsetHeight;

  static double _determineTotalHeight(int menuItemsAmount) {
    final totalHeight = menuItemsAmount * _kMenuItemTextHeight +
        _kDividerHeight +
        _kRedDragIndicatorContainerHeight;
    return totalHeight;
  }

  static double _determineHeightToHide(int menuItemsAmount) {
    return menuItemsAmount * _kMenuItemTextHeight + _kDividerHeight;
  }

  static double _determineHeightOffset(int menuItemsAmount) {
    final double totalHeight = _determineTotalHeight(menuItemsAmount);
    final heightToHide = _determineHeightToHide(menuItemsAmount);
    return heightToHide / totalHeight;
  }

  @override
  _BottomMenuDrawerState createState() => _BottomMenuDrawerState();
}

class _BottomMenuDrawerState extends State<BottomMenuDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _slideController;
  Animatable<Offset> _slideAnimation;

  double _dy = 0.0;
  SliderPositions _position = SliderPositions.begin;

  @override
  void initState() {
    super.initState();

    _slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.0, widget.offsetHeight))
            .chain(CurveTween(curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _open() {
    _slideController.forward().orCancel.then((_) {
      _dy = 0;
      setState(() {
        _position = SliderPositions.end;
      });
    });
  }

  void _close() {
    _slideController.reverse().orCancel.then((_) {
      _dy = 0;
      setState(() {
        _position = SliderPositions.begin;
      });
    });
  }

  void _handleRedDragIndicatorTap() {
    if (_slideController.value > 0) {
      _close();
    } else {
      _open();
    }
  }

  void _handleDragStart(DragStartDetails details) {
    if (_slideController.isAnimating) {
      _slideController.stop();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _dy += details.delta.dy;
    final double traversedPercentage = (_dy / (widget.heightToHide)).abs();

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
      _open();
    }

    // Dragging upwards has a negative velocity
    if (velocity < 0) {
      _close();
    }

    if (velocity == 0) {
      if (_slideController.value >= 0.5) {
        _open();
      } else {
        _close();
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
                    topLeft: styles.kAppBorderRadius,
                    topRight: styles.kAppBorderRadius),
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
                      ...widget.menuItems.map(
                        (menuItem) => GestureDetector(
                          onTap: () {
                            // TODO: Navigate to the proper route
                          },
                          child: Container(
                            height: _kMenuItemTextHeight,
                            child: Center(
                              child: Text(
                                menuItem.name,
                                style: styles.Typography.title,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(),
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
          color: styles.Colors.primary,
          borderRadius: styles.kAppBorderRadiusAll),
    );
  }
}
