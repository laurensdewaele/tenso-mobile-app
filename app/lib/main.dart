import 'package:flutter/cupertino.dart';

import 'package:app/routes/routes.dart';
import 'package:app/styles/styles.dart' as styles;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        routes: getRoutes(context), color: styles.Colors.primary);
  }
}
