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

class BottomMenuDrawer extends StatefulWidget {
  BottomMenuDrawer({Key key, @required this.menuItems, this.handleMenuItemTap})
      : totalHeight = _determineTotalHeight(menuItems.length),
        offset = Offset(0.0, _determineHeightOffset(menuItems.length)),
        super(key: key);

  final List<MenuItem> menuItems;
  final VoidCallback handleMenuItemTap;
  final Offset offset;
  final double totalHeight;

  static double _determineTotalHeight(int menuItemsAmount) {
    final totalHeight = menuItemsAmount * _kMenuItemTextHeight +
        _kDividerHeight +
        _kRedDragIndicatorContainerHeight;
    return totalHeight;
  }

  static double _determineHeightOffset(int menuItemsAmount) {
    final double totalHeight = _determineTotalHeight(menuItemsAmount);
    final heightToHide =
        menuItemsAmount * _kMenuItemTextHeight + _kDividerHeight;
    return heightToHide / totalHeight;
  }

  @override
  _BottomMenuDrawerState createState() => _BottomMenuDrawerState();
}

class _BottomMenuDrawerState extends State<BottomMenuDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _slideController;
  Animatable<Offset> _slideAnimation;

  double dy = 0.0;

  @override
  void initState() {
    super.initState();

    _slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _slideAnimation = Tween<Offset>(begin: widget.offset, end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _open() {
    _slideController.forward().orCancel;
  }

  void _close() {
    _slideController.reverse().orCancel.then((_) => {dy = 0});
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
    // If we're dragging upwards, thus generating a negative dy,
    // we want the controller to open e.g. 40%, i.e. a positive value.
    // Therefore the `* -1`.
    dy += details.delta.dy * -1;
    final double traversedPercentage = dy / widget.totalHeight;
    _slideController.value = traversedPercentage;
  }

  void _handleDragEnd(DragEndDetails details) {
    final double velocity = details.primaryVelocity;
    final double threshold = 0.5;

    // Dragging upwards has a negative velocity
    if (velocity < 0) {
      _open();
    }

    if (velocity > 0) {
      _close();
    }

    if (velocity == 0) {
      if (_slideController.value >= threshold) {
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
                            print('Navigating to $menuItem.route');
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
