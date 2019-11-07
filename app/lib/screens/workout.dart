import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/screen.dart';

class WorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Screen(
        gradientStartColor: styles.Colors.primary,
        gradientStopColor: styles.Colors.bgRedStop,
        child: Text('testing'));
  }
}
