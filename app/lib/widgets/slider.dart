import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/input_description.dart';
import 'package:app/widgets/dividers.dart';

class Slider extends StatefulWidget {
  Slider(
      {@required this.initialIntValue,
      @required this.description,
      @required this.handleValueChanged,
      @required this.minIntValue,
      @required this.maxIntValue});

  final int minIntValue;
  final int maxIntValue;
  final int initialIntValue;
  final String description;
  final void Function(int value) handleValueChanged;

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  double value;

  @override
  void initState() {
    super.initState();
    value = widget.initialIntValue.toDouble();
  }

  void _onChanged(double v) {
    setState(() {
      value = v;
    });
    print(value);
    widget.handleValueChanged(value.round());
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      InputDescription(value: value.round(), description: widget.description),
      Divider(height: styles.Measurements.xs),
      Container(
        width: double.infinity,
        child: CupertinoSlider(
          value: value,
          onChanged: _onChanged,
          min: widget.minIntValue.toDouble(),
          max: widget.maxIntValue.toDouble(),
          activeColor: styles.Colors.primary,
          divisions: (widget.maxIntValue - widget.minIntValue),
        ),
      )
    ]);
  }
}
