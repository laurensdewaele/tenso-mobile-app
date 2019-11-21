import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/dividers.dart';

const double _kRedDragIndicatorHeight = 3.0;
const double _kRedDragIndicatorWidth =
    styles.Measurements.m + styles.Measurements.l;
const double _kMenuItemTextHeight = styles.Measurements.m * 2;
const double _kDividerHeight = styles.Measurements.m;

class BottomMenuDrawer extends StatefulWidget {
  BottomMenuDrawer({Key key, this.menuItems, this.handleMenuItemTap})
      : offset = Offset(0.0, _determineHeightOffset(menuItems.length)),
        super(key: key);

  static double _determineHeightOffset(int menuItemsAmount) {
    final totalHeight = menuItemsAmount * _kMenuItemTextHeight +
        _kDividerHeight * 3 +
        _kRedDragIndicatorHeight;
    final heightToHide =
        menuItemsAmount * _kMenuItemTextHeight + _kDividerHeight;
    return heightToHide / totalHeight;
  }

  final List<MenuItem> menuItems;
  final VoidCallback handleMenuItemTap;
  final Offset offset;

  @override
  _BottomMenuDrawerState createState() => _BottomMenuDrawerState();
}

class _BottomMenuDrawerState extends State<BottomMenuDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _slideController;
  Animation _slideAnimation;

  @override
  void initState() {
    super.initState();

    _slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _slideAnimation = Tween<Offset>(begin: widget.offset, end: Offset.zero)
        .animate(_slideController);
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _slideController.forward().orCancel;
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SlideTransition(
          position: _slideAnimation,
          child: GestureDetector(
            onTap: _handleTap,
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
                      Divider(),
                      _RedDragIndicatorRectangle(),
                      Divider(),
                      ...widget.menuItems.map(
                        (menuItem) => Container(
                          height: _kMenuItemTextHeight,
                          child: Center(
                            child: Text(
                              menuItem.name,
                              style: styles.Typography.title,
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
