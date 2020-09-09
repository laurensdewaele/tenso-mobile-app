/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  _onSelectionChanged(charts.SelectionModel model) {
    final TimeSeriesSales _sales_0 = model.selectedDatum[0].datum;
    final TimeSeriesSales _sales_1 = model.selectedDatum[1].datum;
    print(_sales_0.time);
    print(_sales_0.sales);
    print(_sales_1.sales);
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
        topMarginSpec: charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
        bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
      ),
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      defaultRenderer:
          new charts.LineRendererConfig(includeArea: true, stacked: true),
      domainAxis: charts.DateTimeAxisSpec(renderSpec: charts.NoneRenderSpec()),
      selectionModels: [
        new charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _onSelectionChanged,
        )
      ],
      primaryMeasureAxis:
          charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];

    final data2 = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 23),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 45),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 166),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 90),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Hang',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
        colorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88),
        areaColorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88, a: 102),
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Rest',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data2,
        colorFn: (_, __) => charts.Color(r: 52, g: 152, b: 219),
        areaColorFn: (_, __) => charts.Color(r: 52, g: 152, b: 219, a: 102),
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
