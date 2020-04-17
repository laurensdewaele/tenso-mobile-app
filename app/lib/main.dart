import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/app.dart';
import 'package:app/services/error.dart';
import 'package:app/state/workouts_state.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await WorkoutsState().init();

  ErrorService _errorService = ErrorService();
  FlutterError.onError = (FlutterErrorDetails details) async {
    await _errorService.handleFlutterError(details);
  };

  runZoned<Future<Null>>(() async {
    runApp(new App());
  }, onError: (error, stackTrace) async {
    await _errorService.handleZonedError(error, stackTrace);
  });
}
