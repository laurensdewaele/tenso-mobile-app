import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/routes/routes.dart';
import 'package:app/services/audio_player.dart';
import 'package:app/services/keyboard.dart';
import 'package:app/services/persistence.dart';
import 'package:app/services/toast.dart';
import 'package:app/state/workouts_state.dart';
import 'package:app/state/completed_workouts_state.dart';
import 'package:app/styles/styles.dart' as styles;

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
      ],
      child: CupertinoApp(
          routes: getRoutes(context), color: styles.Colors.primary),
    );
  }
}
