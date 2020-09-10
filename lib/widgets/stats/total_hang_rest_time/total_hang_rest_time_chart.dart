/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/card.dart';

// TODO: Look to animate?

class TotalHangRestTimeSelectedDate {
  final DateTime date;
  final int hangSeconds;
  final int restSeconds;

  const TotalHangRestTimeSelectedDate({
    @required this.date,
    @required this.hangSeconds,
    @required this.restSeconds,
  });
}

class TotalHangRestTimeData {
  final DateTime date;
  final int seconds;

  const TotalHangRestTimeData({
    @required this.date,
    @required this.seconds,
  });
}

class TotalHangRestTimeChart extends StatefulWidget {
  final List<TotalHangRestTimeData> hangData;
  final List<TotalHangRestTimeData> restData;

  const TotalHangRestTimeChart({
    Key key,
    @required this.hangData,
    @required this.restData,
  });

  @override
  _TotalHangRestTimeChartState createState() => _TotalHangRestTimeChartState();
}

class _TotalHangRestTimeChartState extends State<TotalHangRestTimeChart> {
  DateTime _selectedDate;
  int _selectedDateHangSeconds;
  int _selectedDateRestSeconds;

  @override
  void initState() {
    _selectedDate = widget.hangData[0].date;
    _selectedDateHangSeconds = widget.hangData[0].seconds;
    _selectedDateRestSeconds = widget.restData[0].seconds;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onSelectionChanged(charts.SelectionModel model) {
    final TotalHangRestTimeData _restTimeData = model.selectedDatum[0].datum;
    final TotalHangRestTimeData _hangTimeData = model.selectedDatum[1].datum;
    setState(() {
      _selectedDate = _restTimeData.date;
      _selectedDateHangSeconds = _hangTimeData.seconds;
      _selectedDateRestSeconds = _restTimeData.seconds;
    });
  }

  List<charts.Series<TotalHangRestTimeData, DateTime>> _generateSeriesList() {
    return [
      new charts.Series<TotalHangRestTimeData, DateTime>(
        id: 'hangData',
        domainFn: (TotalHangRestTimeData data, _) => data.date,
        measureFn: (TotalHangRestTimeData data, _) => data.seconds,
        data: widget.hangData,
        colorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88),
        areaColorFn: (_, __) => charts.Color(r: 220, g: 88, b: 88, a: 102),
      ),
      new charts.Series<TotalHangRestTimeData, DateTime>(
        id: 'restData',
        domainFn: (TotalHangRestTimeData data, _) => data.date,
        measureFn: (TotalHangRestTimeData data, _) => data.seconds,
        data: widget.restData,
        colorFn: (_, __) => charts.Color(r: 52, g: 152, b: 219),
        areaColorFn: (_, __) => charts.Color(r: 52, g: 152, b: 219, a: 102),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: EdgeInsets.all(styles.Measurements.xs),
      child: Stack(
        children: [
          charts.TimeSeriesChart(
            _generateSeriesList(),
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
            defaultRenderer:
                new charts.LineRendererConfig(includeArea: true, stacked: true),
            domainAxis:
                charts.DateTimeAxisSpec(renderSpec: charts.NoneRenderSpec()),
            selectionModels: [
              new charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: _onSelectionChanged,
              )
            ],
            primaryMeasureAxis:
                charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
          ),
          _Label(
            dateTime: _selectedDate,
            hangSeconds: _selectedDateHangSeconds,
            restSeconds: _selectedDateRestSeconds,
          ),
        ],
      ),
    );
  }
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
