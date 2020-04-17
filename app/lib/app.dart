import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/routes/routes.dart';
import 'package:app/services/audio_player.dart';
import 'package:app/services/keyboard.dart';
import 'package:app/services/persistence.dart';
import 'package:app/services/toast.dart';
import 'package:app/state/app_state.dart';
import 'package:app/state/workouts_state.dart';
import 'package:app/state/completed_workouts_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/settings_vm.dart';
import 'package:app/view_models/sound_settings_vm.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PersistenceService>(
          create: (context) => PersistenceService(),
          lazy: false,
        ),
        Provider<AudioPlayerService>(
          create: (context) => AudioPlayerService(),
          dispose: (context, audioPlayerService) =>
              audioPlayerService.dispose(),
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
        Provider<WorkoutsState>(
          create: (context) => WorkoutsState(),
          dispose: (context, workoutsState) => workoutsState.dispose(),
          lazy: false,
        ),
        Provider<CompletedWorkoutsState>(
          create: (context) => CompletedWorkoutsState(),
          dispose: (context, completedWorkoutsState) =>
              completedWorkoutsState.dispose(),
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
      ],
      child: CupertinoApp(
          routes: getRoutes(context), color: styles.Colors.primary),
    );
  }
}
