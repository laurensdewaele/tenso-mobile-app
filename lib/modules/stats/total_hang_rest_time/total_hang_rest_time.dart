import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/modal_popup.dart';
import 'package:tenso_app/modules/stats/date_picker.dart';
import 'package:tenso_app/modules/stats/stats_date_card.dart';
import 'package:tenso_app/modules/stats/stats_filter_card.dart';
import 'package:tenso_app/modules/stats/total_hang_rest_time/total_hang_rest_time.vm.dart';
import 'package:tenso_app/modules/stats/total_hang_rest_time/total_hang_rest_time_chart.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

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
        content: StatsDatePicker(
          dates: _viewModel.state.dateRange,
          initialDate: _viewModel.state.startDate,
          handleSelectedDate: _viewModel.setStartDate,
        ));
  }

  void _handleEndDateTap() async {
    await showAppModalPopup(
        context: context,
        content: StatsDatePicker(
          dates: _viewModel.state.dateRange,
          initialDate: _viewModel.state.endDate,
          handleSelectedDate: _viewModel.setEndDate,
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModel.state.dateRange.length == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: styles.Measurements.m),
        child: Center(
          child: Text(
            'No data.\nThere must be at least one completed workout.',
            style: styles.Lato.lWhiteBold,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          StatsFilterCard(
            filteredLabel: _viewModel.state.filteredLabel,
            filteredWorkout: _viewModel.state.filteredWorkout,
            handleTap: _viewModel.handleFilterTap,
          ),
          Divider(height: styles.Measurements.xs),
          Expanded(
              child: Card(
            padding: EdgeInsets.all(styles.Measurements.xs),
            child: Stack(
              children: [
                if (_viewModel.state.hangData.length > 0)
                  _ChartLabel(
                    dateTime: _viewModel.state.selectedDateOnChart,
                    hangSeconds: _viewModel.state.hangSecondsForSelectedDate,
                    restSeconds: _viewModel.state.restSecondsForSelectedDate,
                  ),
                TotalHangRestTimeChart(
                  hangData: _viewModel.state.hangData,
                  restData: _viewModel.state.restData,
                  handleSelectedDate: _viewModel.setSelectedDateOnChart,
                ),
              ],
            ),
          )),
          Divider(height: styles.Measurements.xs),
          StatsDateCard(
            endDate: _viewModel.state.endDate,
            startDate: _viewModel.state.startDate,
            handleStartDateTap: _handleStartDateTap,
            handleEndDateTap: _handleEndDateTap,
          )
        ],
      );
    }
  }
}

class _ChartLabel extends StatelessWidget {
  const _ChartLabel({
    @required this.dateTime,
    @required this.restSeconds,
    @required this.hangSeconds,
  });

  final DateTime dateTime;
  final int restSeconds;
  final int hangSeconds;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: 'total rest: ',
              style: styles.Staatliches.xsBlack,
              children: [
                TextSpan(
                    text: '${restSeconds.toString()}s',
                    style: styles.Lato.xsBlue),
              ]),
        ),
        RichText(
          text: TextSpan(
              text: 'total tut: ',
              style: styles.Staatliches.xsBlack,
              children: [
                TextSpan(
                    text: '${hangSeconds.toString()}s',
                    style: styles.Lato.xsPrimary),
              ]),
        ),
        RichText(
          text: TextSpan(
              text: 'date: ',
              style: styles.Staatliches.xsBlack,
              children: [
                TextSpan(
                    text: '${dateTime.day}-${dateTime.month}-${dateTime.year}',
                    style: styles.Lato.xsBlack),
              ]),
        ),
      ],
    );
  }
}
