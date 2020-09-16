import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/modules/calendar/calendar.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/top_navigation.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class CalendarScreen extends StatelessWidget {
  CalendarScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
        handleBackNavigation: () {
          Navigator.of(context).pop();
        },
        child: ListView(physics: ClampingScrollPhysics(), children: [
          Column(
            children: <Widget>[
              TopNavigation(
                title: 'history',
              ),
              Divider(height: styles.Measurements.xxl),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: styles.Measurements.m,
                      right: styles.Measurements.m,
                      top: styles.Measurements.m,
                      bottom: styles.Measurements.l,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Calendar()],
                    ),
                  ),
                ),
              ),
              Divider(height: styles.Measurements.xxl)
            ],
          )
        ]));
  }
}
