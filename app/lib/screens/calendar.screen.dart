import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/calendar/calendar.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:flutter/cupertino.dart' hide Icon;

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
                title: 'calendar',
                dark: true,
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
