import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/completed_workout/log_overview.vm.dart';
import 'package:tenso_app/modules/completed_workout/logs_overview_chart.dart';
import 'package:tenso_app/modules/horizontal_group_overview/horizonal_group_overview_with_indicator.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class LogsOverview extends StatefulWidget {
  LogsOverview({
    @required this.sequenceTimerLogs,
    @required this.groups,
    @required this.weightUnit,
  });

  final List<SequenceTimerLog> sequenceTimerLogs;
  final List<Group> groups;
  final String weightUnit;

  @override
  _LogsOverviewState createState() => _LogsOverviewState();
}

class _LogsOverviewState extends State<LogsOverview> {
  LogOverviewViewModel _viewModel;

  @override
  void initState() {
    _viewModel =
        LogOverviewViewModel(sequenceTimerLogs: widget.sequenceTimerLogs);
    _viewModel.addListener(_viewModelListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double maxHeight = constraints.maxHeight;
      return Container(
        height: maxHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HorizontalGroupOverviewWithIndicator(
              groups: widget.groups,
              handleVisibleGroupIndex: _viewModel.setActiveGroupIndex,
            ),
            _OverviewDivider(),
            Expanded(
                child: LogsOverviewChart(
              weightUnit: _viewModel.weightUnit,
              handleSelection: _viewModel.handleSelection,
              maxWeightAxisValue: _viewModel.maxWeightAxisValue,
              minWeightAxisValue: _viewModel.minWeightAxisValue,
              sequenceTimerLogs: _viewModel.activeLogsForGroup,
            )),
          ],
        ),
      );
    });
  }
}

class _OverviewDivider extends StatelessWidget {
  _OverviewDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: styles.Measurements.s),
        Container(
          height: 1,
          decoration: BoxDecoration(color: styles.Colors.lightGray),
        ),
        Divider(height: styles.Measurements.s),
      ],
    );
  }
}
