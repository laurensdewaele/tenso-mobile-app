import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_2.dart';

class NumberInputAndDescription2<T> extends StatelessWidget {
  NumberInputAndDescription2({
    Key key,
    @required this.description,
    this.enabled = true,
    @required this.handleValueChanged,
    @required this.initialValue,
    this.primaryColor = styles.Colors.primary,
  }) : super(key: key);

  final String description;
  final bool enabled;
  final ValueChanged<String> handleValueChanged;
  final Color primaryColor;
  final T initialValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Number2Input<T>(
          enabled: enabled,
          primaryColor: primaryColor,
          handleValueChanged: handleValueChanged,
          initialValue: initialValue,
        ),
        Divider(
          width: styles.Measurements.s,
        ),
        Expanded(
          child: Text(description,
              style: styles.Lato.xsGray, overflow: TextOverflow.clip),
        )
      ],
    );
  }
}
