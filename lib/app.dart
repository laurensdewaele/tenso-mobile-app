import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        navigatorKey: NavigationService().navigatorKey,
        routes: getRoutes(context),
        color: styles.Colors.primary);
  }
}
