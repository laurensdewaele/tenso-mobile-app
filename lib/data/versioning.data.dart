import 'package:tenso_app/models/models.dart';

final List<Version> versions = [
  Version((b) => b
    ..no = '1.0.13'
    ..changelog =
        'As per u/sb52191\'s request, the timer keeps running in the background when pausing the screen (only on rest periods).\n\nAdded the ability to write comments during the workout.'
    ..date = DateTime(2020, 8, 8).toUtc()),
  Version((b) => b
    ..no = '1.0.12'
    ..changelog =
        'Added new grips. Pinch grip + chisel grip. Chisel grip is also otherwise known as the open crimp grip.'
    ..date = DateTime(2020, 8, 8).toUtc()),
  Version((b) => b
    ..no = '1.0.11'
    ..changelog =
        'Added new grips. Pinch grip + chisel grip. Chisel grip is also otherwise known as the open crimp grip.'
    ..date = DateTime(2020, 8, 8).toUtc()),
  Version((b) => b
    ..no = '1.0.10'
    ..changelog =
        'Added Beastmaker 2000.\n\nFixed bug on android when pressing the back button on the congratulations screen.'
    ..date = DateTime(2020, 8, 7).toUtc()),
];

final Versioning latestVersioning =
    Versioning((b) => b..versions.addAll(versions));
