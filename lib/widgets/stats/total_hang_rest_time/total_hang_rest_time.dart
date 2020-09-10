import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/view_models/stats/total_hang_rest_time.vm.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/modal_popup.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/date_picker.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/stats_date.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/stats_filter.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/total_hang_rest_time_chart.dart';

class TotalHangRestTime extends StatefulWidget {
  TotalHangRestTime({Key key}) : super(key: key);

  @override
  _TotalHangRestTimeState createState() => _TotalHangRestTimeState();
}

class _TotalHangRestTimeState extends State<TotalHangRestTime> {
  TotalHangRestTimeViewModel _viewModel;

  @override
  void initState() {
    _viewModel = TotalHangRestTimeViewModel();
    _viewModel.addListener(_viewModelListener);
    super.initState();
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _viewModel.removeListener(_viewModelListener);
    super.dispose();
  }

  void _handleStartDateTap() async {
    await showAppModalPopup(
        context: context,
        content: DatePicker(
          dates: _viewModel.state.dateRange,
          initialDate: _viewModel.state.startDate,
          handleSelectedDate: _viewModel.setStartDate,
        ));
  }

  void _handleEndDateTap() async {
    await showAppModalPopup(
        context: context,
        content: DatePicker(
          dates: _viewModel.state.dateRange,
          initialDate: _viewModel.state.endDate,
          handleSelectedDate: _viewModel.setEndDate,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        StatsFilter(
          rangeFilter: null,
          handleTap: () {},
        ),
        Divider(height: styles.Measurements.xs),
        Expanded(
            child: TotalHangRestTimeChart(
          hangData: _viewModel.state.hangData,
          restData: _viewModel.state.restData,
        )),
        Divider(height: styles.Measurements.xs),
        StatsDate(
          endDate: DateTime.now(),
          startDate: DateTime.now(),
          handleStartDateTap: _handleStartDateTap,
          handleEndDateTap: _handleEndDateTap,
        )
      ],
    );
  }
}
