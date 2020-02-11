import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/routes/routes.dart';
import 'package:app/services/toast.dart';
import 'package:app/services/persistence.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/extra_tab_vm.dart';
import 'package:app/view_models/general_tab_vm.dart';
import 'package:app/view_models/hold_tab_vm.dart';
import 'package:app/view_models/new_or_edit_workout_vm.dart';
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
        Provider<ToastService>(
          create: (context) => ToastService(),
          dispose: (context, toastService) => toastService.dispose(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              AppState(Provider.of<PersistenceService>(context, listen: false)),
          lazy: false,
        ),
        ProxyProvider<AppState, NewOrEditWorkoutViewModel>(
          update: (context, appState, newOrEditWorkoutViewModel) =>
              NewOrEditWorkoutViewModel(appState),
        ),
        ProxyProvider<AppState, GeneralTabViewModel>(
          update: (context, appState, generalTabViewModel) =>
              GeneralTabViewModel(appState),
          lazy: false,
        ),
        Provider<HoldTabViewModel>(
          create: (context) => HoldTabViewModel(
              Provider.of<ToastService>(context, listen: false),
              Provider.of<NewOrEditWorkoutViewModel>(context, listen: false)),
          lazy: false,
        ),
        ProxyProvider<AppState, ExtraTabViewModel>(
          update: (context, appState, extraTabViewModel) =>
              ExtraTabViewModel(appState),
          lazy: false,
        ),
        ProxyProvider<AppState, SettingsViewModel>(
          update: (context, appState, settingsViewModel) =>
              SettingsViewModel(appState),
          lazy: false,
        ),
      ],
      child: CupertinoApp(
          routes: getRoutes(context), color: styles.Colors.primary),
    );
  }
}
