import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart';
import 'package:app/widgets/screen.dart';

class WorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Screen(
        gradientStartColor: AppColors.bgRedStart,
        gradientStopColor: AppColors.bgRedStop,
        child: Text('testing'));
  }
}
