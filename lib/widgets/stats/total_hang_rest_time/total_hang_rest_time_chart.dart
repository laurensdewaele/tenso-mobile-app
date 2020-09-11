import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class TotalHangRestTimeData {
  final DateTime date;
  final int seconds;

  const TotalHangRestTimeData({
    @required this.date,
    @required this.seconds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalHangRestTimeData &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          seconds == other.seconds;

  @override
  int get hashCode => date.hashCode ^ seconds.hashCode;

  @override
  String toString() {
    return 'TotalHangRestTimeData{date: $date, seconds: $seconds}';
  }
}

class TotalHangRestTimeChart extends StatefulWidget {
  const TotalHangRestTimeChart({
    @required this.hangData,
    @required this.restData,
    @required this.handleSelectedDate,
  });

  final List<TotalHangRestTimeData> hangData;
  final List<TotalHangRestTimeData> restData;
  final void Function(DateTime selectedDate) handleSelectedDate;

  @override
  _TotalHangRestTimeChartState createState() => _TotalHangRestTimeChartState();
}

class _TotalHangRestTimeChartState extends State<TotalHangRestTimeChart> {
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
  void didUpdateWidget(TotalHangRestTimeChart oldWidget) {
    if (oldWidget.hangData != widget.hangData ||
        oldWidget.restData != widget.restData) {
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
    final TotalHangRestTimeData _restTimeData = model.selectedDatum[0].datum;
    final DateTime _selectedDate = _restTimeData.date;
    widget.handleSelectedDate(_selectedDate);
  }

  List<charts.Series<TotalHangRestTimeData, DateTime>> _generateSeriesList() {
    return [
      new charts.Series<TotalHangRestTimeData, DateTime>(
        id: 'restData',
        domainFn: (TotalHangRestTimeData data, _) => data.date,
        measureFn: (TotalHangRestTimeData data, _) => data.seconds,
        data: widget.restData,
        colorFn: (_, __) => charts.Color(r: 52, g: 152, b: 219),
        areaColorFn: (_, __) => charts.Color(r: 52, g: 152, b: 219, a: 102),
      ),
      new charts.Series<TotalHangRestTimeData, DateTime>(
        id: 'hangData',
        domainFn: (TotalHangRestTimeData data, _) => data.date,
        measureFn: (TotalHangRestTimeData data, _) => data.seconds,
        data: widget.hangData,
        colorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88),
        areaColorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88, a: 102),
      ),
    ];
  }

  Widget _buildChart(BuildContext context) {
    if (widget.hangData.length == 0) {
      return Center(
        child: Text(
          'No data for selected range',
          style: styles.Lato.lBlackBold,
        ),
      );
    } else {
      return charts.TimeSeriesChart(
        _generateSeriesList(),
        behaviors: [
          charts.InitialSelection(selectedDataConfig: [
            new charts.SeriesDatumConfig<DateTime>(
                'hangData', widget.hangData[0].date)
          ])
        ],
        layoutConfig: charts.LayoutConfig(
          leftMarginSpec: charts.MarginSpec.fixedPixel(0),
          topMarginSpec: charts.MarginSpec.fixedPixel(0),
          rightMarginSpec: charts.MarginSpec.fixedPixel(0),
          bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
        ),
        animate: false,
        // Optionally pass in a [DateTimeFactory] used by the chart. The factory
        // should create the same type of [DateTime] as the data provided. If none
        // specified, the default creates local date time.
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        defaultRenderer: new charts.LineRendererConfig(
            includeLine: true,
            includePoints: true,
            strokeWidthPx: 2,
            includeArea: true,
            stacked: false,
            radiusPx: 3),
        domainAxis:
            charts.DateTimeAxisSpec(renderSpec: charts.NoneRenderSpec()),
        selectionModels: [
          charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: _onSelectionChanged,
          )
        ],
        primaryMeasureAxis:
            charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_chart == null || _rebuild == true) {
      _chart = _buildChart(context);
    }
    return _chart;
  }
}
