import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input.dart';

class NumberInputAndDescription<T> extends StatelessWidget {
  NumberInputAndDescription({
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
        NumberInput<T>(
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
