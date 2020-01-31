import 'package:app/data/boards/beastmaker_1000.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/unit.dart';
import 'package:app/view_models/settings.dart';

final Settings basicSettings = Settings((b) => b
  ..defaultBoard = beastmaker1000.toBuilder()
  ..preparationTimer = 20
  ..unit = Unit.metric);

// TODO: Remove
final SettingsViewModel defaultSettingsViewModel =
    SettingsViewModel(beastmaker1000, 20, null, null, Unit.metric);
