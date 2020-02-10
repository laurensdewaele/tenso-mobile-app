import 'package:app/view_models/active_workout_vm.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/data/basic_settings.dart';
import 'package:app/routes/routes.dart';
import 'package:app/services/persistence.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/app_state_vm.dart';
import 'package:app/view_models/extra_tab_vm.dart';
import 'package:app/view_models/general_tab_vm.dart';
import 'package:app/view_models/hold_tab_vm.dart';
import 'package:app/view_models/settings_vm.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PersistenceService>(
          create: (context) => PersistenceService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              AppState(Provider.of<PersistenceService>(context, listen: false)),
          lazy: false,
        ),
        ProxyProvider<AppState, GeneralTabViewModel>(
          update: (context, appState, generalTabViewModel) =>
              GeneralTabViewModel(appState),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<AppState, ActiveWorkoutViewModel>(
          create: (context) => ActiveWorkoutViewModel(context),
          update: (context, appState, activeWorkoutViewModel) =>
          activeWorkoutViewModel..update(context, appState),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<AppState, HoldTabViewModel>(
          create: (context) => HoldTabViewModel(),
          update: (context, appState, holdTabViewModel) =>
              holdTabViewModel..update(appState),
          lazy: false,
        ),
        ProxyProvider<AppState, ExtraTabViewModel>(
          update: (context, appState, extraTabViewModel) =>
              ExtraTabViewModel(appState),
          lazy: false,
        ),
        // TODO: Refactor
        ChangeNotifierProvider<SettingsViewModel>(
          create: (context) => defaultSettingsViewModel,
        ),
      ],
      child: CupertinoApp(
          routes: getRoutes(context), color: styles.Colors.primary),
    );
  }
}
