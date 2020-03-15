import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/routes/routes.dart';
import 'package:app/services/keyboard.dart';
import 'package:app/services/toast.dart';
import 'package:app/services/persistence.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/calendar_vm.dart';
import 'package:app/view_models/extra_tab_vm.dart';
import 'package:app/view_models/general_tab_vm.dart';
import 'package:app/view_models/hold_tab_vm.dart';
import 'package:app/view_models/workout_vm.dart';
import 'package:app/view_models/settings_vm.dart';
import 'package:app/view_models/sound_settings_vm.dart';

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
        Provider<KeyboardService>(
          create: (context) => KeyboardService(),
          dispose: (context, toastService) => toastService.dispose(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              AppState(Provider.of<PersistenceService>(context, listen: false)),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<AppState, WorkoutViewModel>(
          create: (context) => WorkoutViewModel(),
          update: (context, appState, workoutViewModel) =>
              workoutViewModel..update(appState),
        ),
        // TODO: This does not need to be provided on top.
        Provider<GeneralTabViewModel>(
          create: (context) => GeneralTabViewModel(
              Provider.of<WorkoutViewModel>(context, listen: false)),
          lazy: false,
        ),
        // TODO: This does not need to be provided on top.
        Provider<HoldTabViewModel>(
          create: (context) => HoldTabViewModel(
              Provider.of<ToastService>(context, listen: false),
              Provider.of<WorkoutViewModel>(context, listen: false)),
          lazy: false,
        ),
        // TODO: This does not need to be provided on top.
        Provider<ExtraTabViewModel>(
          create: (context) => ExtraTabViewModel(
              Provider.of<WorkoutViewModel>(context, listen: false)),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<AppState, SettingsViewModel>(
          create: (context) => SettingsViewModel(),
          update: (context, appState, settingsViewModel) =>
              settingsViewModel..update(appState),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<AppState, SoundSettingsViewModel>(
          create: (context) => SoundSettingsViewModel(),
          update: (context, appState, soundSettingsViewModel) =>
              soundSettingsViewModel..update(appState),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<AppState, CalendarViewModel>(
          create: (context) => CalendarViewModel(),
          update: (context, appState, calendarViewModel) =>
              calendarViewModel..update(appState),
          lazy: false,
        ),
      ],
      child: CupertinoApp(
          routes: getRoutes(context), color: styles.Colors.primary),
    );
  }
}
