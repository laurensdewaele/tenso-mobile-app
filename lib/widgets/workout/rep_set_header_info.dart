import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

final double kRepSetHeaderWidth = 90;

class RepSetHeaderInfo extends StatelessWidget {
  const RepSetHeaderInfo({
    @required this.reps,
    @required this.sets,
  });

  final int reps;
  final int sets;

  @override
  Widget build(BuildContext context) {
    Widget _text = Text(
      'X$reps',
      style: styles.Staatliches.groupRepSetHeaderLarge,
      textAlign: TextAlign.center,
    );

    if (sets != null && sets > 1) {
      _text = Text(
        'X$reps X$sets',
        style: styles.Staatliches.groupRepSetHeaderSmall,
        textAlign: TextAlign.center,
      );
    }

    return Container(
      width: kRepSetHeaderWidth,
      child: Center(
        child: _text,
      ),
    );
  }
}
