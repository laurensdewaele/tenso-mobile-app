/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/card.dart';

class TotalHangRestTimeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  TotalHangRestTimeChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory TotalHangRestTimeChart.withSampleData() {
    return new TotalHangRestTimeChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  _onSelectionChanged(charts.SelectionModel model) {
    final TimeSeriesSales _restTimeSeries = model.selectedDatum[0].datum;
    final TimeSeriesSales _hangTimeSeries = model.selectedDatum[1].datum;
    print(_restTimeSeries.time);
    print(_restTimeSeries.sales);
    print(_hangTimeSeries.sales);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: EdgeInsets.all(styles.Measurements.xs),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Stack(
            children: [
              _Label(
                dateTime: DateTime.now(),
                hangSeconds: 33,
                restSeconds: 73,
              ),
              charts.TimeSeriesChart(
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
                defaultRenderer: new charts.LineRendererConfig(
                    includeArea: true, stacked: true),
                domainAxis: charts.DateTimeAxisSpec(
                    renderSpec: charts.NoneRenderSpec()),
                selectionModels: [
                  new charts.SelectionModelConfig(
                    type: charts.SelectionModelType.info,
                    changedListener: _onSelectionChanged,
                  )
                ],
                primaryMeasureAxis:
                    charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
              )
            ],
          )),
        ],
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final _hangData = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];

    final _restData = [
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
        data: _hangData,
        colorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88),
        areaColorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88, a: 102),
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Rest',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: _restData,
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

class _Label extends StatelessWidget {
  const _Label({
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
