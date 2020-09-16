import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/top_navigation.dart';
import 'package:tenso_app/modules/stats/total_hang_rest_time/total_hang_rest_time.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class TotalHangRestTimeScreen extends StatelessWidget {
  TotalHangRestTimeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      backgroundColor: styles.Colors.bgBlack,
      handleBackNavigation: () {
        Navigator.of(context).pop();
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TopNavigation(
            handleBackNavigation: () {
              Navigator.of(context).pop();
            },
            title: 'total hang and rest time',
            dark: true,
          ),
          Divider(
            height: styles.Measurements.s,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: styles.Measurements.xs,
                  right: styles.Measurements.xs,
                  bottom: styles.Measurements.xs),
              child: TotalHangRestTime(),
            ),
          )
        ],
      ),
    );
  }
}
