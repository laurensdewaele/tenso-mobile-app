import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/app.dart';
import 'package:tenso_app/services/error.service.dart';
import 'package:tenso_app/state/boards.state.dart';
import 'package:tenso_app/state/completed_workouts.state.dart';
import 'package:tenso_app/state/settings.state.dart';
import 'package:tenso_app/state/user.state.dart';
import 'package:tenso_app/state/workouts.state.dart';

Future<Null> main() async {
  ErrorService _errorService = ErrorService();
  FlutterError.onError = (FlutterErrorDetails details) async {
    await _errorService.handleFlutterError(details);
  };

  runZoned<Future<Null>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final futures = <Future>[
      BoardsState().init(),
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
