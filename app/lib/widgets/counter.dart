import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/square.dart';

class Counter extends StatefulWidget {
  Counter({this.initialIntValue, this.description, this.handleValueChanged});

  final int initialIntValue;
  final String description;
  final void Function(int value) handleValueChanged;

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialIntValue;
  }

  void _onPlusTap() {
    setState(() {
      value = value + 1;
    });
    widget.handleValueChanged(value);
  }

  void _onMinusTap() {
    if (value > 1) {
      setState(() {
        value = value - 1;
      });
      widget.handleValueChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Square(
                height: styles.Measurements.xs + styles.Measurements.s,
                width: styles.Measurements.xs + styles.Measurements.s,
                value: value.toString(),
                difficultyColor: styles.Colors.primary,
                isSmall: true,
              ),
              SizedBox(width: styles.Measurements.s),
              Text(widget.description, style: styles.Typography.text)
            ],
          ),
          Container(
              width: styles.Measurements.xxl + styles.Measurements.m,
              height: styles.Measurements.xs + styles.Measurements.s,
              decoration: BoxDecoration(
                  borderRadius: styles.kAppBorderRadiusAll,
                  border: Border.all(color: styles.Colors.primary)),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                    onTap: _onPlusTap,
                    child: Container(
                      color: styles.Colors.translucent,
                      child: Center(
                        child: Icon(
                            iconData: CupertinoIcons.add,
                            color: styles.Colors.primary),
                      ),
                    ),
                  )),
                  Container(
                      height: double.infinity,
                      width: 1,
                      color: styles.Colors.primary),
                  Expanded(
                      child: GestureDetector(
                    onTap: _onMinusTap,
                    child: Container(
                      color: styles.Colors.translucent,
                      child: Center(
                        child: Icon(
                            iconData: IconData(0xf462,
                                fontFamily: 'CupertinoIcons',
                                fontPackage: 'cupertino_icons'),
                            color: styles.Colors.primary),
                      ),
                    ),
                  )),
                ],
              ))
        ]);
  }
}
