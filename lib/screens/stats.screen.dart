import 'package:flutter/cupertino.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/dialog.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/screen.dart';
import 'package:tenso_app/widgets/stats/stats_card.dart';
import 'package:tenso_app/widgets/top_navigation.dart';

class StatsScreen extends StatelessWidget {
  StatsScreen({Key key}) : super(key: key);

  void openUnavailableModal(context) {
    showAppDialog(
      context: context,
      content: _UnavailableInfo(),
      smallWidth: true,
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
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
          Expanded(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              final double _spacing = styles.Measurements.l;
              final double _padding = (constraints.maxWidth -
                      (kStatsCardDimension * 2) -
                      _spacing) /
                  2;
              return ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Divider(height: styles.Measurements.xxl),
                  GridView.count(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    padding: EdgeInsets.only(left: _padding, right: _padding),
                    crossAxisSpacing: _spacing,
                    mainAxisSpacing: _spacing,
                    children: [
                      StatsCard(
                        handleTap: () {
                          openUnavailableModal(context);
                        },
                        title: 'added weight per group',
                        disabled: true,
                        iconPath:
                            'assets/images/icons/added_weight_per_group.png',
                      ),
                      StatsCard(
                        handleTap: () {
                          openUnavailableModal(context);
                        },
                        title: 'fingers used',
                        disabled: true,
                        iconPath: 'assets/images/icons/fingers_used.png',
                      ),
                      StatsCard(
                        handleTap: () {
                          openUnavailableModal(context);
                        },
                        title: 'hang time per group',
                        disabled: true,
                        iconPath: 'assets/images/icons/hang_time_per_group.png',
                      ),
                      StatsCard(
                        handleTap: () {
                          openUnavailableModal(context);
                        },
                        title: 'perceived exertion',
                        disabled: true,
                        iconPath: 'assets/images/icons/perceived_exertion.png',
                      ),
                      StatsCard(
                        handleTap: () {
                          openUnavailableModal(context);
                        },
                        title: 'time of day',
                        disabled: true,
                        iconPath: 'assets/images/icons/time_of_day.png',
                      ),
                      StatsCard(
                        handleTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.totalHangRestTimeScreen);
                        },
                        title: 'total hang and rest time',
                        disabled: false,
                        iconPath:
                            'assets/images/icons/total_hang_rest_time.png',
                      ),
                    ],
                  ),
                  Divider(
                    height: styles.Measurements.xl,
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _UnavailableInfo extends StatelessWidget {
  _UnavailableInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'This feature is currently under development.',
          style: styles.Lato.xsBlack,
          textAlign: TextAlign.center,
        ),
        Divider(
          height: styles.Measurements.l,
        ),
        Button(
            small: true,
            displayBackground: false,
            text: 'Ok',
            handleTap: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }
}
