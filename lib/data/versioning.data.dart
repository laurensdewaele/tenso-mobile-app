import 'package:tenso_app/models/models.dart';

final List<Version> _versions = [
  Version((b) => b
    ..no = '1.0.24'
    ..incrementalNo = 24
    ..changelog.addAll([
      'Added the Trango rock prodigy training center hangboard.',
    ])
    ..date = DateTime(2020, 10, 17).toUtc()),
  Version((b) => b
    ..no = '1.0.23'
    ..incrementalNo = 23
    ..changelog.addAll([
      'Replaced the completed workout overview with a detailed graph.',
    ])
    ..date = DateTime(2020, 10, 7).toUtc()),
  Version((b) => b
    ..no = '1.0.22'
    ..incrementalNo = 22
    ..changelog.addAll([
      'Added the Metolius - Wood grips II compact board',
      'Fixed a bug where on the \'adjust hangs\' screen, the added weight would not be registered.',
    ])
    ..date = DateTime(2020, 9, 29).toUtc()),
  Version((b) => b
    ..no = '1.0.21'
    ..incrementalNo = 21
    ..changelog.addAll([
      'Added the first progress statistic, a graph to measure your total hang and rest time.',
      'Added the Metolius - Simulator 3D board.',
      'Added the Defy the crux - The log board.'
    ])
    ..date = DateTime(2020, 9, 16).toUtc()),
  Version((b) => b
    ..no = '1.0.20'
    ..incrementalNo = 20
    ..changelog.addAll(['Fixed other navigation errors.'])
    ..date = DateTime(2020, 8, 24).toUtc()),
  Version((b) => b
    ..no = '1.0.19'
    ..incrementalNo = 19
    ..changelog.addAll(['Fixed navigation bug on the settings screen.'])
    ..date = DateTime(2020, 8, 24).toUtc()),
  Version((b) => b
    ..no = '1.0.18'
    ..incrementalNo = 18
    ..changelog.addAll([
      'Added awesome woodys boards. Cliff board mini + the home boy',
      'Fixed date display on the calendar screen.',
    ])
    ..date = DateTime(2020, 8, 22).toUtc()),
  Version((b) => b
    ..no = '1.0.17'
    ..incrementalNo = 17
    ..changelog.addAll([
      'Added the ability to edit completed workouts.',
      'Progress is automatically saved when editing a workout, group or completed workout.'
    ])
    ..date = DateTime(2020, 8, 20).toUtc()),
  Version((b) => b
    ..no = '1.0.16'
    ..incrementalNo = 16
    ..changelog.addAll([
      'Fixed bug on IOS where the keyboard would not show a minus sign for entering negative weights.'
    ])
    ..date = DateTime(2020, 8, 12).toUtc()),
  Version((b) => b
    ..no = '1.0.15'
    ..incrementalNo = 15
    ..changelog.addAll([
      'Added the Grindstone Mk2 from Tension Climbing.',
      'Fixed a bug where a climber would become stuck in the app whilst trying to edit a group.'
    ])
    ..date = DateTime(2020, 8, 12).toUtc()),
  Version((b) => b
    ..no = '1.0.14'
    ..incrementalNo = 14
    ..changelog.addAll([
      'Added the Transgression hangboard.',
    ])
    ..date = DateTime(2020, 8, 11).toUtc()),
  Version((b) => b
    ..no = '1.0.13'
    ..incrementalNo = 13
    ..changelog.addAll([
      'Added e-mail address option on the feedback section, so we can get back to you.',
      'Fixed bug on IOS where comma input on numbers would not be accepted.'
    ])
    ..date = DateTime(2020, 8, 10).toUtc()),
  Version((b) => b
    ..no = '1.0.12'
    ..incrementalNo = 12
    ..changelog.addAll(['Added pinch grip.'])
    ..date = DateTime(2020, 8, 9).toUtc()),
  Version((b) => b
    ..no = '1.0.11'
    ..incrementalNo = 11
    ..changelog.addAll([
      'Added chisel grip. Chisel grip is also otherwise known as the open crimp grip.'
    ])
    ..date = DateTime(2020, 8, 8).toUtc()),
  Version((b) => b
    ..no = '1.0.10'
    ..incrementalNo = 10
    ..changelog.addAll([
      'Added Beastmaker 2000',
      'Fixed bug on android when pressing the back button on the congratulations screen.'
    ])
    ..date = DateTime(2020, 8, 7).toUtc()),
];

final Versioning latestVersioning =
    Versioning((b) => b..versions.addAll(_versions));

final Version latestVersion = _versions[0];
