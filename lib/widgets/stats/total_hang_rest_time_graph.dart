/// Example of a stacked area chart with custom area colors.
///
/// By default, the area skirt for a chart will be drawn with the same color as
/// the line, but with a 10% opacity assigned to it. An area color function can
/// be provided to override this with any custom color.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';

class StackedAreaCustomColorLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaCustomColorLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory StackedAreaCustomColorLineChart.withSampleData() {
    return new StackedAreaCustomColorLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  _onSelectionChanged(charts.SelectionModel model) {
    final LinearSales _sales_0 = model.selectedDatum[0].datum;
    final LinearSales _sales_1 = model.selectedDatum[1].datum;
    print(_sales_0.year);
    print(_sales_0.sales);
    print(_sales_1.sales);
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        domainAxis: charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
        selectionModels: [
          new charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: _onSelectionChanged,
          )
        ],
        primaryMeasureAxis:
            charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final myFakeDesktopData = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    var myFakeTabletData = [
      new LinearSales(0, 10),
      new LinearSales(1, 50),
      new LinearSales(2, 200),
      new LinearSales(3, 150),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Desktop',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.Color(r: 52, g: 152, b: 219),
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) => charts.Color(r: 52, g: 152, b: 219, a: 102),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeDesktopData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Tablet',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88, a: 102),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeTabletData,
      ),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
