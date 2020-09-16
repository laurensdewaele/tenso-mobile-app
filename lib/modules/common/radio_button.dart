import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/divider.dart';

class RadioButton<T> extends StatelessWidget {
  RadioButton(
      {@required this.active,
      @required this.description,
      @required this.value,
      this.primaryColor = styles.Colors.primary,
      @required this.handleSelected});

  final Color primaryColor;
  final bool active;
  final String description;
  final T value;
  final void Function(T value) handleSelected;

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
            active
                ? _ActiveCircle(
                    primaryColor: primaryColor,
                  )
                : _NonActiveCircle(),
            Divider(
              width: styles.Measurements.m,
            ),
            Text(
              description,
              style: styles.Lato.xsGray,
            )
          ],
        ),
      ),
    );
  }
}

class _ActiveCircle extends StatelessWidget {
  _ActiveCircle({this.primaryColor});

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.Measurements.m,
      height: styles.Measurements.m,
      child: Stack(
        children: <Widget>[
          Container(
            decoration:
                BoxDecoration(color: primaryColor, shape: BoxShape.circle),
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
              decoration:
                  BoxDecoration(color: primaryColor, shape: BoxShape.circle),
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
