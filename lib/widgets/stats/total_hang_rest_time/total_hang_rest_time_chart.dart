import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';

class TotalHangRestTimeData {
  final DateTime date;
  final int seconds;

  const TotalHangRestTimeData({
    @required this.date,
    @required this.seconds,
  });
}

class TotalHangRestTimeChart extends StatelessWidget {
  const TotalHangRestTimeChart({
    Key key,
    @required this.hangData,
    @required this.restData,
    @required this.handleSelectedDate,
  });

  final List<TotalHangRestTimeData> hangData;
  final List<TotalHangRestTimeData> restData;
  final void Function(DateTime selectedDate) handleSelectedDate;

  _onSelectionChanged(charts.SelectionModel model) {
    final TotalHangRestTimeData _restTimeData = model.selectedDatum[0].datum;
    final DateTime _selectedDate = _restTimeData.date;
    handleSelectedDate(_selectedDate);
  }

  List<charts.Series<TotalHangRestTimeData, DateTime>> _generateSeriesList() {
    return [
      new charts.Series<TotalHangRestTimeData, DateTime>(
        id: 'restData',
        domainFn: (TotalHangRestTimeData data, _) => data.date,
        measureFn: (TotalHangRestTimeData data, _) => data.seconds,
        data: restData,
        colorFn: (_, __) => charts.Color(r: 52, g: 152, b: 219),
        areaColorFn: (_, __) => charts.Color(r: 52, g: 152, b: 219, a: 102),
      ),
      new charts.Series<TotalHangRestTimeData, DateTime>(
        id: 'hangData',
        domainFn: (TotalHangRestTimeData data, _) => data.date,
        measureFn: (TotalHangRestTimeData data, _) => data.seconds,
        data: hangData,
        colorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88),
        areaColorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88, a: 102),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      _generateSeriesList(),
      behaviors: [
        charts.InitialSelection(selectedDataConfig: [
          new charts.SeriesDatumConfig<DateTime>('hangData', hangData[0].date)
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
      domainAxis: charts.DateTimeAxisSpec(renderSpec: charts.NoneRenderSpec()),
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
