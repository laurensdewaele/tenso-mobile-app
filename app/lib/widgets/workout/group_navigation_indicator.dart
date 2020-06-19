import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:flutter/cupertino.dart' hide Icon;

class GroupNavigationIndicator extends StatelessWidget {
  GroupNavigationIndicator({
    Key key,
    @required this.primaryColor,
    @required this.count,
    @required this.activeIndex,
  }) : super(key: key);

  final Color primaryColor;
  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final List<int> list = List.generate(count, (i) => i + 1);
    return Row(
      mainAxisSize: MainAxisSize.min,
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
