import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/icon_button.dart';
import 'package:app/widgets/divider.dart';

class Tabs extends StatelessWidget {
  Tabs(
      {Key key,
      this.handleBackNavigation,
      this.handleForwardNavigation,
      this.amount,
      this.active})
      : super(key: key);

  final GestureTapCallback handleBackNavigation;
  final GestureTapCallback handleForwardNavigation;
  final int amount;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        LeftChevron(handleTap: handleBackNavigation),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: CircleContainer(
              amount: amount,
              active: active,
            ),
          ),
        ),
        RightChevron(
          handleTap: handleForwardNavigation,
        )
      ],
    );
  }
}

class CircleContainer extends StatelessWidget {
  CircleContainer({this.amount, this.active});

  final int amount;
  final int active;

  @override
  Widget build(BuildContext context) {
    final List<int> list = List.generate(amount, (i) => i + 1);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[...list.map((n) => Circle(active: n == active))],
    );
  }
}

class Circle extends StatelessWidget {
  Circle({this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(
          width: styles.Measurements.xs / 2,
        ),
        active ? ActiveCircle() : NonActiveCircle(),
        Divider(
          width: styles.Measurements.xs / 2,
        ),
      ],
    );
  }
}

class ActiveCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.Measurements.s,
      height: styles.Measurements.s,
      decoration:
          BoxDecoration(color: styles.Colors.primary, shape: BoxShape.circle),
    );
  }
}

class NonActiveCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.Measurements.xs,
      height: styles.Measurements.xs,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: styles.Colors.primary, shape: BoxShape.circle),
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

class RightChevron extends StatelessWidget {
  const RightChevron({Key key, this.handleTap}) : super(key: key);

  final GestureTapCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      offset: Offset(20, 0),
      handleTap: handleTap,
      icon: Icon(
          iconData: IconData(0xf3d1,
              fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
          size: styles.Measurements.l,
          color: styles.Colors.primary),
    );
  }
}

class LeftChevron extends StatelessWidget {
  const LeftChevron({Key key, this.handleTap}) : super(key: key);

  final GestureTapCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      offset: Offset(-20, 0),
      handleTap: handleTap,
      icon: Icon(
          iconData: IconData(0xf3cf,
              fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
          size: styles.Measurements.l,
          color: styles.Colors.primary),
    );
  }
}
