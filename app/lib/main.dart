import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/app.dart';
import 'package:app/services/error.dart';
import 'package:app/state/completed_workouts_state.dart';
import 'package:app/state/settings_state.dart';
import 'package:app/state/user_state.dart';
import 'package:app/state/workouts_state.dart';

Future<Null> main() async {
  ErrorService _errorService = ErrorService();
  FlutterError.onError = (FlutterErrorDetails details) async {
    await _errorService.handleFlutterError(details);
  };

  runZoned<Future<Null>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final futures = <Future>[
      WorkoutsState().init(),
      CompletedWorkoutsState().init(),
      SettingsState().init(),
      UserState().init()
    ];

    await Future.wait(futures);

    runApp(new App());
  }, onError: (error, stackTrace) async {
    await _errorService.handleZonedError(error, stackTrace);
  });
}
