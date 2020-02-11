import 'package:app/data/boards/beastmaker_1000.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/unit.dart';

final Settings basicSettings = Settings((b) => b
  ..defaultBoard = beastmaker1000.toBuilder()
  ..preparationTimer = 20
  ..unit = Unit.metric);
