import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/completed_workout/log_overview.vm.dart';
import 'package:tenso_app/modules/completed_workout/logs_overview_chart.dart';
import 'package:tenso_app/modules/horizontal_group_overview/horizonal_group_overview_with_indicator.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class LogsOverview extends StatefulWidget {
  LogsOverview({
    @required this.logs,
    @required this.groups,
    @required this.weightUnit,
  });

  final List<SequenceTimerLog> logs;
  final List<Group> groups;
  final String weightUnit;

  @override
  _LogsOverviewState createState() => _LogsOverviewState();
}

class _LogsOverviewState extends State<LogsOverview> {
  LogOverviewViewModel _viewModel;

  @override
  void initState() {
    _viewModel = LogOverviewViewModel(logs: widget.logs);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HorizontalGroupOverviewWithIndicator(
              groups: widget.groups,
              handleVisibleGroupIndex: _viewModel.setActiveGroupIndex,
            ),
            _OverviewDivider(),
            _GroupLogOverview(
              selectedLog: _viewModel.selectedLog,
              groupLogs: _viewModel.selectedGroupLogs,
              handleSelectedLog: _viewModel.setSelectedLog,
            ),
            _OverviewDivider(),
          ],
        ),
        // _LogOverview(
        //   selectedLog: _viewModel.selectedLog,
        //   weightUnit: widget.weightUnit,
        // )
        Container(height: 500, child: LogsOverviewChart()),
      ],
    );
  }
}

class _GroupLogOverview extends StatelessWidget {
  _GroupLogOverview(
      {Key key,
      @required this.groupLogs,
      @required this.handleSelectedLog,
      @required this.selectedLog})
      : super(key: key);

  final List<SequenceTimerLog> groupLogs;
  final void Function(SequenceTimerLog log) handleSelectedLog;
  final SequenceTimerLog selectedLog;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisSpacing: styles.Measurements.xs,
      mainAxisSpacing: styles.Measurements.xs,
      crossAxisCount: 6,
      children: <Widget>[
        ...groupLogs.map((SequenceTimerLog log) => GestureDetector(
            onTap: () => handleSelectedLog(log),
            child: _Square(
              selected: log == selectedLog,
              effectiveDurationS:
                  ((log.effectiveDurationMs / 1000).toStringAsFixed(0)),
              hangTimer: log.type == SequenceTimerType.hangTimer,
              restTimer: log.type == SequenceTimerType.fixedRestTimer ||
                  log.type == SequenceTimerType.variableRestTimer ||
                  log.type == SequenceTimerType.preparationTimer,
              skipped: log.skipped,
              stopped: log.stopped,
            )))
      ],
    );
  }
}

class _Square extends StatelessWidget {
  final bool restTimer;
  final bool hangTimer;
  final bool skipped;
  final bool stopped;
  final bool selected;
  final String effectiveDurationS;

  const _Square({
    @required this.restTimer,
    @required this.hangTimer,
    @required this.skipped,
    @required this.stopped,
    @required this.selected,
    @required this.effectiveDurationS,
  });

  @override
  Widget build(BuildContext context) {
    Color _color;
    if (hangTimer == true) {
      _color = styles.Colors.primary;
    }
    if (restTimer == true) {
      _color = styles.Colors.blue;
    }
    if (skipped == true || stopped == true) {
      _color = styles.Colors.lightGray;
    }
    return Container(
      width: styles.Measurements.xxl,
      height: styles.Measurements.xxl,
      decoration: BoxDecoration(
          borderRadius: styles.kBorderRadiusAll,
          color: _color,
          border: selected
              ? Border.all(width: 1, color: styles.Colors.black)
              : null),
      child: Center(
        child: Text(
          '$effectiveDurationS\'\'',
          style: styles.Staatliches.xsWhite,
        ),
      ),
    );
  }
}

class _LogOverview extends StatelessWidget {
  _LogOverview({Key key, @required this.selectedLog, @required this.weightUnit})
      : super(key: key);

  final SequenceTimerLog selectedLog;
  final String weightUnit;

  @override
  Widget build(BuildContext context) {
    final bool _hangTimer = selectedLog.type == SequenceTimerType.hangTimer;
    final bool _variableRestTimer =
        selectedLog.type == SequenceTimerType.variableRestTimer;

    String _status = 'completed';
    if (selectedLog.stopped == true) {
      _status = 'stopped';
    }
    if (selectedLog.skipped == true) {
      _status = 'skipped';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
              text: 'type: ',
              style: styles.Staatliches.xsBlack,
              children: [
                TextSpan(
                    text: selectedLog.type.toString(),
                    style: styles.Lato.xsBlack)
              ]),
        ),
        RichText(
          text: TextSpan(
              text: 'status: ',
              style: styles.Staatliches.xsBlack,
              children: [TextSpan(text: _status, style: styles.Lato.xsBlack)]),
        ),
        if (selectedLog.effectiveDurationMs ==
                selectedLog.originalDurationS * 1000 ||
            _variableRestTimer == true)
          RichText(
            text: TextSpan(
                text: 'duration: ',
                style: styles.Staatliches.xsBlack,
                children: [
                  TextSpan(
                      text:
                          '${(selectedLog.effectiveDurationMs / 1000).toStringAsFixed(0)}s',
                      style: styles.Lato.xsBlack)
                ]),
          ),
        if (selectedLog.effectiveDurationMs !=
                selectedLog.originalDurationS * 1000 &&
            _variableRestTimer == false)
          RichText(
            text: TextSpan(
                text: 'original duration: ',
                style: styles.Staatliches.xsBlack,
                children: [
                  TextSpan(
                      text: '${selectedLog.originalDurationS.toString()}s',
                      style: styles.Lato.xsBlack)
                ]),
          ),
        if (selectedLog.effectiveDurationMs !=
                selectedLog.originalDurationS * 1000 &&
            _variableRestTimer == false)
          RichText(
            text: TextSpan(
                text: 'effective duration: ',
                style: styles.Staatliches.xsBlack,
                children: [
                  TextSpan(
                      text:
                          '${(selectedLog.effectiveDurationMs).toStringAsFixed(0)}ms',
                      style: styles.Lato.xsBlack)
                ]),
          ),
        if (_hangTimer == true &&
            selectedLog.effectiveAddedWeight != 0 &&
            selectedLog.effectiveAddedWeight == selectedLog.originalAddedWeight)
          RichText(
            text: TextSpan(
                text: 'added weight: ',
                style: styles.Staatliches.xsBlack,
                children: [
                  TextSpan(
                      text: '${selectedLog.effectiveAddedWeight}$weightUnit',
                      style: styles.Lato.xsBlack)
                ]),
          ),
        if (_hangTimer == true &&
            selectedLog.effectiveAddedWeight != 0 &&
            selectedLog.effectiveAddedWeight != selectedLog.originalAddedWeight)
          RichText(
            text: TextSpan(
                text: 'original added weight: ',
                style: styles.Staatliches.xsBlack,
                children: [
                  TextSpan(
                      text: '${selectedLog.originalAddedWeight}$weightUnit',
                      style: styles.Lato.xsBlack)
                ]),
          ),
        if (_hangTimer == true &&
            selectedLog.effectiveAddedWeight != 0 &&
            selectedLog.effectiveAddedWeight != selectedLog.originalAddedWeight)
          RichText(
            text: TextSpan(
                text: 'effective added weight: ',
                style: styles.Staatliches.xsBlack,
                children: [
                  TextSpan(
                      text: '${selectedLog.effectiveAddedWeight}$weightUnit',
                      style: styles.Lato.xsBlack)
                ]),
          ),
      ],
    );
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
