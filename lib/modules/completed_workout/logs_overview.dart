import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
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
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: deviceHeight - styles.Measurements.xxl,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HorizontalGroupOverviewWithIndicator(
            groups: widget.groups,
            handleVisibleGroupIndex: _viewModel.setActiveGroupIndex,
          ),
          Expanded(
              child: LogsOverviewChart(
            weightUnit: _viewModel.weightUnit,
            handleSelection: _viewModel.handleSelection,
            maxWeightAxisValue: _viewModel.maxWeightAxisValue,
            minWeightAxisValue: _viewModel.minWeightAxisValue,
            sequenceTimerLogs: _viewModel.activeLogsForGroup,
          )),
          _LogsOverviewChartLabel(
            weightUnit: _viewModel.selectedLog.weightSystem.unit,
            effectiveAddedWeight: _viewModel.selectedLog.effectiveAddedWeight,
            originalAddedWeight: _viewModel.selectedLog.originalAddedWeight,
            effectiveDurationMs: _viewModel.selectedLog.effectiveDurationMs,
            originalDurationS: _viewModel.selectedLog.originalDurationS,
            sequenceTimerType: _viewModel.selectedLog.type,
          )
        ],
      ),
    );
  }
}

class _LogsOverviewChartLabel extends StatelessWidget {
  final double effectiveDurationMs;
  final double originalAddedWeight;
  final double effectiveAddedWeight;
  final String weightUnit;
  final int originalDurationS;
  final SequenceTimerType sequenceTimerType;

  const _LogsOverviewChartLabel(
      {@required this.effectiveDurationMs,
      @required this.originalAddedWeight,
      @required this.effectiveAddedWeight,
      @required this.weightUnit,
      @required this.originalDurationS,
      @required this.sequenceTimerType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                  text: 'type: ',
                  style: styles.Staatliches.xxsBlack,
                  children: [
                    TextSpan(
                        text: '${sequenceTimerType.toString()}',
                        style: styles.Lato.xxsGray),
                  ]),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                  text: 'original duration: ',
                  style: styles.Staatliches.xxsBlack,
                  children: [
                    TextSpan(
                        text: '${originalDurationS}s',
                        style: styles.Lato.xxsGray),
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: 'original added weight: ',
                  style: styles.Staatliches.xxsBlack,
                  children: [
                    TextSpan(
                        text: '$originalAddedWeight$weightUnit',
                        style: styles.Lato.xxsGray),
                  ]),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                  text: 'effective duration: ',
                  style: styles.Staatliches.xxsBlack,
                  children: [
                    TextSpan(
                        text: '${effectiveDurationMs ~/ 1000}s',
                        style: styles.Lato.xxsGray),
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: 'effective added weight: ',
                  style: styles.Staatliches.xxsBlack,
                  children: [
                    TextSpan(
                        text: '$effectiveAddedWeight$weightUnit',
                        style: styles.Lato.xxsGray),
                  ]),
            ),
          ],
        )
      ],
    );
  }
}
