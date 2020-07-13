import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/empty_input.dart';

class EmptyInputAndDescription extends StatelessWidget {
  EmptyInputAndDescription({
    Key key,
    @required this.description,
    @required this.handleValueChanged,
    this.primaryColor = styles.Colors.primary,
  }) : super(key: key);

  final String description;
  final ValueChanged<String> handleValueChanged;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        EmptyInput(
          primaryColor: primaryColor,
          handleValueChanged: handleValueChanged,
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
