import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;

class DisplayDurationSeconds extends StatelessWidget {
  DisplayDurationSeconds({Key key, @required this.seconds}) : super(key: key);

  final int seconds;

  @override
  Widget build(BuildContext context) {
    final int _minutes = seconds ~/ 60;
    final int _remainingSeconds = seconds % 60;

    return Container(
        child: Center(
            child: RichText(
      text: TextSpan(text: null, children: [
        if (_minutes != 0)
          TextSpan(text: _minutes.toString(), style: styles.Lato.xsGray),
        if (_minutes != 0)
          TextSpan(text: ' ', style: styles.Staatliches.textDivider),
        if (_minutes != 0) TextSpan(text: 'm', style: styles.Lato.xsGray),
        if (_remainingSeconds != 0)
          TextSpan(text: '  ', style: styles.Lato.xsGray),
        if (_remainingSeconds != 0)
          TextSpan(
              text: _remainingSeconds.toString(), style: styles.Lato.xsGray),
        if (_remainingSeconds != 0)
          TextSpan(text: ' ', style: styles.Staatliches.textDivider),
        if (_remainingSeconds != 0)
          TextSpan(text: 's', style: styles.Lato.xsGray)
      ]),
    )));
  }
}
