import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/screen.dart';
import 'package:tenso_app/widgets/stats/filter.dart';
import 'package:tenso_app/widgets/top_navigation.dart';

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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: styles.Measurements.xs,
                  right: styles.Measurements.xs,
                  bottom: styles.Measurements.m),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Filter(
                    selectedFilter: Container(),
                    handleTap: () {},
                  ),
                  Divider(height: styles.Measurements.xs),
                  Expanded(
                      child: Card(
                    child: Container(),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
