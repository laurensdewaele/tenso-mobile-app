import 'package:flutter/cupertino.dart';

import 'package:app/routes/routes.dart';
import 'package:app/services/navigation.dart';
import 'package:app/styles/styles.dart' as styles;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      navigatorKey: NavigationService().navigatorKey,
        routes: getRoutes(context), color: styles.Colors.primary);
  }
}
