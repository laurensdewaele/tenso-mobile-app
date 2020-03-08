import 'package:app/widgets/calendar/header.dart';
import 'package:flutter/cupertino.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleSelectedMonthTap() {
    print('selected month tap');
  }

  @override
  Widget build(BuildContext context) {
    final DateTime _selectedMonth = DateTime.now();

    return Column(
      children: <Widget>[
        CalendarHeader(
          selectedMonth: _selectedMonth,
          handleSelectMonthTap: _handleSelectedMonthTap,
        )
      ],
    );
  }
}
