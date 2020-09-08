import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/screen.dart';
import 'package:tenso_app/widgets/stats/stats_card.dart';
import 'package:tenso_app/widgets/toast_provider.dart';
import 'package:tenso_app/widgets/top_navigation.dart';

class StatsScreen extends StatelessWidget {
  StatsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToastProvider(
      child: Screen(
        backgroundColor: styles.Colors.bgBlack,
        handleBackNavigation: () {
          Navigator.of(context).pop();
        },
        child: Column(
          children: <Widget>[
            TopNavigation(
              handleBackNavigation: () {
                Navigator.of(context).pop();
              },
              title: 'Stats',
              dark: true,
            ),
            Divider(height: styles.Measurements.xxl),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  final double _spacing = styles.Measurements.xl;
                  final double _padding = (constraints.maxWidth -
                          (kStatsCardDimension * 2) -
                          _spacing) /
                      2;
                  return GridView.count(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    padding: EdgeInsets.only(left: _padding, right: _padding),
                    crossAxisSpacing: _spacing,
                    mainAxisSpacing: _spacing,
                    children: [],
                  );
                }),
              ),
            ),
            Divider(height: styles.Measurements.xxl)
          ],
        ),
      ),
    );
  }
}
