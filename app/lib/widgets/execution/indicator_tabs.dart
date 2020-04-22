import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';

// There could be some better code re-use with the normal
// NavigatorTabs, but this make the code much more readable.
class IndicatorTabs extends StatelessWidget {
  IndicatorTabs(
      {this.count, this.active, this.primaryColor = styles.Colors.primary});

  final int count;
  final int active;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: _CircleContainer(
        primaryColor: primaryColor,
        count: count,
        active: active,
      ),
    );
  }
}

class _CircleContainer extends StatelessWidget {
  _CircleContainer(
      {@required this.count,
      @required this.active,
      @required this.primaryColor});

  final Color primaryColor;
  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    final List<int> list = List.generate(count, (i) => i + 1);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ...list.map((n) {
          if (n < active) {
            return _CompletedCircle(
              primaryColor: primaryColor,
            );
          } else {
            return _Circle(
              active: n == active,
              primaryColor: primaryColor,
            );
          }
        })
      ],
    );
  }
}

class _Circle extends StatelessWidget {
  _Circle({@required this.active, @required this.primaryColor});

  final Color primaryColor;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(
          width: styles.Measurements.xs / 2,
        ),
        active
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
      width: styles.Measurements.s + 3,
      height: styles.Measurements.s + 3,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: styles.Colors.bgWhite, shape: BoxShape.circle),
          ),
          Center(
            child: Container(
              width: styles.Measurements.s,
              height: styles.Measurements.s,
              decoration:
                  BoxDecoration(color: primaryColor, shape: BoxShape.circle),
            ),
          ),
          Center(
            child: Container(
              width: styles.Measurements.s - 3,
              height: styles.Measurements.s - 3,
              decoration: BoxDecoration(
                  color: styles.Colors.bgWhite, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
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

class _CompletedCircle extends StatelessWidget {
  _CompletedCircle({@required this.primaryColor});

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(
          width: styles.Measurements.xs / 2,
        ),
        Container(
          width: styles.Measurements.xs,
          height: styles.Measurements.xs,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: styles.Colors.bgWhite, shape: BoxShape.circle),
              ),
              Center(
                child: Container(
                  width: styles.Measurements.xs - 3,
                  height: styles.Measurements.xs - 3,
                  decoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
        ),
        Divider(
          width: styles.Measurements.xs / 2,
        ),
      ],
    );
  }
}
