import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:app/data/fake_data.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/workout_overview.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Screen(
        gradientStartColor: styles.Colors.bgGrayStart,
        gradientStopColor: styles.Colors.bgGrayStop,
        child: ListView.separated(
          itemCount: fakeOverviews.length,
          itemBuilder: (BuildContext context, int index) {
            return WorkoutOverview(workout: fakeOverviews[index]);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
