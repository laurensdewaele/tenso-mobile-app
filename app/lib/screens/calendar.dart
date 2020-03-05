import 'package:flutter/cupertino.dart' hide Icon;
import 'package:intl/intl.dart' show DateFormat;

import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';

DateTime _currentDate = DateTime(2019, 2, 3);
DateTime _currentDate2 = DateTime(2019, 2, 3);
String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
DateTime _targetDateTime = DateTime(2019, 2, 3);
Widget _eventIcon = new Container(
  decoration: new BoxDecoration(
      color: styles.Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(1000)),
      border: Border.all(color: styles.Colors.blue, width: 2.0)),
  child: Icon(
      iconData: IconData(0xf2d8,
          fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
      size: styles.Measurements.l,
      color: styles.Colors.primary),
);

EventList<Event> _markedDateMap = new EventList<Event>(
  events: {
    new DateTime(2019, 2, 10): [
      new Event(
        date: new DateTime(2019, 2, 10),
        title: 'Event 1',
        icon: _eventIcon,
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          color: styles.Colors.primary,
          height: 5.0,
          width: 5.0,
        ),
      ),
      new Event(
        date: new DateTime(2019, 2, 10),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 10),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ],
  },
);

// TODO: Screen and KeyboardScreen should be refactored
class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
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
                    child: Container(
                      height: 1000,
                      width: double.infinity,
                      child: CalendarCarousel<Event>(
                        todayBorderColor: styles.Colors.green,
                        onDayPressed: (DateTime date, List<Event> events) {
                          this.setState(() => _currentDate2 = date);
                          events.forEach((event) => print(event.title));
                        },
                        showOnlyCurrentMonthDate: false,
                        weekendTextStyle: TextStyle(
                          color: styles.Colors.black,
                        ),
                        thisMonthDayBorderColor: styles.Colors.lightGray,
                        markedDatesMap: _markedDateMap,
                        selectedDateTime: _currentDate2,
                        targetDateTime: _targetDateTime,
                        customGridViewPhysics: NeverScrollableScrollPhysics(),
                        markedDateCustomShapeBorder: CircleBorder(
                            side: BorderSide(color: styles.Colors.yellow)),
                        markedDateCustomTextStyle: TextStyle(
                          fontSize: 18,
                          color: styles.Colors.blue,
                        ),
                        showHeader: false,
//                         markedDateIconBuilder: (event) {
//                           return Container(
//                             color: Colors.blue,
//                           );
//                         },
                        todayTextStyle: TextStyle(
                          color: styles.Colors.blue,
                        ),
                        todayButtonColor: styles.Colors.yellow,
                        selectedDayTextStyle: TextStyle(
                          color: styles.Colors.yellow,
                        ),
                        minSelectedDate:
                            _currentDate.subtract(Duration(days: 360)),
                        maxSelectedDate: _currentDate.add(Duration(days: 360)),
                        prevDaysTextStyle: TextStyle(
                          fontSize: 16,
                          color: styles.Colors.orange,
                        ),
                        inactiveDaysTextStyle: TextStyle(
                          color: styles.Colors.green,
                          fontSize: 16,
                        ),
                        onCalendarChanged: (DateTime date) {
                          this.setState(() {
                            _targetDateTime = date;
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                        onDayLongPressed: (DateTime date) {
                          print('long pressed date $date');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]));
  }
}
