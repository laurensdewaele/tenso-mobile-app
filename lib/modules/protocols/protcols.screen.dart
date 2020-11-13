import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/top_navigation.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class ProtocolsScreen extends StatelessWidget {
  ProtocolsScreen({Key key}) : super(key: key);

  void _handleBackNavigation(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
        backgroundColor: styles.Colors.bgBlack,
        handleBackNavigation: () => _handleBackNavigation(context),
        child: ListView(
          children: [
            TopNavigation(
              title: 'protocols',
              dark: true,
              handleBackNavigation: () => _handleBackNavigation(context),
            ),
            Divider(height: styles.Measurements.xxl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
              child: Card(
                child: Container(
                  height: 100,
                ),
              ),
            )
          ],
        ));
  }
}
