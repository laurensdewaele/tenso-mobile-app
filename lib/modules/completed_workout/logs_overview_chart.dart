import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/chart_colors.dart';

class LogsOverviewChart extends StatefulWidget {
  const LogsOverviewChart(
      {@required this.sequenceTimerLogs,
      @required this.handleSelection,
      @required this.minWeightAxisValue,
      @required this.maxWeightAxisValue,
      @required this.weightUnit});

  final List<SequenceTimerLog> sequenceTimerLogs;
  final double minWeightAxisValue;
  final double maxWeightAxisValue;
  final String weightUnit;
  final void Function(SequenceTimerLog) handleSelection;

  @override
  _LogsOverviewChartState createState() => _LogsOverviewChartState();
}

class _LogsOverviewChartState extends State<LogsOverviewChart> {
  Widget _chart;
  bool _rebuild = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(LogsOverviewChart oldWidget) {
    if (oldWidget.sequenceTimerLogs != widget.sequenceTimerLogs) {
      setState(() {
        _rebuild = true;
      });
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _rebuild = false;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  _onSelectionChanged(charts.SelectionModel model) {
    final SequenceTimerLog _log = model.selectedDatum[0].datum;
    widget.handleSelection(_log);
  }

  double _effectiveAddedWeightMeasureFn(SequenceTimerLog log, int _) {
    if (log.type == SequenceTimerType.hangTimer) {
      return log.effectiveAddedWeight;
    } else
      return null;
  }

  charts.Color _targetLineColorFn(SequenceTimerLog log, int _) {
    if (log.type == SequenceTimerType.hangTimer) {
      return ChartColors.primary;
    }
    return ChartColors.blue;
  }

  charts.Color _effectiveDurationColorFn(SequenceTimerLog log, int _) {
    if (log.skipped == true || log.stopped == true) {
      return ChartColors.gray;
    }
    if (log.effectiveDurationMs < log.originalDurationMs &&
        log.type == SequenceTimerType.hangTimer) {
      return ChartColors.lightPrimary;
    }
    if (log.effectiveDurationMs < log.originalDurationMs &&
        (log.type == SequenceTimerType.preparationTimer ||
            log.type == SequenceTimerType.fixedRestTimer)) {
      return ChartColors.lightBlue;
    }

    if (log.type == SequenceTimerType.hangTimer) {
      return ChartColors.primary;
    }
    return ChartColors.blue;
  }

  List<charts.Series<SequenceTimerLog, String>> _seriesList() {
    return [
      new charts.Series<SequenceTimerLog, String>(
        id: 'effectiveAddedWeight',
        domainFn: (SequenceTimerLog log, _) => log.index.toString(),
        measureFn: _effectiveAddedWeightMeasureFn,
        data: widget.sequenceTimerLogs,
        colorFn: (SequenceTimerLog log, __) => ChartColors.black,
      )
        ..setAttribute(charts.measureAxisIdKey, 'secondaryMeasureAxisId')
        ..setAttribute(charts.rendererIdKey, 'effectiveAddedWeightRendererId'),
      new charts.Series<SequenceTimerLog, String>(
        id: 'targetLine',
        domainFn: (SequenceTimerLog log, _) => log.index.toString(),
        measureFn: (SequenceTimerLog log, _) => log.originalDurationMs,
        data: widget.sequenceTimerLogs,
        colorFn: _targetLineColorFn,
      )..setAttribute(charts.rendererIdKey, 'targetLineRendererId'),
      new charts.Series<SequenceTimerLog, String>(
        id: 'effectiveDuration',
        domainFn: (SequenceTimerLog log, _) => log.index.toString(),
        measureFn: (SequenceTimerLog log, _) => log.effectiveDurationMs,
        data: widget.sequenceTimerLogs,
        colorFn: _effectiveDurationColorFn,
      ),
    ];
  }

  Widget _buildChart(BuildContext context) {
    return charts.BarChart(
      _seriesList(),
      behaviors: [
        charts.InitialSelection(selectedDataConfig: [
          new charts.SeriesDatumConfig<String>(
              'effectiveDuration', widget.sequenceTimerLogs[0].index.toString())
        ])
      ],
      animate: false,
      // barGroupingType: charts.BarGroupingType.stacked,
      customSeriesRenderers: [
        new charts.BarTargetLineRendererConfig<String>(
          customRendererId: 'targetLineRendererId',
          // groupingType: charts.BarGroupingType.grouped
        ),
        new charts.PointRendererConfig(
          customRendererId: 'effectiveAddedWeightRendererId',
          radiusPx: 5,
          symbolRenderer: charts.CircleSymbolRenderer(isSolid: true),
        )
      ],
      domainAxis: charts.AxisSpec<String>(renderSpec: charts.NoneRenderSpec()),
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _onSelectionChanged,
        )
      ],
      primaryMeasureAxis: new charts.NumericAxisSpec(
          showAxisLine: false,
          renderSpec: charts.GridlineRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                  fontFamily: 'Lato',
                  fontSize: 12, // size in Pts.
                  color: ChartColors.black),
              lineStyle: charts.LineStyleSpec(
                thickness: 0,
                color: ChartColors.bgWhite,
              )),
          tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
            (num d) => '${d ~/ 1000}s',
          ),
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 2)),
      secondaryMeasureAxis: new charts.NumericAxisSpec(
          viewport: charts.NumericExtents(
              widget.minWeightAxisValue, widget.maxWeightAxisValue),
          renderSpec: charts.GridlineRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                  fontFamily: 'Lato',
                  fontSize: 12, // size in Pts.
                  color: ChartColors.black),
              lineStyle: charts.LineStyleSpec(
                dashPattern: [1, 1],
                thickness: 1,
                color: ChartColors.black,
              )),
          tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
              (num d) => '$d${widget.weightUnit}'),
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 2)),
    );
    // symbolRenderer: charts.CustomSymbolRenderer(),
  }

  @override
  Widget build(BuildContext context) {
    if (_chart == null || _rebuild == true) {
      _chart = _buildChart(context);
    }
    return _chart;
  }
}
