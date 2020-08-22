import 'package:flutter/cupertino.dart';
import 'package:tenso_app/services/toast.service.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/screen.dart';
import 'package:tenso_app/widgets/toast_message.dart';
import 'package:tenso_app/widgets/toast_provider.dart';
import 'package:tenso_app/widgets/top_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class ProgressScreen extends StatelessWidget {
  ProgressScreen({Key key}) : super(key: key);

  Future<void> _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      ToastService().add(ToastMessages.failedBrowserLaunch());
    }
  }

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
              title: 'Progress',
              dark: true,
            ),
            Divider(height: styles.Measurements.xxl),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
                child: Card(
                  padding: const EdgeInsets.only(
                    left: styles.Measurements.m,
                    right: styles.Measurements.m,
                    top: styles.Measurements.m,
                    bottom: styles.Measurements.l,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text(
                            'We are working on designing and building screens that will display your progression in various ways. In the mean time, keep training and log data. Hang in there!',
                            style: styles.Lato.xsBlack,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(height: styles.Measurements.xxl)
          ],
        ),
      ),
    );
  }
}
