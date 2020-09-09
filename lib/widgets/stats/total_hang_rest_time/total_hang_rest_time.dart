import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/stats_date.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/stats_filter.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/total_hang_rest_time_chart.dart';

class TotalHangRestTime extends StatefulWidget {
  TotalHangRestTime({Key key}) : super(key: key);

  @override
  _TotalHangRestTimeState createState() => _TotalHangRestTimeState();
}

class _TotalHangRestTimeState extends State<TotalHangRestTime> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        StatsFilter(
          selectedFilter: Container(),
          handleTap: () {},
        ),
        Divider(height: styles.Measurements.xs),
        Expanded(child: TotalHangRestTimeChart.withSampleData()),
        Divider(height: styles.Measurements.xs),
        StatsDate(
          endDate: DateTime.now(),
          startDate: DateTime.now(),
          handleEndDateTap: () {},
          handleStartDateTap: () {},
        )
      ],
    );
  }
}
