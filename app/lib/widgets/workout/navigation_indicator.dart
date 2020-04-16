import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/icons.dart' as icons;
import 'package:app/widgets/icon_button.dart';
import 'package:app/widgets/divider.dart';

class NavigationIndicator extends StatelessWidget {
  NavigationIndicator({
    Key key,
    @required this.primaryColor,
    @required this.handleBackNavigation,
    @required this.handleForwardNavigation,
    @required this.count,
    @required this.activeIndex,
  }) : super(key: key);

  final Color primaryColor;
  final GestureTapCallback handleBackNavigation;
  final GestureTapCallback handleForwardNavigation;
  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        activeIndex != 0
            ? _LeftChevron(
                handleTap: handleBackNavigation, primaryColor: primaryColor)
            : SizedBox(
                width: styles.Measurements.xxl,
                height: styles.Measurements.xxl,
              ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: _CircleContainer(
              primaryColor: primaryColor,
              count: count,
              activeIndex: activeIndex,
            ),
          ),
        ),
        activeIndex != count - 1
            ? _RightChevron(
                primaryColor: primaryColor,
                handleTap: handleForwardNavigation,
              )
            : SizedBox(
                width: styles.Measurements.xxl,
                height: styles.Measurements.xxl,
              )
      ],
    );
  }
}

class _CircleContainer extends StatelessWidget {
  _CircleContainer(
      {@required this.count,
      @required this.activeIndex,
      @required this.primaryColor});

  final Color primaryColor;
  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final List<int> list = List.generate(count, (i) => i + 1);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ...list.map((n) => _Circle(
              activeIndex: n == activeIndex + 1,
              primaryColor: primaryColor,
            ))
      ],
    );
  }
}

class _Circle extends StatelessWidget {
  _Circle({@required this.activeIndex, @required this.primaryColor});

  final Color primaryColor;
  final bool activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(
          width: styles.Measurements.xs / 2,
        ),
        activeIndex
            ? _ActiveCircle(primaryColor: primaryColor)
            : _NonActiveCircle(
                primaryColor: primaryColor,
              ),
        Divider(
          width: styles.Measurements.xs / 2,
        ),
      ],
    );
  }
}

class _ActiveCircle extends StatelessWidget {
  _ActiveCircle({@required this.primaryColor});

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.Measurements.s,
      height: styles.Measurements.s,
      decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
    );
  }
}

class _NonActiveCircle extends StatelessWidget {
  _NonActiveCircle({@required this.primaryColor});

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.Measurements.xs,
      height: styles.Measurements.xs,
      child: Stack(
        children: <Widget>[
          Container(
            decoration:
                BoxDecoration(color: primaryColor, shape: BoxShape.circle),
          ),
          Center(
            child: Container(
              width: styles.Measurements.xs - 3,
              height: styles.Measurements.xs - 3,
              decoration: BoxDecoration(
                  color: styles.Colors.bgWhite, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}

class _RightChevron extends StatelessWidget {
  const _RightChevron({Key key, this.handleTap, @required this.primaryColor})
      : super(key: key);

  final Color primaryColor;
  final GestureTapCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        handleTap: handleTap, icon: icons.getRightChevronIconXl(primaryColor));
  }
}

class _LeftChevron extends StatelessWidget {
  const _LeftChevron(
      {Key key, @required this.handleTap, @required this.primaryColor})
      : super(key: key);

  final Color primaryColor;
  final GestureTapCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      handleTap: handleTap,
      icon: icons.getLeftChevronIconXl(primaryColor),
    );
  }
}
