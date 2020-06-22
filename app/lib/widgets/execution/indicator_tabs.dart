import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart' hide Icon;

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
    final List<int> list = List.generate(count, (i) => i + 1);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ...list.map((n) {
            if (n < active) {
              return _Container(
                  content: _CompletedCircle(
                primaryColor: primaryColor,
              ));
            } else {
              return _Container(
                content: _Circle(
                  active: n == active,
                  primaryColor: primaryColor,
                ),
              );
            }
          })
        ],
      ),
    );
  }
}

class _Container extends StatelessWidget {
  _Container({Key key, @required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.5),
      child: Container(
        width: styles.Measurements.s + 3,
        height: styles.Measurements.s + 3,
        child: Center(child: content),
      ),
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
        active
            ? _ActiveCircle(primaryColor: primaryColor)
            : _NonActiveCircle(
                primaryColor: primaryColor,
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
      width: 12,
      height: 12,
      child: Stack(
        children: <Widget>[
          Container(
            decoration:
                BoxDecoration(color: primaryColor, shape: BoxShape.circle),
          ),
          Center(
            child: Container(
              width: 9,
              height: 9,
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
        Container(
          width: 12,
          height: 12,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: styles.Colors.bgWhite, shape: BoxShape.circle),
              ),
              Center(
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
