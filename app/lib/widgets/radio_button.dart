import 'package:flutter/cupertino.dart';

import 'package:app/models/hand_hold.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/styles/styles.dart' as styles;

class RadioButton extends StatelessWidget {
  RadioButton(
      {@required this.active,
      @required this.description,
      @required this.value,
      @required this.handleSelected});

  final bool active;
  final String description;
  final HandHolds value;
  final Function(HandHolds value) handleSelected;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleSelected(value);
      },
      child: Container(
        height: styles.Measurements.xl,
        width: double.infinity,
        decoration: BoxDecoration(color: styles.Colors.translucent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            active ? _ActiveCircle() : _NonActiveCircle(),
            Divider(
              width: styles.Measurements.m,
            ),
            Text(
              description,
              style: styles.Typography.text,
            )
          ],
        ),
      ),
    );
  }
}

class _ActiveCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.Measurements.m,
      height: styles.Measurements.m,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: styles.Colors.primary, shape: BoxShape.circle),
          ),
          Center(
            child: Container(
              width: styles.Measurements.s,
              height: styles.Measurements.s,
              decoration: BoxDecoration(
                  color: styles.Colors.bgWhite, shape: BoxShape.circle),
            ),
          ),
          Center(
            child: Container(
              width: styles.Measurements.xs,
              height: styles.Measurements.xs,
              decoration: BoxDecoration(
                  color: styles.Colors.primary, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}

class _NonActiveCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.Measurements.m,
      height: styles.Measurements.m,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: styles.Colors.gray, shape: BoxShape.circle),
          ),
          Center(
            child: Container(
              width: styles.Measurements.s,
              height: styles.Measurements.s,
              decoration: BoxDecoration(
                  color: styles.Colors.bgWhite, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
