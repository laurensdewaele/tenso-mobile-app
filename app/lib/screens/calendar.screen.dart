import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/calendar/calendar.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:flutter/cupertino.dart' hide Icon;

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity > 0) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Screen(
          gradientStartColor: styles.Colors.bgGrayStart,
          gradientStopColor: styles.Colors.bgGrayStop,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: styles.Measurements.m,
                          vertical: styles.Measurements.l),
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
          ])),
    );
  }
}
