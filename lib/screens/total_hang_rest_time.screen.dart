import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/icons.dart' as icons;
import 'package:tenso_app/widgets/screen.dart';
import 'package:tenso_app/widgets/stats/filter.dart';
import 'package:tenso_app/widgets/stats/time_series.dart';
import 'package:tenso_app/widgets/top_navigation.dart';

class TotalHangRestTimeScreen extends StatelessWidget {
  TotalHangRestTimeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      backgroundColor: styles.Colors.bgBlack,
      handleBackNavigation: () {
        Navigator.of(context).pop();
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TopNavigation(
            handleBackNavigation: () {
              Navigator.of(context).pop();
            },
            title: 'total hang and rest time',
            dark: true,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: styles.Measurements.xs,
                  right: styles.Measurements.xs,
                  bottom: styles.Measurements.m),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Filter(
                    selectedFilter: Container(),
                    handleTap: () {},
                  ),
                  Divider(height: styles.Measurements.xs),
                  Expanded(
                      child: Card(
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
                            SimpleTimeSeriesChart.withSampleData(),
                          ],
                        )),
                        Divider(
                          height: styles.Measurements.xs,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print('left date');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: styles.Colors.translucent),
                                  child: Row(
                                    children: [
                                      Text(
                                        '5 sept 2020',
                                        style: styles.Staatliches.mBlack,
                                      ),
                                      Divider(
                                        width: styles.Measurements.s,
                                      ),
                                      icons.downCaretBlackL
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print('right date');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: styles.Colors.translucent),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      icons.downCaretBlackL,
                                      Divider(
                                        width: styles.Measurements.s,
                                      ),
                                      Text(
                                        '10 okt 2020',
                                        style: styles.Staatliches.mBlack,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          )
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
